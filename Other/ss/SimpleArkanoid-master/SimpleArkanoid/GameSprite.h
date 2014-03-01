//
//  GameSprite.h
//  SimpleArkanoid
//
//  Created by Valentine on 31.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

typedef struct
{
    CGPoint geometryVertex;
    CGPoint textureVertex;
} TexturedVertex;
typedef struct
{
    TexturedVertex bl;  //botton left
    TexturedVertex br;  //botton right
    TexturedVertex tl;  //top left
    TexturedVertex tr;  //top right
} TexturedQuad;

@interface GameSprite : NSObject

- (id)initWithTexture:(GLKTextureInfo *)textureInfo effect:(GLKBaseEffect *)effect;
- (id)initWithImage:(UIImage *)image effect:(GLKBaseEffect *)effect;
- (void)render;
- (void)update:(float)dt;
- (CGRect)boundingRect;

- (void)initQuadAndSize;

@property (assign) GLKVector2 position;
@property (assign) CGSize contentSize;
@property (assign) GLKVector2 moveVelocity; // points/sec
@property (assign) float rotation;
@property (assign) float rotationVelocity; // degrees/sec
@property (assign) float scale;
@property (assign) float scalePointX;
@property (assign) float scalePointY;

@property (strong) GLKBaseEffect *effect;
@property (strong) GLKTextureInfo *textureInfo;

@property (assign) TexturedQuad quad;

@end
