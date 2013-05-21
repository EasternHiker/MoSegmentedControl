//
//  DemoAppDelegate.h
//  Demo
//
//  Created by Dmitry Egorov on 8/13/11.
//  Copyright 2011 Mobion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoViewController;

@interface DemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DemoViewController *viewController;

@end
