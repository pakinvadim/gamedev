//
//  MainSprite.h
//  BadCat
//
//  Created by Пакин Вадим on 27.02.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

#import "CCLayer.h"
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "CCSprite.h"

@interface RootSprite : CCSprite{
    
}
extern float const DoorAnimationDelay;

@property CGPoint PositionScale;
-(CCAnimation*) GetAnimation: (NSString*) likeName countFrame:(int) countFrame delay:(float) delay :(float) Wi :(float)Hi;
-(CCAnimation*) GetAnimation: (NSString*) likeName arrayNumbersFrame:(NSMutableArray*) arrayNumbersFrame delay:(float) delay :(float)Wi:(float)Hi;

@end
