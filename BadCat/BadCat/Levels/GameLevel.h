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

@property NSMutableArray *roomArray;
@property(nonatomic,strong) Cat *cat;

-(void) addRoom:(Room*)room;
-(Room*) GetRoomWithNumber:(int)roomNumber;
//void doSome(NSString *string, NSString *sstring);

@end
