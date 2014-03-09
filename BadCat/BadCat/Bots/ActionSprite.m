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
        self.Speed = 200.f;
	}
	return self;
}

-(void) setStartRoomNum:(int)startRoomNum
{
    _startRoomNum = startRoomNum;
    GameLevel *actualLevel = (GameLevel*)[self parent];
    for (Room *room in actualLevel.roomArray)
    {
        if (room.numberRoom == startRoomNum)
        {
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
    Room *endRoom = [level GetRoomInPoint:touchPoint];
    Room *actualRoom = [self GetActualRoom];
    if(endRoom.numberRoom != 0) //проверяем нажатие за пределы комнат
    {
        {NSLog([NSString stringWithFormat:@"actual room number %d",actualRoom.numberRoom]);
        NSLog([NSString stringWithFormat:@"walk room number %d",endRoom.numberRoom]);}
        NSMutableArray *way = [self GetWalkRouteTo:endRoom fromRoom:actualRoom];

        Door* touchDoor = [endRoom GetDoorInPoint:touchPoint];
        CGPoint endPoint = ccp([self ConvertTouch:touchPoint].x, endRoom.FloorPosition);
        if (touchDoor != nil){
            [way addObject:[NSNumber numberWithInteger:touchDoor.direct]];
            endPoint = ccp(0,0);
        }
        
        {
            NSString* s = @"";
            for(NSNumber* nnn in way){
                s = [NSString stringWithFormat:@"%@->%d",s,[nnn integerValue]];
            }
            NSLog([NSString stringWithFormat:@"route: %@",s]);
        }
    
        [way addObject:[NSValue valueWithCGPoint:endPoint]];
        [self stopAllActions];
        [self GoRoute:self routeData:way];
        
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

-(void)GoRoute:(id)sender routeData:(NSMutableArray*)route{
    [self stopAllActions];
    if(route == nil || route.count == 0){
        return;
    }
    
    Room *room = [self GetActualRoom];
    //CCSpawn* moveAnimate = nil;
    CCSpawn *moveToDoor = nil;
    CCMoveTo *enterDoor = nil;
    CCCallFuncO *callbackAction = nil;
    CGPoint endPosition;
    float duration;
    
    if(route.count == 1){
        endPosition = [[route firstObject] CGPointValue];
        if(endPosition.x == 0 && endPosition.y == 0) {return;}
        
        if(endPosition.x > room.MaxRightPosition) {endPosition.x = room.MaxRightPosition;}
        else if(endPosition.x < room.MaxLeftPosition) {endPosition.x = room.MaxLeftPosition;}
        
        CGPoint startPosition = self.position;
        duration = [self GetDurationBetween:startPosition :endPosition];
        
        moveToDoor = [CCMoveTo actionWithDuration:duration position: endPosition];
        [route removeObject:[route firstObject]];
    }
    else {
        int nextRoomNum = [[route firstObject] integerValue];
        
        { NSLog([NSString stringWithFormat:@"Next room number %d",nextRoomNum]);
        }
        GameLevel *level = (GameLevel*)[self parent];
        Door *door = [room GetDoorWithDirect:nextRoomNum];
        Room *nextRoom = [level GetRoomWithNumber:nextRoomNum];
        Door *nextDoor = [nextRoom GetDoorWithDirect:room.numberRoom];
        
        CGPoint startPosition = self.position;
        endPosition = door.EnterPosition;
        
        
        moveToDoor = [self GetMoveAnimation:endPosition];
        enterDoor = [CCMoveTo actionWithDuration:0 position: nextDoor.EnterPosition];
        [route removeObject:[route firstObject]];
        callbackAction = [CCCallFuncO actionWithTarget: self selector: @selector(GoRoute:routeData:) object:route];
    }
    
    
    //[self runAction:moveAnimate];
    [self runAction:moveToDoor, enterDoor, callbackAction, nil]];
}

-(CCSpawn*) GetMoveAnimation: (CGPoint) endPosition{
    CCAnimate* moveAnimate = nil;
    CGPoint startPosition = self.position;
    float duration = [self GetDurationBetween:startPosition :endPosition];
    
    if(startPosition.x < endPosition.x){
        moveAnimate = [CCAnimate actionWithDuration:duration animation:self.WalkRightAnimation restoreOriginalFrame:YES];
        //moveAnimate = self.WalkRightAnimate;
        self.flipX = YES;
    }
    else if(startPosition.x > endPosition.x){
        moveAnimate = [CCAnimate actionWithDuration:duration animation:self.walkLeftAnimation restoreOriginalFrame:YES];
        //moveAnimate = [CCAnimate actionWithAnimation:self.walkLeftAnimation];
        //moveAnimate = self.WalkRightAnimate;
        self.flipX = NO;
    }
    moveToDoor = [CCMoveTo actionWithDuration:duration position: endPosition];
    return moveAnimate;
}

-(NSMutableArray*) GetWalkRouteTo:(Room*)endRoom fromRoom:(Room*)actualRoom{
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

-(CCAnimation*) GetAnimationWithFrameNameLike: (NSString*) likeName andCountFrame:(int) countFrame andDelay:(float) delay
{
    CCArray *tempFrames = [CCArray arrayWithCapacity:countFrame];
    
    for (int i = 1; i <= countFrame; i++) {
        //CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@%02d.png",likeName,i]];
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTextureFilename:[NSString stringWithFormat:@"%@%02d.png",likeName,i] rect:CGRectMake(0, 0, 1562, 1555)];
        //CCSprite *frame = [[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"%@%02d.png",likeName,i]];
        //[frame set]
        [tempFrames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:[tempFrames getNSArray] delay:delay];
    //return [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
    //return [CCSequence actions:[CCAnimate actionWithAnimation:animation], nil, nil];
}

-(Room*) GetActualRoom{
    GameLevel *level = (GameLevel*)[self parent];
    return [level GetRoomInPoint:ccp(level.position.x + self.position.x, level.position.y + self.position.y)];
}

-(CGFloat) DistanceBetween:(CCSprite*)sprite1 and:(CCSprite*)sprite2{
    return sqrtf((sprite1.position.x*sprite2.position.x)+(sprite1.position.y*sprite1.position.y));
}

@end
