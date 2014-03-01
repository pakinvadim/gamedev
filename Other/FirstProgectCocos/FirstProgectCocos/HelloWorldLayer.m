//
//  HelloWorldLayer.m
//  FirstProgectCocos
//
//  Created by Pakinvadim on 09.11.13.
//  Copyright CoonStudio 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "GameOverScene.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        _player = [[CCSprite spriteWithFile:@"Player2.jpg" ]retain];//rect:CGRectMake(0, 0, 27, 40)];
        _player.position = ccp(_player.contentSize.width/2, winSize.height/2);
        [self addChild:_player];
        
        _targets = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"1.caf"];
    }
    
    self.isTouchEnabled = YES;
    [self schedule:@selector(gameLogic:) interval:1.0];
    [self schedule:@selector(update:)];
	return self;
}

-(void)update:(ccTime)dt
{
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    for (CCSprite *projectile in _projectiles)
    {
        CGRect projectileRect =CGRectMake(projectile.position.x - (projectile.contentSize.width/2),
                                          projectile.position.y - (projectile.contentSize.height/2),
                                          projectile.contentSize.width,
                                          projectile.contentSize.height);
        NSMutableArray *targetToDelete = [[NSMutableArray alloc]init];
        
        for (CCSprite *target in _targets)
        {
            CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2),
                                           target.position.y - (target.contentSize.height/2),
                                           target.contentSize.width,
                                           target.contentSize.height);
            
            if(CGRectIntersectsRect(projectileRect, targetRect))
            {
                [targetToDelete addObject:target];
                _projectilesDestroyed++;
                if(_projectilesDestroyed >=5)
                {
                    GameOverScene *gameOverScene = [GameOverScene node];
                    _projectilesDestroyed = 0;
                    [gameOverScene.layer.label setString:@"Win Win Win"];
                    [[CCDirector sharedDirector] replaceScene:gameOverScene];
                }
            }
        }
        
        for (CCSprite *target in targetToDelete)
        {
            [_targets removeObject:target];
            [self removeChild:target cleanup:YES];
        }
        
        if (targetToDelete.count > 0) {
            [projectilesToDelete addObject:projectile];
        }
        
        [targetToDelete release];
        
    }
    
    for (CCSprite *projectile in projectilesToDelete )
    {
        [_projectiles removeObject:projectile],[self removeChild:projectile cleanup:YES];
    }
    [projectilesToDelete release];
}

-(void)gameLogic:(ccTime)dt {
    [self addTarget];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_nextProjectile != nil) return;
    
    // Выбираем касание, с которым будем работать
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Устанавливаем начальное местоположение пули
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    _nextProjectile = [[CCSprite spriteWithFile:@"Projectile.png"] retain];
    _nextProjectile.position = ccp(20, winSize.height/2);
    
    // Определяем смещение
    int offX = location.x - _nextProjectile.position.x;
    int offY = location.y - _nextProjectile.position.y;
    
    // Убеждаемся, что не стреляем назад
    if (offX < 0) return;
    
    // Проигрываем звук
    [[SimpleAudioEngine sharedEngine] playEffect:@"2.caf"];
    
    // Определяем направление стрельбы
    int realX = winSize.width + (_nextProjectile.contentSize.width/2);
    float ratio = (float) offY / (float) offX;
    int realY = (realX * ratio) + _nextProjectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Определяем дистанцию стрельбы
    int offRealX = realX - _nextProjectile.position.x;
    int offRealY = realY - _nextProjectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    // Определяем угол поворота
    float angleRadians = atanf((float)offRealY / (float)offRealX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    float rotateSpeed = 0.5 / M_PI; // Would take 0.5 seconds to rotate 0.5 radians, or half a circle
    float rotateDuration = fabs(angleRadians * rotateSpeed);
    [_player runAction:[CCSequence actions:
                        [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
                        [CCCallFunc actionWithTarget:self selector:@selector(finishShoot)],
                        nil]];
    
    // Передвигаем пулю в конечную точку
    [_nextProjectile runAction:[CCSequence actions:
                                [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                                [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                                nil]];
    
    // Задаем тэг
    _nextProjectile.tag = 2;
    
}

-(void) finishShoot
{
    [self addChild:_nextProjectile];
    [_projectiles addObject:_nextProjectile];
    
    [_nextProjectile release];
    _nextProjectile = nil;
}

-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
    
    if (sprite.tag == 1) { // target
        [_targets removeObject:sprite];
        GameOverScene *gameOverScene = [GameOverScene node];
        [gameOverScene.layer.label setString:@"Lose......"];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    } else if (sprite.tag == 2) { // projectile
        [_projectiles removeObject:sprite];
    }
}

-(void)addTarget {
    
    CCSprite *target = [CCSprite spriteWithFile:@"Target.png"
                                           rect:CGRectMake(0, 0, 27, 40)];
    
    // Определяем У координату для создания цели
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int minY = target.contentSize.height/2;
    int maxY = winSize.height - target.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Создаем цель чуть-чуть за правым краем экрана,
    // и на случайной позиции по оси У, как показано выше
    target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
    [self addChild:target];
    
    // Задаём скорость движения цели
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Задаём действие
    id actionMove = [CCMoveTo actionWithDuration:actualDuration
                                        position:ccp(-target.contentSize.width/2, actualY)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(spriteMoveFinished:)];
    [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    target.tag = 1;
    [_targets addObject:target];}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_targets release];
    _targets = nil;
    [_projectiles release];
    _projectiles = nil;
    [_player release];
    _player = nil;
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
