//
//  Room.h
//  TestAnimate
//
//  Created by Pakinvadim on 11.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "RootSprite.h"
#import "cocos2d.h"
#import "Door.h"

@interface Room : RootSprite{
}

@property (nonatomic)NSMutableArray *doors;
@property int numberRoom;
@property (nonatomic)float FloorPosition;
@property (nonatomic)CGPoint Center;
@property (nonatomic)CGPoint LeftRightIndent;
@property (nonatomic)float MaxLeftPosition;
@property (nonatomic)float MaxRightPosition;
@property (nonatomic)float MaxTop;

-(id) initWithFile:(NSString *)filename andPosition:(CGPoint) positionR andNumber:(int) number;
-(void) AddDoorWithType:(DoorType) type  andDirect:(int)dir andPositionX:(float)positionX;
-(Door*) GetDoorWithDirect:(int) direct;

@end
