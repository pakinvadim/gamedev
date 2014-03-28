//
//  GameLevel.h
//  TestAnimate
//
//  Created by Pakinvadim on 11.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "CCLayer.h"
#import <GameKit/GameKit.h>
#import "cocos2d.h"

#import "Room.h"
#import "Cat.h"

@interface GameLevel : CCLayerColor
{
}

@property (nonatomic) CGPoint PositionScale;
@property(nonatomic,strong) NSMutableArray *roomArray;
@property(nonatomic,strong) Cat *cat;

-(void) addRoom:(Room*)room;
-(Room*) GetRoomWithNumber:(int)roomNumber;
-(Room*) GetRoomInPoint:(CGPoint) point;
-(Door*) GetDoorInPoint:(CGPoint) point;
//void doSome(NSString *string, NSString *sstring);

@end
