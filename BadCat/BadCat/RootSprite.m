//
//  MainSprite.m
//  BadCat
//
//  Created by Пакин Вадим on 27.02.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

#import "RootSprite.h"

@implementation RootSprite{
    
}

-(CGPoint) ConvertTouch:(CGPoint) point{
    CCNode *parent = (CCNode*)[self parent];
    return ccp((0-parent.position.x) + point.x, (0 - parent.position.y) + point.y);
}

- (CCAnimation*) GetAnimation: (NSString*) likeName countFrame:(int) countFrame delay:(float) delay :(float)Wi:(float)Hi{
    CCArray *tempFrames = [CCArray arrayWithCapacity:countFrame];
    
    for (int i = 1; i <= countFrame; i++) {
        //CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@%02d.png",likeName,i]];
        
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTextureFilename:[NSString stringWithFormat:@"%@%02d.png",likeName,i] rect:CGRectMake(0, 0, Wi, Hi)];
        //CCSprite *frame = [[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"%@%02d.png",likeName,i]];
        //[frame set]
        [tempFrames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:[tempFrames getNSArray] delay:delay];
    //return [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
    //return [CCSequence actions:[CCAnimate actionWithAnimation:animation], nil, nil];
}
@end
