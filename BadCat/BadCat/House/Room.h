//
//  Room.h
//  TestAnimate
//
//  Created by Pakinvadim on 11.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "Door.h"

@interface Room : CCSprite
{
    
}

@property NSMutableArray *doors;
@property int numberRoom;
@property (nonatomic)float FloorPosition;
@property (nonatomic)CGPoint Center;

-(id) initWithFile:(NSString *)filename andPosition:(CGPoint) positionR andNumber:(int) number;
-(void) AddDoorWithType:(DoorType) type  andDirect:(int)dir andPositionX:(float)positionX;
-(Door*) GetDoorWithDirect:(int) direct;

@end
