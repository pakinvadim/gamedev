//
//  Man.m
//  BadCat
//
//  Created by Pakinvadim on 11.03.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

#import "Man.h"

@implementation Man{
}

-(id) init{
    
	if( (self = [super init]) ){
        
        self.Type = IsMan;
        self.scale = 0.31;
        //self.startRoomNum = 1;
        [self Idle];
	}
	return self;
}

@end
