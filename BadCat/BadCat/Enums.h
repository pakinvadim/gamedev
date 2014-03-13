//
//  NSObject_Enums.h
//  BadCat
//
//  Created by Pakinvadim on 11.03.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MoveDirect{
    X ,
    Y
} MoveDirect;

typedef enum ActionSpriteState{
    ActionStateNone = 0,
    ActionStateIdle,
    ActionStateAttack,
    ActionStateWalk,
    ActionStateHurt,
    ActionStateKnockedOut
} ActionSpriteState;

typedef enum BotType{
    IsCat,
    IsMan
} BotType;

@interface NSObject ()

@end
