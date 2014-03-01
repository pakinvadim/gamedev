//
//  AppDelegate.h
//  TestAnimate
//
//  Created by Pakinvadim on 10.11.13.
//  Copyright CoonStudio 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

// Added only for iOS 6 support
/*@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end*/

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
