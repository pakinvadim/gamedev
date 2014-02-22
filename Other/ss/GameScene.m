//
//  IntroLayer.m
//  TestAnimate
//
//  Created by Pakinvadim on 10.11.13.
//  Copyright CoonStudio 2013. All rights reserved.
//


// Import the interfaces

#import "GameScene.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation GameScene
{
    
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
/*+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLevel1Layer *layer = [GameLevel1Layer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}*/

// 
-(id) init
{
	if( (self=[super init])) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"cat.plist"];
        _actors = [CCSpriteBatchNode batchNodeWithFile:@"cat.png"];
        [_actors.texture setAliasTexParameters];
        [self addChild:_actors z:-5];
        
        _gameLevel1Layer = [GameLevel1Layer node];
        [self addChild:_gameLevel1Layer z:0];
        
		/*// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];*/
	}
	
	return self;
}

/*-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLevel1Layer scene] ]];
}*/
@end
