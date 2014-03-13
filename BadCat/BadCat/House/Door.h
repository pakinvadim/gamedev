//
//  Door.h
//  BadCat
//
//  Created by Pakinvadim on 08.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "RootSprite.h"
#import "cocos2d.h"
#import "Enums.h"

typedef enum DoorType{
    Left,
    Right,
    Top
} DoorType;

@interface Door : RootSprite{
}


@property (readonly) float Width;
@property (readonly) float Height;
@property int direct;
@property DoorType Type;
@property (nonatomic)CGPoint EnterPosition;
@property (nonatomic)CGPoint ExitPosition;
@property(nonatomic,strong) CCAnimate *Closed;

//- (void) addDirect:(int) dir;
- (id)initWithType:(DoorType)type andDirect:(int)dir;
- (bool) ContainPoint:(CGPoint) point;


@end
