//
//  DMMAppDelegate.m
//  ClamShell-iPad
//
//  Created by Delisa Mason on 5/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMAppDelegate.h"

@implementation DMMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    return YES;
}

@end
