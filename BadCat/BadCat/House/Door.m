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
    return [self boundingBox].size.height-1.5;
}

- (CGPoint) EnterPosition {
    Room *room = self.CurrentRoom;
    if(self.Type == Left){
        return ccp(room.position.x + self.position.x + self.Width, room.FloorPosition);
    }
    else if(self.Type == Right){
        return ccp(room.position.x + self.position.x + self.Width, room.FloorPosition);
    }
    else if(self.Type == Top){
        return ccp(room.position.x + self.position.x + self.Width, room.FloorPosition + 50);
    }
    return ccp(0,0);
}

- (Room*)CurrentRoom{
    return (Room*)[self parent];
}

- (id)initWithType:(DoorType)type andDirect:(int) dir
{
    NSString *fileName = nil;
    if ( type == Left ){ fileName = @"doorLeft"; }
    else if (type == Right){ fileName = @"doorRight"; }
    else if ( type == Top ){ fileName = @"doorUp"; }
    
    if(self = [super initWithFile:[NSString stringWithFormat:@"%@00.png",fileName]]){
        self.Closed = [CCAnimate actionWithAnimation:[self GetAnimation:fileName countFrame:1 delay:1 :157 :420]];
        [self setAnchorPoint:ccp(0, 0)];
        self.Type = type;
        self.direct = dir;
        //self.scale = 0.45;
        return self;
    }
    return nil;
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
