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
        CCAnimation *walkRightAnim = [self GetAnimationWithFrameNameLike:@"cat_walk_" andCountFrame:6 andDelay:0.1];
        self.walkRightAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkRightAnim]];
        
        CCAnimation *walkLeftAnim = [self GetAnimationWithFrameNameLike:@"cat_walk_" andCountFrame:6 andDelay:0.1];
        self.walkLeftAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnim]];
        
        CCAnimation *walkUpAnim = [self GetAnimationWithFrameNameLike:@"cat_walkUp_" andCountFrame:3 andDelay:0.2];
        self.walkUpAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnim]];
        
        CCAnimation *walkDownAnim = [self GetAnimationWithFrameNameLike:@"cat_walkDown_" andCountFrame:3 andDelay:0.2];
        self.walkDownAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnim]];
        
        CCAnimation *idleAnim = [self GetAnimationWithFrameNameLike:@"cat_stand_" andCountFrame:2 andDelay:1];
        self.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnim]];
        
        self.scale = 0.25;
        self.startRoomNum = 1;
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
    [self runAction:self.idleAction];
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
