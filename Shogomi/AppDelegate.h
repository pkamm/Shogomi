//
//  AppDelegate.h
//  Shogomi
//
//  Created by Peter Kamm on 4/8/13.
//  Copyright (c) 2013 Smatterbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IntroViewController *viewController;

@end
