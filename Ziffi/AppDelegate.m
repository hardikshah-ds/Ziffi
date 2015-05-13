//
//  AppDelegate.m
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UITabBar appearance] setBarTintColor:[CommonFunctions colorWithHexString:TabBarColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Roboto-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [UIColor whiteColor]
                                                        } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Roboto-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:10/255.0f green:180/255.0f blue:180/255.0f alpha:1.0]
                                                        } forState:UIControlStateSelected];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [GPPSignIn sharedInstance].clientID = GOOGLE_ID_DEV;
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

-(void)ConfigureTabbar {
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1.title = @"Home";
    tabBarItem2.title = @"Offer";
    tabBarItem3.title = @"Bookings";
    tabBarItem4.title = @"Refer";
    tabBarItem5.title = @"More";
    
    tabBarItem1.image = [[UIImage imageNamed:@"home-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.image = [[UIImage imageNamed:@"offers-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3.image = [[UIImage imageNamed:@"booking-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem4.image = [[UIImage imageNamed:@"refer-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem5.image = [[UIImage imageNamed:@"more-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"home-icon-sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"offers-icon-sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"booking-icon-sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem4.selectedImage = [[UIImage imageNamed:@"refer-icon-sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem5.selectedImage = [[UIImage imageNamed:@"more-icon-sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation {
    if ([[GPPSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation]) {
        return YES;
    }
    else if ([[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]){
        return YES;
    }
    return NO;
}

-(void)LoadStoryBoardWithLoginModule
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}



-(void)LoadStoryBoardWithMainTabModule
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainTab" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    self.window.rootViewController = vc;
    [self ConfigureTabbar];
    [self.window makeKeyAndVisible];
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
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
