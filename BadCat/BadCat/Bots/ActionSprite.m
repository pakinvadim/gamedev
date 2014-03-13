//
//  ActionSprite.m
//  TestAnimate
//
//  Created by Pakinvadim on 10.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "ActionSprite.h"
#import "GameLevel.h"

@implementation ActionSprite

-(float)X{ return self.position.x;}
-(float)Y{ return self.position.y;}

-(id) init{
	if( self=[super init]){
        self.Speed = 150.f;
        self.DoorAnimationDelay = 0.2f;
	}
	return self;
}

-(void) setStartRoomNum:(int)startRoomNum{
    _startRoomNum = startRoomNum;
    GameLevel *actualLevel = (GameLevel*)[self parent];
    for (Room *room in actualLevel.roomArray){
        if (room.numberRoom == startRoomNum){
            self.position = ccp(room.Center.x, room.FloorPosition);
        }
    }
}

-(float) GetDurationBetween:(CGPoint)start :(CGPoint)end{
    return ccpDistance(start, end) / self.Speed;
}

-(void) Idle{
    self.actionState = ActionStateIdle;
    //self.flipX = true;
    [self runAction:self.IdleAnimate];
}
-(void) Walk{
    self.actionState = ActionStateWalk;
    [self runAction:self.WalkLeftAnimate];
}
-(void) WalkUp{
    self.actionState = ActionStateWalk;
    [self runAction:self.WalkUpAnimate];
}
-(void) WalkDown{
    self.actionState = ActionStateWalk;
    [self runAction:self.WalkDownAnimate];
}

-(void)GoTo:(CGPoint)touchPoint
{
    GameLevel *level = (GameLevel*)[self parent];
    Room *actualRoom = [self GetActualRoom];
    Door *touchDoor = [level GetDoorInPoint:touchPoint];
    Room *endRoom = [level GetRoomWithNumber:touchDoor.direct];
    CGPoint endPoint = ccp(0,0);
    if(endRoom == nil){
        endRoom = [level GetRoomInPoint:touchPoint];
        endPoint = ccp([self ConvertTouch:touchPoint].x, endRoom.FloorPosition);
    }
    if(endRoom != nil){
        {NSLog([NSString stringWithFormat:@"actual room number %d",actualRoom.numberRoom]);
        NSLog([NSString stringWithFormat:@"walk room number %d",endRoom.numberRoom]);}
        self.route2 = [self GetWalkRouteTo:endRoom andEndPoint:endPoint fromRoom:actualRoom];
        
        {
            NSString* s = @"";
            for(int i = 0; i < self.route2.count-1; i++){
                int rn = [[self.route2 objectAtIndex:i] integerValue];
                s = [NSString stringWithFormat:@"%@->%d",s,rn];
            }
            NSLog([NSString stringWithFormat:@"route: %@",s]);
        }
        
        if(!self.routeRun){
            [self stopAllActions];
            [self GoRoute:self routeData:nil];
        }
        
        /*if (self.actionState == ActionStateIdle)
         {
         [self stopAllActions];
         [self Walk];
         }
         if (self.actionState == ActionStateWalk)
         {
         /*_velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
         if (_velocity.x >= 0) self.scaleX = 1.0;
         else self.scaleX = -1.0;*/
        //CCAction *walkAction = [CCSequence actions:[CCAnimate actionWithAnimation:knockedOutAnimation], [CCBlink actionWithDuration:2.0 blinks:10.0], nil];
        
        
        
        //CCAction *walkAction = [CCSequence actions:walkAction, [CCBlink actionWithDuration:2.0 blinks:10.0], nil];
        //[self runAction:walkAction];
        
    }
}

