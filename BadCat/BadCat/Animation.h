//
//  Animation.h
//  BadCat
//
//  Created by Pakinvadim on 11.03.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animation : NSObject

@property(nonatomic,strong) CCAnimation *DoorLeftInAnimation;
@property(nonatomic,strong) CCAnimation *DoorLeftOutAnimation;
@property(nonatomic,strong) CCAnimation *DoorRightInAnimation;
@property(nonatomic,strong) CCAnimation *DoorRightOutAnimation;
@property(nonatomic,strong) CCAnimation *DoorTopInAnimation;
@property(nonatomic,strong) CCAnimation *DoorTopOutAnimation;

@end
