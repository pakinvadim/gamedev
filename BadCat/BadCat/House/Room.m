//
//  Room.m
//  TestAnimate
//
//  Created by Pakinvadim on 11.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "Room.h"
#import "Door.h"

@implementation Room

const int Indent = 60;

-(CGPoint)Center{
    return ccp(self.position.x + [self boundingBox].size.width/2, self.position.y + [self boundingBox].size.height/2);
}

-(float) FloorPosition {
    return self.position.y + Indent;
}

-(id) initWithFile:(NSString *)filename andPosition:(CGPoint) positionR andNumber:(int) number
{
    if(self = [super initWithFile:filename])
    {
        self.doors = [[NSMutableArray alloc] init];
        self.position = positionR;
        [self setAnchorPoint:ccp(0, 0)];
        self.numberRoom = number;
    }
    return self;
}

-(void) AddDoorWithType:(DoorType)type andDirect:(int)dir andPositionX:(float)positionX {
    Door *door = [[Door alloc] initWithType:type andDirect:dir];
    
    if (type == Right){
        door.position = ccp([self boundingBox].size.width, 0);
    }
    else if (type == Left){
        door.position = ccp(0, 0);
    }
    else if (type == Top){
        door.position = ccp(positionX, 50);
    }
    [self.doors addObject:door];
    [self addChild:door z:150];
}

-(Door*) GetDoorWithDirect:(int) direct{
    for (Door* door in self.doors){
        if(door.direct == direct){
            return door;
        }
    }
    return nil;
}

@end