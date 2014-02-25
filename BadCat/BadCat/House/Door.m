//
//  Door.m
//  BadCat
//
//  Created by Pakinvadim on 08.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "Door.h"
#import "Room.h"

@implementation Door

@synthesize Type;
const int IndentDoor = 50;

- (CGPoint) EnterPosition {
    Room *room = self.CurrentRoom;
    
    if(self.Type == Left){
        return ccp(room.position.x + self.position.x + IndentDoor, room.FloorPosition);
    }
    else if(self.Type == Right){
        return ccp(room.position.x + self.position.x - IndentDoor, room.FloorPosition);
    }
    else if(self.Type == Top){
        return ccp(room.position.x + self.position.x, room.FloorPosition);
    }
    return ccp(0,0);
}

- (Room*)CurrentRoom{
    return (Room*)[self parent];
}

- (id)initWithType:(DoorType)type andDirect:(int) dir
{
    if ( type == Left ){
        if(self = [super initWithFile:@"doorLeft_00.png"] ){
            [self setAnchorPoint:ccp(0, 0)];
        }
    }
    else if (type == Right){
        if(self = [super initWithFile:@"doorRight_00.png"]){
            [self setAnchorPoint:ccp(1, 0)];
        }
    }
    else if ( type == Top ){
        if(self = [super initWithFile:@"doorTop_00.png"]){
            [self setAnchorPoint:ccp(0.5, 0)];
        }
    }
    self.Type = type;
    self.direct = dir;
    self.scale = 0.30;
    return self;
}

/*- (void) addDirect:(int) dir
{
    [self.directs addObject:[NSNumber numberWithInteger:dir]];
}*/
@end
