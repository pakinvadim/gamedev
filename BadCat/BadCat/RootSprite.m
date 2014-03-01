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

@end
