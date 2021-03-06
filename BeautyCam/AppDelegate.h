//
//  AppDelegate.h
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 3..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SA_OAuthTwitterController.h" 

extern NSString *const FBSessionStateChangedNotification;

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *_window;
    UITabBarController *_tabBarController;
    SA_OAuthTwitterEngine *_oAuthTwitterEngine;
}

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) ViewController *viewController;
@property (strong, nonatomic) FBSession *facebookSession;
@property (nonatomic, retain) SA_OAuthTwitterEngine *oAuthTwitterEngine;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void)closeSession;

@end
