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
        self.WalkRightAnimation = [self GetAnimation:@"walkLeft" countFrame:5 delay:animDelay  :209 :207];
        //self.WalkRightAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkRightAnimation]];
        
        self.WalkLeftAnimation = [self GetAnimation:@"walkLeft" countFrame:5 delay:animDelay :209 :207];
        //self.WalkLeftAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnim]];
        //self.WalkLeftAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.walkLeftAnimation]];
        
        self.WalkUpAnimation = [self GetAnimation:@"walkTop" countFrame:4 delay:animDelay :209 :207];
        //self.WalkUpAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkUpAnimation]];
        
        self.WalkDownAnimation = [self GetAnimation:@"walkBotton" countFrame:4 delay:animDelay :209 :207];
        //self.WalkDownAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.WalkDownAnimation]];
        
        self.IdleAnimation = [self GetAnimation:@"standBotton" countFrame:2 delay:1 :209 :207];
        self.IdleAnimate = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.IdleAnimation]];
        
        self.DoorLeftInAnimation = [self GetAnimation:@"doorLeftInCat" countFrame:5 delay:self.DoorAnimationDelay :157:420];
        self.DoorLeftOutAnimation = [self GetAnimation:@"doorLeftOutCat" countFrame:5 delay:self.DoorAnimationDelay :157:420];
        self.DoorRightInAnimation = [self GetAnimation:@"doorRightInCat" countFrame:5 delay:self.DoorAnimationDelay :157:420];
        self.DoorRightOutAnimation = [self GetAnimation:@"doorRightOutCat" countFrame:5 delay:self.DoorAnimationDelay :157:420];
        self.DoorTopInAnimation = [self GetAnimation:@"doorUpInCat" countFrame:5 delay:self.DoorAnimationDelay :157:420];
        self.DoorTopOutAnimation = [self GetAnimation:@"doorUpOutCat" countFrame:5 delay:self.DoorAnimationDelay :157:420];
        
        self.Type = IsCat;
        self.scale = 0.31;
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
