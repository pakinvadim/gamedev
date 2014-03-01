//
//  Door.m
//  BadCat
//
//  Created by Pakinvadim on 08.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "Door.h"
#import "Room.h"
#import "GameLevel.h"

@implementation Door

@synthesize Type;
const int IndentDoor = 25;

- (float) Width{
    return [self boundingBox].size.width/2;
}

-(float) Height{
    return [self boundingBox].size.height;
}

- (CGPoint) EnterPosition {
    Room *room = self.CurrentRoom;
    GameLevel *level = (GameLevel*)[self parent];
    if(self.Type == Left){
        return ccp(room.position.x + self.position.x + self.Width, room.FloorPosition);
    }
    else if(self.Type == Right){
        return ccp(room.position.x + self.position.x + self.Width, room.FloorPosition);
    }
    else if(self.Type == Top){
        return ccp(room.position.x + self.position.x + self.Width, room.FloorPosition);
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
            [self setAnchorPoint:ccp(0, 0)];
        }
    }
    self.Type = type;
    self.direct = dir;
    self.scale = 0.30;
    return self;
}

-(bool) ContainPoint:(CGPoint) point{
    GameLevel *level = (GameLevel*)[self parent];
    Room *room = self.CurrentRoom;
    CGRect rectRoom;
    if (self.Type == Left ){
        rectRoom = CGRectMake(level.position.x + room.position.x + self.position.x,
                              level.position.y + room.position.y + self.position.y,
                              self.Width,self.Height);
    }
    else if (self.Type == Right){
        rectRoom = CGRectMake(level.position.x + room.position.x + self.position.x + self.Width,
                              level.position.y + room.position.y + self.position.y,
                              self.Width,self.Height);
    }
    else if (self.Type == Top ){
        rectRoom = CGRectMake(level.position.x + room.position.x + self.position.x + self.Width/2,
                              -level.position.y + room.position.y + self.position.y,
                              self.Width,self.Height);
    }
    
    if(CGRectContainsPoint(self.boundingBox, point)){
        NSLog([NSString stringWithFormat:@"Touch door with direct%d",self.direct]);
        return true;
    }
    return false;
}
/*- (void) addDirect:(int) dir
{
    [self.directs addObject:[NSNumber numberWithInteger:dir]];
}*/
@end
