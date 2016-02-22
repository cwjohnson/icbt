//
//  iCBTAppDelegate.h
//  iCBT
//
//  Created by Chad Johnson on 1/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RootViewController;
@class DetailViewController;

@interface iCBTAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
	UINavigationController *navController;
    
    RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end
