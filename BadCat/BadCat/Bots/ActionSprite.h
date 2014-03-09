//
//  ActionSprite.h
//  TestAnimate
//
//  Created by Pakinvadim on 10.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "CCSprite.h"
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Room.h"
#import "RootSprite.h"


typedef enum ActionSpriteState
{
    ActionStateNone = 0,
    ActionStateIdle,
    ActionStateAttack,
    ActionStateWalk,
    ActionStateHurt,
    ActionStateKnockedOut
} ActionSpriteState;

@interface ActionSprite : RootSprite
{
    
}
//@property(nonatomic,strong) CGPoint* ;

@property(nonatomic) int startRoomNum;
@property(nonatomic) float Speed;

@property(nonatomic,strong) CCAnimation *IdleAnimation;
@property(nonatomic,strong) CCAnimation *walkLeftAnimation;
@property(nonatomic,strong) CCAnimation *WalkRightAnimation;
@property(nonatomic,strong) CCAnimation *WalkUpAnimation;
@property(nonatomic,strong) CCAnimation *WalkDownAnimation;

@property(nonatomic,strong) CCAnimate *IdleAnimate;
@property(nonatomic,strong) CCAnimate *WalkLeftAnimate;
@property(nonatomic,strong) CCAnimate *WalkRightAnimate;
@property(nonatomic,strong) CCAnimate *WalkUpAnimate;
@property(nonatomic,strong) CCAnimate *WalkDownAnimate;

@property(nonatomic,assign) ActionSpriteState actionState;

-(float) GetDurationBetween: (CGPoint)start :(CGPoint)end;
-(CCAnimation*) GetAnimationWithFrameNameLike: (NSString*) likeName andCountFrame:(int) countFrame andDelay:(float) delay;
-(void) GoTo:(CGPoint)touchPoint;
-(void) Idle;
-(void) Walk;
-(void) WalkUp;
-(void) WalkDown;

@end
