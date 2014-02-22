//
//  ViewController.m
//  SimpleArkanoid
//
//  Created by Valentine on 31.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController
{
    CGPoint _firstTouchLocation;
    GLKVector2 _tempBGLocation;
}

@synthesize context = _context;
@synthesize effect = _effect;
@synthesize background = _background;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context)
	{
        NSLog(@"Failed to create ES context");
    }

	[self setupGL];
	
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
	GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, 320, 0, 480, -1024, 1024);

	self.effect.transform.projectionMatrix = projectionMatrix;
	
	// initializing game state

	// initializing common sprites
	//self.playerBat = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"playerBat"] effect:self.effect];
	//self.playerBat.position = GLKVector2Make(160, 35);
     //self.playerBat.rotationVelocity = 320.f;
	//self.ball = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"ball1"] effect:self.effect];
	//self.ball.position = GLKVector2Make(160, 80);
	//self.ball.rotationVelocity = 180.f;
	self.background = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"level1"] effect:self.effect];
	self.background.position = GLKVector2Make(160, 240);
	// loading level bricks
	//[self loadBricks];
	// menu sprites
	/*self.menuDimmer = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"menuDimmer"] effect:self.effect];
	self.menuDimmer.position = GLKVector2Make(160, 240);
	self.menuStartButton = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"menuStartButton"] effect:self.effect];
	self.menuStartButton.position = GLKVector2Make(160, 240);
	self.menuCaption = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"menuCaption"] effect:self.effect];
	self.menuCaption.position = GLKVector2Make(160, 340);
	self.menuCaptionWon = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"menuCaptionWon"] effect:self.effect];
	self.menuCaptionWon.position = GLKVector2Make(160, 340);
	self.menuCaptionLose = [[GameSprite alloc] initWithImage:[UIImage imageNamed:@"menuCaptionLose"] effect:self.effect];
	self.menuCaptionLose.position = GLKVector2Make(160, 340);*/

	// gestures
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureFrom:)];
    //UITouchPhaseBegan *touchBegan =;
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    //UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    //UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    //UIScreenEdgePanGestureRecognizer *screenEdgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenEdgePanGesture:)];
    //UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    
	[self.view addGestureRecognizer:panRecognizer];
	[self.view addGestureRecognizer:tapRecognizer];
    //[self.view add]
    [self.view addGestureRecognizer:pinchRecognizer];
	//[self.view addGestureRecognizer:rotationRecognizer];
     //[self.view addGestureRecognizer:swipeRecognizer];
	//[self.view addGestureRecognizer:screenEdgePanRecognizer];
     //[self.view addGestureRecognizer:longPressRecognizer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    _firstTouchLocation = [touch locationInView:self.view];
    _tempBGLocation = self.background.position;
}

- (void)handleTapGestureFrom:(UITapGestureRecognizer *)recognizer
{
    /*CGPoint touchLocation = [recognizer locationInView:recognizer.view];
	if (self.gameRunning)
	{
		GLKVector2 target = GLKVector2Make(touchLocation.x,480-touchLocation.y); //self.playerBat.position.y);
		self.playerBat.position = target;
	}
	else if (CGRectContainsPoint(self.menuStartButton.boundingRect, touchLocation))
	{
		[self startGame];
	}*/
}
- (void)handlePanGesture:(UIPanGestureRecognizer *)sender
{
	CGPoint touchLocation = [sender locationInView:sender.view];
    //CGPoint firstTouchLocation = [[sender valueForKey:@"_firstScreenLocation"] CGPointValue];
    //if(sender.delaysTouchesBegan){NSLog(@"STARTTTTTTTTT");}
    GLKVector2 target = GLKVector2Make((_tempBGLocation.x - _firstTouchLocation.x) + touchLocation.x,(_tempBGLocation.y - (480-_firstTouchLocation.y)) + (480-touchLocation.y));// self.playerBat.position.y);
	self.background.position = target;
}
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender
{
    CGPoint touchLocation = [sender locationInView:sender.view];
    self.background.scalePointX = touchLocation.x;
    self.background.scalePointY = touchLocation.y;
    self.background.scale = sender.scale ;
    //NSLog(@"Pinch Work");
}

- (void)viewDidUnload
{    
    [super viewDidUnload];
    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
	self.context = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    self.effect = [[GLKBaseEffect alloc] init];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    self.effect = nil;
}

