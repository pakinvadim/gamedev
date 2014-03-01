//
//  RootLayer.h
//  BadCat
//
//  Created by Pakinvadim on 06.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//
#import "cocos2d.h"
#import "CCLayer.h"
#import "GameLevel1Layer.h"

@interface RootLayer :CCLayer
{
    CCSpriteBatchNode *_actors;
}

@property (nonatomic, retain) GameLevel1Layer *level1;
@end
