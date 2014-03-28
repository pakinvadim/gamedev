//
//  Door.m
//  BadCat
//
//  Created by Pakinvadim on 08.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "Door.h"
#import "GameLevel.h"

@implementation Door

@synthesize Type;
const int EnterIndentDoor = 20;

- (CGPoint) PositionScale{
    GameLevel * level = [self CurrentLevel];
    return ccpAdd([self CurrentRoom].PositionScale, ccpMult(self.position, level.scale * level.scale));
}

- (CGPoint) EnterPosition {
    Room *room = self.CurrentRoom;
    if(self.Type == Left){
        return ccp(room.position.x + self.position.x + self.Width + EnterIndentDoor, room.FloorPosition);
    }
    else if(self.Type == Right){
        return ccp(room.position.x + self.position.x + self.Width - EnterIndentDoor, room.FloorPosition);
    }
    else if(self.Type == Top){
        return ccp(room.position.x + self.position.x + self.Width/2, room.FloorPosition + 20);
    }
    return ccp(0,0);
}

- (GameLevel*)CurrentLevel{
    return (GameLevel*)[[self CurrentRoom] parent];
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
        NSArray *arrayClosed = [NSArray arrayWithObjects:[NSNumber numberWithInteger:0], nil];
        NSArray *arrayOpening = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:3],[NSNumber numberWithInteger:3],[NSNumber numberWithInteger:2],[NSNumber numberWithInteger:1], nil];
        self.Closed = [CCAnimate actionWithAnimation:[self GetAnimation:fileName arrayNumbersFrame:arrayClosed delay:DoorAnimationDelay :186 :500]];
        self.Opening = [CCAnimate actionWithAnimation:[self GetAnimation:fileName arrayNumbersFrame:arrayOpening delay:DoorAnimationDelay :186 :500]];
        [self setAnchorPoint:ccp(0, 0)];
        self.
        self.Type = type;
        self.direct = dir;
        self.AnimationSprite = [[CCSprite alloc]init];
        self.AnimationSprite.position = ccp(0,0);
        [self.AnimationSprite setAnchorPoint:ccp(0,0)];
        [self addChild:self.AnimationSprite z:200];
        
        if ( type == Left || type == Right){
            self.Width = [self boundingBox].size.width/2;
            self.Height = [self boundingBox].size.height;
            if(type == Right){
                self.VisualIndentDoor = self.Width;
            }
        }
        else if ( type == Top ){
            self.Width = [self boundingBox].size.width;
            self.Height = [self boundingBox].size.height;
        }
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
        rectRoom = CGRectMake(level.position.x + room.position.x + self.position.x + self.Width,
                              level.position.y + room.position.y + self.position.y,
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
