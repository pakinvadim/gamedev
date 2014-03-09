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

-(id) init
{
    
	if( (self=[super init]) )
    {
        self.WalkRightAnimation = [self GetAnimationWithFrameNameLike:@"walkLeft" andCountFrame:5 andDelay:0.1];
        self.WalkRightAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkRightAnimation]];
        
        self.WalkLeftAnimation = [self GetAnimationWithFrameNameLike:@"walkLeft" andCountFrame:5 andDelay:0.1];
        //self.WalkLeftAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnim]];
        self.WalkLeftAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.walkLeftAnimation]];
        
        self.WalkUpAnimation = [self GetAnimationWithFrameNameLike:@"walkTop" andCountFrame:4 andDelay:0.2];
        self.WalkUpAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkUpAnimation]];
        
        self.WalkDownAnimation = [self GetAnimationWithFrameNameLike:@"walkBotton" andCountFrame:4 andDelay:0.2];
        self.WalkDownAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkDownAnimation]];
        
        self.IdleAnimation = [self GetAnimationWithFrameNameLike:@"standBotton" andCountFrame:2 andDelay:1];
        self.IdleAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.IdleAnimation]];
        
        self.scale = 0.05;
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
