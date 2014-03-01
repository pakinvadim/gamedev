//
//  HelloWorldLayer.m
//  TestAnimate
//
//  Created by Pakinvadim on 10.11.13.
//  Copyright CoonStudio 2013. All rights reserved.
//


// Import the interfaces
#import "GameLevel1Layer.h"
#import "AppDelegate.h"
#import "Door.h"

#pragma mark - HelloWorldLayer

@implementation GameLevel1Layer

-(id) init
{
	if( self=[super init])
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        Room *room1 = [[Room alloc] initWithFile:@"room1.png" andPosition:CGPointMake(0, 0) andNumber:1];
        [room1 AddDoorWithType:Left andDirect:2 andPositionX:0];
        [room1 AddDoorWithType:Top andDirect:4 andPositionX:400];
        [self addRoom:room1];
        
        Room *room2 = [[Room alloc] initWithFile:@"room1.png" andPosition:CGPointMake(-825, 0) andNumber:2];
        [room2 AddDoorWithType:Right andDirect:1 andPositionX:0];
        [room2 AddDoorWithType:Top   andDirect:3 andPositionX:100];
        [self addRoom:room2];
        
        Room *room3 = [[Room alloc] initWithFile:@"room1.png" andPosition:CGPointMake(-825, winSize.height+25) andNumber:3];
        [room3 AddDoorWithType:Right  andDirect:4 andPositionX:0];
        [room3 AddDoorWithType:Top andDirect:2 andPositionX:100];
        [self addRoom:room3];
        
        Room *room4 = [[Room alloc] initWithFile:@"room1.png" andPosition:CGPointMake(0, winSize.height+25) andNumber:4];
        [room4 AddDoorWithType:Top andDirect:1 andPositionX:400];
        [room4 AddDoorWithType:Left andDirect:3 andPositionX:0];
        [room4 AddDoorWithType:Top andDirect:5 andPositionX:200];
        
        [self addRoom:room4];
        
        Room *room5 = [[Room alloc] initWithFile:@"room1.png" andPosition:CGPointMake(0, 2* (winSize.height+25)) andNumber:5];
        [room5 AddDoorWithType:Top andDirect:4 andPositionX:200];
        [self addRoom:room5];

        
        self.cat = [[Cat alloc] init];
        //self.cat.position = ccp(120,520);
        //self.cat.startRoomNum = 1;
        [self addChild:self.cat z:10 ];
        self.cat.startRoomNum = 1;


        //self.cat.position = ccp(120,120);
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

/*#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}*/
@end
