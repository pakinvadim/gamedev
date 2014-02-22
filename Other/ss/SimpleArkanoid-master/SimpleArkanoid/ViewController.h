//
//  ViewController.h
//  SimpleArkanoid
//
//  Created by Valentine on 31.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "GameSprite.h"

@interface ViewController : GLKViewController

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;
@property (strong, nonatomic) GameSprite *background;

- (void)setupGL;
- (void)tearDownGL;

- (void)startGame;
@end
