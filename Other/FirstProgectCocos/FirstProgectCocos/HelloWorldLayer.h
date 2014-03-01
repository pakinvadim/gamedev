//
//  HelloWorldLayer.h
//  FirstProgectCocos
//
//  Created by Pakinvadim on 09.11.13.
//  Copyright CoonStudio 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    NSMutableArray *_targets;
    NSMutableArray *_projectiles;
    int _projectilesDestroyed;
    CCSprite *_player;
    CCSprite *_nextProjectile;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
