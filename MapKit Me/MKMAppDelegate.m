//
//  MKMAppDelegate.m
//  MapKit Me
//
//  Created by Justin Miller on 4/30/12.
//  Copyright (c) 2012 MapBox / Development Seed. All rights reserved.
//

#import "MKMAppDelegate.h"

#import "MKMViewController.h"

@implementation MKMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *wrapper = [[UINavigationController alloc] initWithRootViewController:[[MKMViewController alloc] initWithNibName:@"MKMViewController" bundle:nil]];
    
    self.window.rootViewController = wrapper;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end