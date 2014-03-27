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
float const DoorAnimationDelay = 0.1f;
-(id)init{
    if( self=[super init]){
    }
    return self;
}

-(CGPoint) PositionScale{
    CGPoint position;
    RootSprite* parant = (RootSprite*)self.parent;
    position = parant.PositionScale + ccpMult(self.position, <#const CGFloat s#>)
    return
}

-(CGPoint) ConvertTouch:(CGPoint) point{
    CCNode *parent = (CCNode*)[self parent];
    return ccp((0-parent.position.x) + point.x, (0 - parent.position.y) + point.y);
}

- (CCAnimation*) GetAnimation: (NSString*) likeName arrayNumbersFrame:(NSMutableArray*) arrayNumbersFrame delay:(float) delay :(float)Wi:(float)Hi{
    NSMutableArray* tempFrames = [NSMutableArray array];
    for (int i = 0; i < arrayNumbersFrame.count; i++) {
        CCSpriteFrame *frame = [CCSpriteFrame frameWithTextureFilename:[NSString stringWithFormat:@"%@%02d.png",likeName,[[arrayNumbersFrame objectAtIndex:i]integerValue]] rect:CGRectMake(0, 0, Wi/2, Hi/2)];
        [tempFrames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:tempFrames delay:delay];
}

- (CCAnimation*) GetAnimation: (NSString*) likeName countFrame:(int) countFrame delay:(float) delay :(float)Wi:(float)Hi{
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0; i < countFrame; i++){
        [array addObject:[NSNumber numberWithInteger:i+1]];
    }
    return [self GetAnimation:likeName arrayNumbersFrame:array delay:delay :Wi :Hi];
}
@end