-(void)GoRoute:(id)sender routeData:(NSMutableArray*)route1{
    if(self.route2 == nil || self.route2.count == 0){
        return;
    }
    self.routeRun = true;
    NSMutableArray* actionList = [NSMutableArray array];
    Room *room = [self GetActualRoom];
    //CCSpawn* moveAnimate = nil;
    CCSpawn *moveDown = nil;
    CCSpawn *moveX = nil;
    CCSpawn *moveUp = nil;
    CCSpawn *enterInDoor = nil;
    
    CCCallFuncO *callbackAction = nil;
    CGPoint endPosition;
    
    if(self.route2.count == 1){
        endPosition = [[self.route2 firstObject] CGPointValue];
        [self.route2 removeObject:[self.route2 firstObject]];
        self.routeRun = FALSE;
        if(endPosition.x == 0 && endPosition.y == 0) { return;}
        
        if(endPosition.x > room.MaxRightPosition) {endPosition.x = room.MaxRightPosition;}
        else if(endPosition.x < room.MaxLeftPosition) {endPosition.x = room.MaxLeftPosition;}
        
        CGPoint moveXStart = ccp(self.position.x, room.FloorPosition);
        
        moveDown = [self GetBotMoveAnimation:Y :self.position :moveXStart];
        moveX = [self GetBotMoveAnimation:X :moveXStart :endPosition];
    }
    else {
        int nextRoomNum = [[self.route2 firstObject] integerValue];
        
        { NSLog([NSString stringWithFormat:@"Next room number %d",nextRoomNum]);
        }
        GameLevel *level = (GameLevel*)[self parent];
        Door *door = [room GetDoorWithDirect:nextRoomNum];
        Room *nextRoom = [level GetRoomWithNumber:nextRoomNum];
        Door *nextDoor = [nextRoom GetDoorWithDirect:room.numberRoom];
        
        CGPoint moveXStart = ccp(self.position.x, room.FloorPosition);
        CGPoint moveUpStart = ccp(door.EnterPosition.x, room.FloorPosition);
        
        moveDown = [self GetBotMoveAnimation:Y :self.position :moveXStart];
        moveX = [self GetBotMoveAnimation:X: moveXStart :moveUpStart];
        moveUp = [self GetBotMoveAnimation:Y: moveUpStart: door.EnterPosition];
        enterInDoor = [self GetDoorMoveAnimation: door :nextDoor];
        callbackAction = [CCCallFuncO actionWithTarget: self selector: @selector(GoRoute:routeData:) object:nil];
    }
    [self AddAction:moveDown In:actionList];
    [self AddAction:moveX In:actionList];
    [self AddAction:moveUp In:actionList];
    [self AddAction:enterInDoor In:actionList];
    [self AddAction:callbackAction In:actionList];
    [self.route2 removeObject:[self.route2 firstObject]];
    //[self runAction:moveAnimate];
    [self runAction:[CCSequence actionWithArray :actionList]];
}

-(CCSpawn*) GetBotMoveAnimation:(MoveDirect) direct : (CGPoint)startPosition :(CGPoint) endPosition{
    float duration = [self GetDurationBetween:startPosition :endPosition];
    CCAnimate* animate = nil;
    CCMoveTo* move = [CCMoveTo actionWithDuration:duration position: endPosition];
    if(direct == X){
        if(startPosition.x < endPosition.x){ //RIGHT
            animate = [CCAnimate actionWithDuration:duration animation:self.WalkRightAnimation];
            self.flipX = YES;
        }
        else if(startPosition.x > endPosition.x){ //LEFT
            animate = [CCAnimate actionWithDuration:duration animation:self.walkLeftAnimation];
            self.flipX = NO;
        }
    }
    else if(direct == Y){
        self.flipX = NO;
        if(startPosition.y < endPosition.y){ //TOP
            animate = [CCAnimate actionWithDuration:duration animation:self.WalkUpAnimation];
        }
        else if(startPosition.y > endPosition.y){ //BOTTON
            animate = [CCAnimate actionWithDuration:duration animation:self.WalkDownAnimation];
        }
    }
    /*CCFiniteTimeAction aa;
    [aa seta]
    CCRepeatForever a;*/
    //[animate setDuration:duration];
    //[animate step:5];
    //[animate elapsed:5];
    //[self.walkLeftAnimation setDelayPerUnit:0.3f];
    return [CCSpawn actions:move, animate, nil];
}

-(CCSpawn*) GetDoorMoveAnimation: (Door*) inDoor :(Door*) outDoor{
    NSArray *doorsArray = [[NSArray alloc]initWithObjects:inDoor,outDoor, nil];
    CCCallFuncO *runDoorsAnim = [CCCallFuncO actionWithTarget: self selector: @selector(RunAnimationDoor:doorsArray:) object:doorsArray];
    CCDelayTime *animTime = [CCDelayTime actionWithDuration: self.DoorAnimationDelay * 5];
    CCMoveTo *move = [CCMoveTo actionWithDuration:0 position: outDoor.EnterPosition];
    return [CCSpawn actions: [CCSequence actions: [CCHide action], move, runDoorsAnim, animTime, [CCShow action], nil] ,nil];
}

