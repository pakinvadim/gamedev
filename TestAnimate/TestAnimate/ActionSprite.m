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

-(id) init{
	if( self=[super init]){
        self.Duration = 2.5f;
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
            self.position = ccp(room.position.x + [room boundingBox].size.width/2, room.FloorPosition);
        }
    }
}

-(void) Idle
{
    self.actionState = ActionStateIdle;
    //self.flipX = true;
    [self runAction:self.idleAction];
}
-(void) Walk
{
    self.actionState = ActionStateWalk;
    [self runAction:self.walkLeftAction];
}
-(void) WalkUp
{
    
}
-(void) WalkDown
{
    
}

-(void)GoTo:(CGPoint)point
{
    GameLevel *level = (GameLevel*)[self parent];
    Room *endRoom = [self GetRoomInPoint:point];
    Room *actualRoom = [self GetActualRoom];
    if(endRoom.numberRoom != 0) //проверяем нажатие за пределы комнат
    {
        if (actualRoom.numberRoom != endRoom.numberRoom) // проверяем не нажали ли туже комнату
        {
            NSLog([NSString stringWithFormat:@"actual room number %d",actualRoom.numberRoom]);
            NSLog([NSString stringWithFormat:@"walk room number %d",endRoom.numberRoom]);
            
            
            NSMutableArray *route = [self GetWalkRouteTo:endRoom fromRoom:actualRoom inLevel:level andRoomsChechedArr:[NSMutableArray array]];
            
            NSString* s = @"";
            for(NSNumber* nnn in route.reverseObjectEnumerator){
                s = [NSString stringWithFormat:@"%@->%d",s,[nnn integerValue]];
            }
            NSLog([NSString stringWithFormat:@"route: %@",s]);
                   
            [self RunRoute:self routeData:route];
            
            
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
}

-(void)RunRoute:(id)sender routeData:(NSMutableArray*)route{
    
    //NSMutableArray *route = (NSMutableArray*)routeData;
    
    if(route == nil || route.count == 0){
        return;
    }
    
    NSNumber *roomNum = [route lastObject];
    
    NSLog([NSString stringWithFormat:@"Next room number %d",[roomNum integerValue]]);
    
    Room *room = [self GetActualRoom];
    Door *door = [room GetDoorWithDirect:[roomNum integerValue]];
    
    CCMoveTo *move = [CCMoveTo actionWithDuration:self.Duration position: door.EnterPosition];
    CCMoveTo *move2 = [CCMoveTo actionWithDuration:self.Duration position: ccp(door.EnterPosition.x - 110, door.EnterPosition.y)];
    [route removeLastObject];
    CCCallFuncO *callbackAction = [CCCallFuncO actionWithTarget: self selector: @selector(RunRoute:routeData:) object:route];
    
    [self runAction:[CCSequence actions: move, move2,callbackAction, nil]];
}

-(Room*) GetActualRoom{
    GameLevel *level = (GameLevel*)[self parent];
    return [self GetRoomInPoint:ccp(level.position.x +  self.position.x,level.position.y+ self.position.y)];
}

-(Room*) GetRoomInPoint:(CGPoint) point //Получить номер комнаты по координатам
{
    GameLevel *actualLevel = (GameLevel*)[self parent];
    
    for(Room *room in actualLevel.roomArray)
    {
        CGRect rectRoom = CGRectMake(room.position.x+actualLevel.position.x,
                                     room.position.y+actualLevel.position.y,
                                     [room boundingBox].size.width,
                                     [room boundingBox].size.height);
        if(CGRectContainsPoint(rectRoom, point))
        {
            /*NSLog([NSString stringWithFormat:@"Room %f %f %f %f",
                   room.position.x + actualLevel.position.x,
                   room.position.y + actualLevel.position.y,
                   [room boundingBox].size.width,
                   [room boundingBox].size.height]);
            
            NSLog([NSString stringWithFormat:@"point %f %f",
                   point.x,
                   point.y]);*/
            return room;
        }
    }
    return nil;
}

-(NSArray*) GetWalkRouteTo:(Room*)endRoom fromRoom:(Room*)actualRoom inLevel:(GameLevel*) level andRoomsChechedArr:(NSMutableArray*) checkedRooms
{
    NSMutableArray *routeNumRoom = [NSMutableArray array];
    
    NSArray *sortedRooms = [actualRoom.doors sortedArrayUsingComparator:^(Door* door1, Door* door2) {
        float door1Distance = [self DistanceBetween:door1 and:endRoom];
        float door2Distance = [self DistanceBetween:door2 and:endRoom];
        
        if (door1Distance < door2Distance) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (door1Distance > door2Distance) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
                          
    for(Door *door in sortedRooms)
    {
        int dir = door.direct;
        if( dir == endRoom.numberRoom)
        {
            [routeNumRoom addObject:[NSNumber numberWithInteger:dir]];
            return routeNumRoom;
        }
        else
        {
            if(![checkedRooms containsObject:[NSNumber numberWithInteger:dir]])
            {
                [checkedRooms addObject: [NSNumber numberWithInteger: actualRoom.numberRoom]];
                [routeNumRoom addObjectsFromArray:[self GetWalkRouteTo:endRoom fromRoom:[level RoomWithNumber:dir] inLevel:level andRoomsChechedArr:checkedRooms]];
                
                if([(NSNumber*)[routeNumRoom firstObject] integerValue] == endRoom.numberRoom)
                {
                    [routeNumRoom addObject:[NSNumber numberWithInteger:dir]];
                    return routeNumRoom;
                }
            }
        }
        //}
    }
    return routeNumRoom;
}

-(CCAnimation*) GetAnimationWithFrameNameLike: (NSString*) likeName andCountFrame:(int) countFrame andDelay:(float) delay
{
    CCArray *tempFrames = [CCArray arrayWithCapacity:countFrame];
    
    for (int i = 0; i < countFrame; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@%02d.png",likeName,i]];
        [tempFrames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:[tempFrames getNSArray] delay:delay];
    //return [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
    //return [CCSequence actions:[CCAnimate actionWithAnimation:animation], nil, nil];
}

-(CGFloat) DistanceBetween:(CCSprite*)sprite1 and:(CCSprite*)sprite2{
    return sqrtf((sprite1.position.x*sprite2.position.x)+(sprite1.position.y*sprite1.position.y));
}

@end
