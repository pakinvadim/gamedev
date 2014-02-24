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

typedef enum ActionSpriteState
{
    ActionStateNone = 0,
    ActionStateIdle,
    ActionStateAttack,
    ActionStateWalk,
    ActionStateHurt,
    ActionStateKnockedOut
} ActionSpriteState;

@interface ActionSprite : CCSprite
{
    
}
//@property(nonatomic,strong) CGPoint* ;


@property(nonatomic)int startRoomNum;
@property(nonatomic)float Duration;

@property(nonatomic,strong) CCAction *idleAction;
@property(nonatomic,strong) CCAction *walkLeftAction;
@property(nonatomic,strong) CCAction *walkRightAction;
@property(nonatomic,strong) CCAction *walkUpAction;
@property(nonatomic,strong) CCAction *walkDownAction;

@property(nonatomic,assign) ActionSpriteState actionState;

-(CCAnimation*) GetAnimationWithFrameNameLike: (NSString*) likeName andCountFrame:(int) countFrame andDelay:(float) delay;
-(void)GoTo:(CGPoint)point;
-(void) Idle;
-(void) Walk;
-(void) WalkUp;
-(void) WalkDown;

@end