-(void) RunAnimationDoor: (id)sender doorsArray:(NSArray*) doors{
    if(doors == nil || doors.count != 2){
        return;
    }
    CCAnimation* animateIn = nil;
    CCAnimation* animateOut = nil;
    Door *inDoor = [doors objectAtIndex:0];
    Door *outDoor = [doors objectAtIndex:1];
    if(inDoor.Type == Left){
        animateIn = self.DoorLeftInAnimation;
        animateOut = self.DoorRightOutAnimation;
    }
    else if(inDoor.Type == Right){
        animateIn = self.DoorRightInAnimation;
        animateOut = self.DoorLeftOutAnimation;
    }
    else if(inDoor.Type == Top){
        animateIn = self.DoorTopInAnimation;
        animateOut = self.DoorTopOutAnimation;
    }
    [inDoor runAction:[CCSequence actions:[CCAnimate actionWithAnimation:animateIn], inDoor.Closed, nil]];
    [outDoor runAction:[CCSequence actions:[CCAnimate actionWithAnimation:animateOut], outDoor.Closed, nil]];
}

-(NSMutableArray*) GetWalkRouteTo:(Room*)endRoom andEndPoint:(CGPoint) endPoint fromRoom:(Room*)actualRoom{
    NSMutableArray *minWay = [NSMutableArray array];
    if (endRoom.numberRoom != actualRoom.numberRoom) // проверяем не нажали ли туже комнату
    {
        GameLevel *level = (GameLevel*)[self parent];
        NSMutableArray *ways = [NSMutableArray array];
        NSMutableArray *tempWay = [NSMutableArray array];
        NSMutableArray *checkedRooms = [NSMutableArray array];
        [self GetWalkRouteTo:endRoom fromRoom:actualRoom inLevel:level:ways:tempWay:checkedRooms];
        
        int min = 100;
        
        for(NSMutableArray *way in ways){
            if(way.count < min){
                min = way.count;
                minWay = way;
            }
        }
    }
    [minWay addObject:[NSValue valueWithCGPoint:endPoint]];
    return minWay;
}

-(void) GetWalkRouteTo:(Room*)endRoom fromRoom:(Room*)actualRoom inLevel:(GameLevel*) level
                                 :(NSMutableArray*)ways: (NSMutableArray*)tempWay :(NSMutableArray*)checkedRooms
{
    /*NSArray *sortedRooms = [actualRoom.doors sortedArrayUsingComparator:^(Door* door1, Door* door2) {
        float door1Distance = [self DistanceBetween:door1 and:endRoom];
        float door2Distance = [self DistanceBetween:door2 and:endRoom];
        
        if (door1Distance < door2Distance) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (door1Distance > door2Distance) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];*/
    
    for(Door *door in actualRoom.doors){
        int dir = door.direct;
        [tempWay addObject:[NSNumber numberWithInteger:dir]];
        if( dir == endRoom.numberRoom){
            [ways addObject:[NSMutableArray arrayWithArray: tempWay]];
        }
        else{
            if(![checkedRooms containsObject:[NSNumber numberWithInteger:dir]]){
                
                [checkedRooms addObject: [NSNumber numberWithInteger: actualRoom.numberRoom]];
                
                [self GetWalkRouteTo:endRoom fromRoom:[level GetRoomWithNumber:dir] inLevel:level:ways:tempWay:checkedRooms];
                
                
                /*if([(NSNumber*)[routeNumRoom firstObject] integerValue] == endRoom.numberRoom)
                {
                    [routeNumRoom addObject:[NSNumber numberWithInteger:dir]];
                    return routeNumRoom;
                }*/
            }
        }
        [tempWay removeLastObject];
        //}
    }
}

-(Room*) GetActualRoom{
    GameLevel *level = (GameLevel*)[self parent];
    return [level GetRoomInPoint:ccp(level.position.x + self.position.x, level.position.y + self.position.y)];
}

-(CGFloat) DistanceBetween:(CCSprite*)sprite1 and:(CCSprite*)sprite2{
    return sqrtf((sprite1.position.x*sprite2.position.x)+(sprite1.position.y*sprite1.position.y));
}

-(void) AddAction: (CCAction*) action In:(NSMutableArray*)array{
    if(action != nil){
        [array addObject:action];
    }
}
@end
