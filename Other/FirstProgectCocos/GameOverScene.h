//
//  GameOverScene.h
//  FirstProgectCocos
//
//  Created by Pakinvadim on 10.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "cocos2d.h"

//*********************************************************************************

@interface GameOverLayer : CCLayerColor
{
    CCLabelTTF *_label;
}
@property (nonatomic, retain) CCLabelTTF *label;
@end

//*********************************************************************************

@interface GameOverScene : CCScene
{
    GameOverLayer *_layer;
}
@property (nonatomic, retain) GameOverLayer *layer;
@end
