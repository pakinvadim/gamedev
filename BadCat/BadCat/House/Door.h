//
//  Door.h
//  BadCat
//
//  Created by Pakinvadim on 08.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

typedef enum DoorType
{
    Left,
    Right,
    Top
} DoorType;

@interface Door : CCSprite
{
    
}

@property int direct;
@property DoorType Type;
@property (nonatomic)CGPoint EnterPosition;
@property (nonatomic)CGPoint ExitPosition;

//- (void) addDirect:(int) dir;
- (id)initWithType:(DoorType)type andDirect:(int)dir;

@end
