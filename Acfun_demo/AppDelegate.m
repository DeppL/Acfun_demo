//
//  AppDelegate.m
//  Acfun_demo
//
//  Created by DeppL on 15/12/24.
//  Copyright © 2015年 DeppL. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ChannelViewController.h"
#import "FocusViewController.h"
#import "UserViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *rootTabBarC = [[UITabBarController alloc]init];
    
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *homeNavC = [[UINavigationController alloc]initWithRootViewController:homeVC];
    UIImage *homeImg = [UIImage imageNamed:@"tabbar_item_home"];
    homeVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"HOME" image:homeImg selectedImage:nil];
    
    ChannelViewController *channelVC = [[ChannelViewController alloc]init];
    UINavigationController *channelNavC = [[UINavigationController alloc]initWithRootViewController:channelVC];
    UIImage *channelImg = [UIImage imageNamed:@"tabbar_item_question"];
    channelVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"CHANNEL" image:channelImg selectedImage:nil];
    
    FocusViewController *focusVC = [[FocusViewController alloc]init];
    UINavigationController *focusNavC = [[UINavigationController alloc]initWithRootViewController:focusVC];
    UIImage *focusImg = [UIImage imageNamed:@"tabbar_item_home"];
    focusVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"HOME" image:focusImg selectedImage:nil];
    
    UserViewController *userVC = [[UserViewController alloc]init];
    UINavigationController *userNavC = [[UINavigationController alloc]initWithRootViewController:userVC];
    
    
    rootTabBarC.viewControllers = @[homeNavC, channelNavC, focusNavC, userNavC];
    
    
    
    
    self.window.rootViewController = rootTabBarC;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
}


@end
