//
//  Hero.m
//  TestAnimate
//
//  Created by Pakinvadim on 10.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "Cat.h"

@implementation Cat{
}

-(id) init{
    
	if( (self = [super init]) ){
        float animDelay = 0.1f;
        self.WalkRightAnimation = [self GetAnimation:@"walkLeft" countFrame:5 delay:animDelay  :186 :185];
        //self.WalkRightAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkRightAnimation]];
        
        self.WalkLeftAnimation = [self GetAnimation:@"walkLeft" countFrame:5 delay:animDelay :186 :185];
        //self.WalkLeftAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnim]];
        //self.WalkLeftAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.walkLeftAnimation]];
        
        self.WalkUpAnimation = [self GetAnimation:@"walkTop" countFrame:4 delay:animDelay :186 :185];
        //self.WalkUpAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkUpAnimation]];
        
        self.WalkDownAnimation = [self GetAnimation:@"walkBotton" countFrame:4 delay:animDelay :186 :185];
        //self.WalkDownAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkDownAnimation]];
        
        self.IdleAnimation = [self GetAnimation:@"standBotton" countFrame:2 delay:1 :186 :185];
        self.IdleAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.IdleAnimation]];
        
        self.DoorLeftInAnimation = [self GetAnimation:@"CatAnimEnterDoorLeftIn" countFrame:6 delay:DoorAnimationDelay :186:172];
        self.DoorLeftOutAnimation = [self GetAnimation:@"CatAnimEnterDoorLeftOut" countFrame:6 delay:DoorAnimationDelay :186:172];
        self.DoorRightInAnimation = [self GetAnimation:@"CatAnimEnterDoorRightIn" countFrame:6 delay:DoorAnimationDelay :186:172];
        self.DoorRightOutAnimation = [self GetAnimation:@"CatAnimEnterDoorRightOut" countFrame:6 delay:DoorAnimationDelay :186:141];
        self.DoorTopInAnimation = [self GetAnimation:@"CatAnimEnterDoorTopIn" countFrame:6 delay:DoorAnimationDelay :186:258];
        self.DoorTopOutAnimation = [self GetAnimation:@"CatAnimEnterDoorTopOut" countFrame:6 delay:DoorAnimationDelay :186:255];
        
        self.Type = IsCat;
        //self.scale = 0.31;
        //self.startRoomNum = 1;
        [self Idle];
	}
	return self;
}

/*-(void) GoTo:(CGPoint*)location
{
    if (self.position.x == location->x){return;}
    
    else if (self.position.x < location->x)
    {
        self.position = ccp(self.position.x+1, self.position.y);
        return;
    }
    else if (self.position.x > location->x)
    {
        self.position = ccp(self.position.x-1, self.position.y);
        return;
    }
    [self runAction:[CCSequence actions:
                         [CCMoveTo actionWithDuration:5 position:*location],
                         nil,//[CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                         nil]];
}*/






-(void) FinishAnimateWalk
{
    return;
}

-(void) Walk
{
    [self runAction:self.IdleAnimate];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
