//
//  AppDelegate.m
//  BeautyCam
//
//  Created by LeeSiHyung on 12. 4. 3..
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "CustomHttpRequest.h"
#import "SA_OAuthTwitterEngine.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize facebookSession = _facebookSession;
@synthesize oAuthTwitterEngine = _oAuthTwitterEngine;

NSString *const FBSessionStateChangedNotification =
@"com.example.Login:FBSessionStateChangedNotification";

/*
- (void)dealloc
{
    //[_window release];
    //[_viewController release];
    //[super dealloc];
}
*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // for Iphone5
    //[UIImage initialize];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    
    Class ios5Twitter = NSClassFromString(@"TWTweetComposeViewController");
    if (!ios5Twitter) {
        if (!_oAuthTwitterEngine) {
            _oAuthTwitterEngine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
            _oAuthTwitterEngine.consumerKey = kOAuthConsumerKey;
            _oAuthTwitterEngine.consumerSecret = kOAuthConsumerSecret;
        }
    }
    
    [self openSessionWithAllowLoginUI:NO];
    
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    NSString *firstStart = [[NSUserDefaults standardUserDefaults] valueForKey:@"firstStart"];
    if (firstStart != nil) {
        [httpRequest requestExec];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[FBSession activeSession] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSession activeSession] handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    CustomHttpRequest *httpRequest = [[CustomHttpRequest alloc] init];
    NSString *firstStart = [[NSUserDefaults standardUserDefaults] valueForKey:@"firstStart"];
    if (firstStart != nil) {
        [httpRequest requestExec];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
     [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [FBSession.activeSession close];
}

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error {
    
    NSLog(@"Session State Changed: %u", [[FBSession activeSession] state]);
    
    NSLog(@"%@", [error userInfo]);
    
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                NSLog(@"User session found");
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"facebook"];
            }
            break;
        case FBSessionStateClosed:
            NSLog(@"FBSessionStateClosed");
        case FBSessionStateClosedLoginFailed:
            NSLog(@"FBSessionStateClosedLoginFailed");
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"facebook"];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification object:session];
}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream",
                            nil];
    
    return [FBSession openActiveSessionWithPublishPermissions:permissions
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                                 allowLoginUI:allowLoginUI
                                            completionHandler:^(FBSession *session, FBSessionState state, NSError *error)   {
                                                [self sessionStateChanged:session
                                                                    state:state
                                                                    error:error];
                                            }];
}

- (void) closeSession {
    
     if ([FBSession.activeSession isOpen]) {
         [FBSession.activeSession closeAndClearTokenInformation];
     }
}

@end
