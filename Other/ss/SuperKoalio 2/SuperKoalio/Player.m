//
//  Player.m
//  SuperKoalio
//
//  Created by Jacob Gundersen on 6/4/12.
//  Copyright 2012 Interrobang Software LLC. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize velocity = _velocity;
@synthesize desiredPosition = _desiredPosition;
@synthesize onGround = _onGround;

// 1
-(id)initWithFile:(NSString *)filename 
{
    if (self = [super initWithFile:filename]) {
        self.velocity = ccp(0.0, 0.0);
    }
    return self;
}

-(void)update:(ccTime)dt 
{
    
    // 2
    CGPoint gravity = ccp(0.0, -450.0);
    
    // 3
    CGPoint gravityStep = ccpMult(gravity, dt);
    
    // 4
    self.velocity = ccpAdd(self.velocity, gravityStep);
    CGPoint stepVelocity = ccpMult(self.velocity, dt);
    
    // 5
    self.desiredPosition = ccpAdd(self.position, stepVelocity);
}

-(CGRect)collisionBoundingBox {
    CGRect collisionBox = CGRectInset(self.boundingBox, 3, 0);
    CGPoint diff = ccpSub(self.desiredPosition, self.position);
    CGRect returnBoundingBox = CGRectOffset(collisionBox, diff.x, diff.y);
    return returnBoundingBox;
}

@end
