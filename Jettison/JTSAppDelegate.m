//
//  JTSAppDelegate.m
//  Jettison
//
//  Created by Gabriel Rinaldi on 4/26/14.
//  Copyright (c) 2014 Jettison. All rights reserved.
//

#import <Crashlytics/Crashlytics.h>
#import <FacebookSDK/FacebookSDK.h>
#import <NewRelicAgent/NewRelic.h>
#import <VPPLocation/VPPLocationController.h>
#import "JTSAzureClient.h"
#import "JTSHomeViewController.h"
#import "JTSLoginViewController.h"
#import "JTSAppDelegate.h"

#pragma mark JTSAppDelegate (Private)

@interface JTSAppDelegate () <JTSLoginViewControllerDelegate> @end

#pragma mark - JTSAppDelegate

@implementation JTSAppDelegate

#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Crashlytics startWithAPIKey:CRASHLYTICS_API_KEY];
    
    [NewRelicAgent startWithApplicationToken:NEWRELIC_TOKEN];
    
    [FBLoginView class];
    
    JTSHomeViewController *homeViewController = [[JTSHomeViewController alloc] initWithNibName:@"JTSHomeViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setRootViewController:navigationController];
    
    [self setWindow:window];
    [[self window] makeKeyAndVisible];
    
    if (![[JTSAzureClient sharedClient] currentUser]) {
        JTSLoginViewController *loginViewController = [[JTSLoginViewController alloc] initWithNibName:@"JTSLoginViewController" bundle:nil];
        [loginViewController setDelegate:self];
        [[[self window] rootViewController] presentViewController:loginViewController animated:NO completion:nil];
    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[VPPLocationController sharedInstance] resumeUpdatingLocation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[VPPLocationController sharedInstance] pauseUpdatingLocation];
}

#pragma mark - URL handling

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    return wasHandled;
}

#pragma mark - Login view controller delegate

- (void)loginViewControllerDidLogin {
    [[[self window] rootViewController] dismissViewControllerAnimated:YES completion:NO];
}

@end
