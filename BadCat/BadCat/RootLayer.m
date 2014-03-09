//
//  RootLayer.m
//  BadCat
//
//  Created by Pakinvadim on 06.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "RootLayer.h"

@implementation RootLayer

-(id) init
{
    if(self = [super init])
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"cat.plist"];
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"cat.plist"];
        //_actors = [CCSpriteBatchNode batchNodeWithFile:@"cat.png"];
        //_actors = [CCSpriteBatchNode batchNodeWithFile:@"room1.png"];
        //[_actors.texture setAliasTexParameters];
        //[self addChild:_actors z:-5];
        
        self.ActualLevel = [[GameLevel1Layer alloc] init];
        [self addChild:self.ActualLevel];
    }
    
    return self;
}

@end
