//
//  IntroLayer.m
//  BadCat
//
//  Created by Pakinvadim on 06.11.13.
//  Copyright CoonStudio 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "RootLayer.h"
#import <GameKit/GameKit.h>
#import "cocos2d.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

RootLayer* rl;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {
        
        rl = [[RootLayer alloc] init];
        [self addChild:rl];
        //[self scheduleOnce:@selector(yourMethod:) delay:3.0f];
        

        
		// ask director for the window size
		/*CGSize size = [[CCDirector sharedDirector] winSize];

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

-(void) yourMethod:(ccTime) dt {

}

-(void) onEnter
{
	[super onEnter];
	//[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
}
@end
