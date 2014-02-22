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
            self.position = ccp(room.position.x + [room boundingBox].size.width/2, room.position.y+60);
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
    Room *actualRoom = [self GetRoomInPoint:ccp(level.position.x +  self.position.x,level.position.y+ self.position.y)];
    if(endRoom.numberRoom != 0) //проверяем нажатие за пределы комнат
    {
        if (actualRoom.numberRoom != endRoom.numberRoom) // проверяем не нажали ли туже комнату
        {
            NSLog([NSString stringWithFormat:@"actual room number %d",actualRoom.numberRoom]);
            NSLog([NSString stringWithFormat:@"walk room number %d",endRoom.numberRoom]);
            
            int routeArray[10] = [self GetWalkRouteTo:endRoom fromRoom:actualRoom inLevel:level andRoomsChechedArr:[NSMutableArray array]];
            
            for(int num in routeArray)
            {
                NSLog([NSString stringWithFormat:@"Next room number %d",[num integerValue]]);
                [self GoToRoomWithNumber:num from:actualRoom];
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
}

-(void)GoToRoomWithNumber:(int)goToRoomNum from:(Room*) actualRoom{
    for (Door *door in actualRoom.doors){
        if(door.direct == goToRoomNum){
            CCMoveTo *move = [CCMoveTo actionWithDuration:1 position:door.position];
            [self runAction:[CCSequence actions:move,nil,nil]];
            //while(self.position.x != door.position.x){
                //self.position.x = 5;
            //}
        }
    }
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
            NSLog([NSString stringWithFormat:@"Room %f %f %f %f",
                   room.position.x + actualLevel.position.x,
                   room.position.y + actualLevel.position.y,
                   [room boundingBox].size.width,
                   [room boundingBox].size.height]);
            
            NSLog([NSString stringWithFormat:@"point %f %f",
                   point.x,
                   point.y]);
            return room;
        }
    }
    return nil;
}

-(int*) GetWalkRouteTo:(Room*)endRoom fromRoom:(Room*)actualRoom inLevel:(GameLevel*) level andRoomsChechedArr:(NSMutableArray*) checkedRooms
{
    int routeNumRoom[] = [NSMutableArray array];
    int *sortedRooms = [actualRoom.doors sortedArrayUsingComparator:^(Door* door1, Door* door2) {
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
