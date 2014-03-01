//
//  GameSprite.m
//  SimpleArkanoid
//
//  Created by Valentine on 31.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSprite.h"

@implementation GameSprite

@synthesize 
			effect = _effect,
            textureInfo = _textureInfo,

			quad = _quad,
			position = _position, 
			contentSize = _contentSize, 
			moveVelocity = _moveVelocity, 
			rotation = _rotation, 
			rotationVelocity = _rotationVelocity,
            scale = _scale,
            scalePointX = _scalePointX,
            scalePointY = _scalePointY;

- (void)initQuadAndSize
{
	self.contentSize = CGSizeMake(self.textureInfo.width, self.textureInfo.height);
	
	TexturedQuad newQuad;
	newQuad.bl.geometryVertex = CGPointMake(0, 0);
	newQuad.br.geometryVertex = CGPointMake(self.textureInfo.width, 0);
	newQuad.tl.geometryVertex = CGPointMake(0, self.textureInfo.height);
	newQuad.tr.geometryVertex = CGPointMake(self.textureInfo.width, self.textureInfo.height);
	
	newQuad.bl.textureVertex = CGPointMake(0, 0);
	newQuad.br.textureVertex = CGPointMake(1, 0);
	newQuad.tl.textureVertex = CGPointMake(0, 1);
	newQuad.tr.textureVertex = CGPointMake(1, 1);
	self.quad = newQuad;
}

- (id)initWithTexture:(GLKTextureInfo *)textureInfo effect:(GLKBaseEffect *)effect
{
	if ((self = [super init]))
	{
        self.effect = effect;
        self.scale = 1;
        self.textureInfo = textureInfo;
        if (self.textureInfo == nil)
		{
            NSLog(@"Error loading texture! Texture info is nil!");
            return nil;
        }

		[self initQuadAndSize];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image effect:(GLKBaseEffect *)effect/////////////////////////////////////
{
    NSError *error;
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:image.CGImage options:options error:&error];
    
    return [self initWithTexture:textureInfo effect:effect];
}

- (GLKMatrix4)modelMatrix
{
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, 0);
	modelMatrix = GLKMatrix4Rotate(modelMatrix, GLKMathDegreesToRadians(self.rotation), 0, 0, 1);
	//modelMatrix = GLKMatrix4Translate(modelMatrix, -self.contentSize.width / 2, -self.contentSize.height / 2, 0);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, 0);
    //modelMatrix = GLKMatrix4Translate(modelMatrix, -(self.scalePointX - self.position.x), -(self.scalePointY - self.position.y), 0);
	return modelMatrix;
}

- (void)update:(float)dt
{
	GLKVector2 curMove = GLKVector2MultiplyScalar(self.moveVelocity, dt);
    self.position = GLKVector2Add(self.position, curMove);
	float rotationChange = self.rotationVelocity * dt;
	self.rotation = self.rotation + rotationChange;
}

- (CGRect)boundingRect
{
	CGRect rect = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    GLKMatrix4 modelMatrix = [self modelMatrix];
    CGAffineTransform transform = CGAffineTransformMake(modelMatrix.m00, modelMatrix.m01, modelMatrix.m10, modelMatrix.m11, modelMatrix.m30, modelMatrix.m31);    
    return CGRectApplyAffineTransform(rect, transform);
}

- (void)render
{
    self.effect.texture2d0.name = self.textureInfo.name;
    self.effect.texture2d0.enabled = YES;
    self.effect.transform.modelviewMatrix = self.modelMatrix;
    [self.effect prepareToDraw];
    long offset = (long)&_quad;
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *) (offset + offsetof(TexturedVertex, geometryVertex)));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex), (void *) (offset + offsetof(TexturedVertex, textureVertex)));
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

@end
