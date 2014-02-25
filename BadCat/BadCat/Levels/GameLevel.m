//
//  GameLevel.m
//  TestAnimate
//
//  Created by Pakinvadim on 11.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "GameLevel.h"

@implementation GameLevel
{
    CGPoint _touchBegan_PointOfTouch;
    CGPoint _touchBegan_PointOfLayer;
}

-(id) init
{
    if( self=[super initWithColor:ccc4(255, 255, 255, 100)] )
    {
        self.touchEnabled = YES;
        self.roomArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) addRoom:(Room*)room
{
    [self addChild:room z:0];
    [self.roomArray addObject:room];
}

-(Room*)GetRoomWithNumber:(int)roomNumber{
    for(Room* room in self.roomArray){
        if(room.numberRoom == roomNumber){
            return room;
        }
    }
    return nil;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    CCLOG(@"Touch BEGAN");
    _touchBegan_PointOfTouch = location;
    _touchBegan_PointOfLayer = self.position;
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Выбираем касание, с которым будем работать
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    if (_touchBegan_PointOfTouch.x == location.x && _touchBegan_PointOfTouch.y == location.y)
    {
        [self.cat GoTo:location];
        CCLOG(@"CanGO");
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    //location = [[CCDirector sharedDirector] convertToGL:location];
    
    //for(Room *room in self.roomArray)
    {
        self.position = ccp(_touchBegan_PointOfLayer.x + (location.x - _touchBegan_PointOfTouch.x)
                               ,_touchBegan_PointOfLayer.y + (location.y - _touchBegan_PointOfTouch.y) );
    }
    //CCLOG(@"move d");
}
@end