/*- (void)loadBricks
{
	// assuming 6x6 brick matrix, each brick is 50x10
	NSError *error;
	[NSBundle mainBundle] ;
	NSStringEncoding encoding;
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"txt"];
	NSString *levelData = [NSString stringWithContentsOfFile:filePath usedEncoding:&encoding error:&error];
	if (levelData == nil)
	{
		NSLog(@"Error loading level data! %@", error);
		return;
	}
	levelData = [[levelData componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString: @""];
	if ([levelData length] < (6*6))
	{
		NSLog(@"Level data has incorrect size!");
		return;
	}
	NSMutableArray *loadedBricks = [NSMutableArray array];
	UIImage *brickImage = [UIImage imageNamed:@"brick1"];

	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
	GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:brickImage.CGImage options:options error:&error];
	if (textureInfo == nil)
	{
		NSLog(@"Error loading image: %@", [error localizedDescription]);
		return;
	}

	for (int i = 0; i < 6; i++)
	{
		for (int j = 0; j < 6; j++)
		{
			if ([levelData characterAtIndex:j + i * 6] == '1')
			{
				GameSprite *brickSprite = [[GameSprite alloc] initWithTexture:textureInfo effect:self.effect];
				brickSprite.position = GLKVector2Make((j + 1) * 50.f - 15.f, 480.f - (i + 1) * 10.f - 15.f);
                //brickSprite.rotationVelocity = 480.f;
				[loadedBricks addObject:brickSprite];
			}
		}
	}
	self.bricks = loadedBricks;
}*/

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
	/*if (!self.gameRunning)
		return;
	// checking for broken bricks
	NSMutableArray *brokenBricks = [NSMutableArray array];
	GLKVector2 initialBallVelocity = self.ball.moveVelocity;
	for (GameSprite *brick in self.bricks)
	{
        if (CGRectIntersectsRect([self.ball boundingRect], brick.boundingRect))
		{
			[brokenBricks addObject: brick];
			if ((self.ball.position.y < brick.position.y - brick.contentSize.height / 2) || (self.ball.position.y > brick.position.y + brick.contentSize.height / 2))
			{
				self.ball.moveVelocity = GLKVector2Make(initialBallVelocity.x, -initialBallVelocity.y);
			}
			else
			{
				self.ball.moveVelocity = GLKVector2Make(-initialBallVelocity.x, initialBallVelocity.y);
			}
		}
    }
	
	// removing them
	for (GameSprite *brick in brokenBricks)
	{
		[self.bricks removeObject:brick];
	}
	
	if (self.bricks.count == 0)
	{
		[self endGameWithWin:YES];
	}
	
	// checking for walls
	// left
	if (self.ball.boundingRect.origin.x <= 0)
	{
		self.ball.moveVelocity = GLKVector2Make(-self.ball.moveVelocity.x, self.ball.moveVelocity.y);
		self.ball.position = GLKVector2Make(self.ball.position.x - self.ball.boundingRect.origin.x, self.ball.position.y);
	}
	// right
	else if (self.ball.boundingRect.origin.x + self.ball.boundingRect.size.width >= 320)
	{
		self.ball.moveVelocity = GLKVector2Make(-self.ball.moveVelocity.x, self.ball.moveVelocity.y);
		self.ball.position = GLKVector2Make(self.ball.position.x - (self.ball.boundingRect.size.width + self.ball.boundingRect.origin.x - 320), self.ball.position.y);
	}
	// top
	else if (self.ball.boundingRect.origin.y + self.ball.boundingRect.size.height >= 480)
	{
		self.ball.moveVelocity = GLKVector2Make(self.ball.moveVelocity.x, -self.ball.moveVelocity.y);
		self.ball.position = GLKVector2Make(self.ball.position.x, self.ball.position.y - (self.ball.boundingRect.origin.y + self.ball.boundingRect.size.height - 480));
	}
	// bottom (player lose)
	else if (self.ball.boundingRect.origin.y + self.ball.boundingRect.size.height <= 70)
	{
		[self endGameWithWin:NO];
	}
	
	// player strikes!
	if (CGRectIntersectsRect(self.ball.boundingRect, self.playerBat.boundingRect))
	{
		float angleCoef = (self.ball.position.x - self.playerBat.position.x) / (self.playerBat.contentSize.width / 2);
		float newAngle = 90.f - angleCoef * 80.f;
		GLKVector2 ballDirection = GLKVector2Normalize(GLKVector2Make(1 / tanf(GLKMathDegreesToRadians(newAngle)), 1));
		float ballSpeed = GLKVector2Length(self.ball.moveVelocity);
		self.ball.moveVelocity = GLKVector2MultiplyScalar(ballDirection, ballSpeed);
		self.ball.position = GLKVector2Make(self.ball.position.x, self.ball.position.y + (self.playerBat.boundingRect.origin.y + self.playerBat.boundingRect.size.height - self.ball.boundingRect.origin.y));
	}
	
	// update alive sprites
	[self.playerBat update:self.timeSinceLastUpdate];
	[self.ball update:self.timeSinceLastUpdate];
	for (GameSprite *brick in self.bricks)
	{
        [brick update:self.timeSinceLastUpdate];
    }*/
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    //glClearColor(1.f, 1.f, 1.f, 1.0f); // задний фон
    glClear(GL_COLOR_BUFFER_BIT);
    //glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    //glEnable(GL_BLEND);

	[self.background render];
    /*[self.playerBat render];
	for (GameSprite *brick in self.bricks)
	{
		[brick render];
	}
	[self.ball render];*/
	
	/*if (!self.gameRunning)
	{
		[self.menuDimmer render];
		[self.menuStartButton render];
		switch (self.gameState)
		{
			case kGameStateWon:
				[self.menuCaptionWon render];
				break;
			case kGameStateLose:
				[self.menuCaptionLose render];
				break;
			case kGameStateNone:
			default:
				[self.menuCaption render];
				break;
		}
	}*/
}

@end
