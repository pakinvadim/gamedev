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
    GameLevel *actualLevel = (GameLevel*)[self parent];
    Room *walkRoom = [self GetRoomInPoint:point];
    Room *actualRoom = [self GetRoomInPoint:ccp(actualLevel.position.x +  self.position.x,actualLevel.position.y+ self.position.y)];
    if(walkRoom.numberRoom != 0) //проверяем нажатие за пределы комнат
    {
        if (actualRoom.numberRoom != walkRoom.numberRoom) // проверяем не нажали ли туже комнату
        {
            NSLog([NSString stringWithFormat:@"actual room number %d",actualRoom.numberRoom]);
            NSLog([NSString stringWithFormat:@"walk room number %d",walkRoom.numberRoom]);
            
            NSMutableArray *routeArray = [self GetWalkRouteTo:walkRoom fromRoom:actualRoom andRoomsChechedArr:[NSMutableArray array]];
            
            for(NSNumber *num in routeArray)
            {
                NSLog([NSString stringWithFormat:@"Next room number %d",[num integerValue]]);
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
            CCAction *walkAction = [CCSequence actions:walkAction, [CCBlink actionWithDuration:2.0 blinks:10.0], nil];
            [self runAction:walkAction];
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
-(NSMutableArray*) GetWalkRouteTo:(Room*)walkRoom fromNumberRoom:(int)numberRoom andRoomsChechedArr:(NSMutableArray*) checkedRooms
{
    GameLevel *actualLevel = (GameLevel*)[self parent];
    for(Room* room in actualLevel.roomArray)
    {
        if(room.numberRoom == numberRoom)
        {
            return [self GetWalkRouteTo:walkRoom fromRoom:room andRoomsChechedArr:checkedRooms];
        }
    }
    return nil;
}
-(NSMutableArray*) GetWalkRouteTo:(Room*)walkRoom fromRoom:(Room*)actualRoom andRoomsChechedArr:(NSMutableArray*) checkedRooms
{
    //GameLevel *actualLevel = (GameLevel*)[self parent];
    //BOOL waklfinded = false;
    NSMutableArray *routeNumRoom = [NSMutableArray array];
    
    for(Door *door in actualRoom.doors)
    {
        //for (int directIndex = 0; directIndex < door.directs.count ; directIndex++)
        //{
        int dir = door.direct;
        if( dir == walkRoom.numberRoom)
        {
            [routeNumRoom addObject:[NSNumber numberWithInteger:dir]];
            return routeNumRoom;
        }
        else
        {
            if(![checkedRooms containsObject:[NSNumber numberWithInteger:dir]])
            {
                [checkedRooms addObject: [NSNumber numberWithInteger: actualRoom.numberRoom]];
                [routeNumRoom addObjectsFromArray:[self GetWalkRouteTo:walkRoom fromNumberRoom:dir andRoomsChechedArr:checkedRooms]];
                if([(NSNumber*)[routeNumRoom firstObject] integerValue] == walkRoom.numberRoom)
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
@end
