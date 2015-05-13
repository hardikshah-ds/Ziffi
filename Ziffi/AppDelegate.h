//
//  AppDelegate.h
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)LoadStoryBoardWithMainTabModule;
-(void)LoadStoryBoardWithLoginModule;
-(void)ConfigureTabbar;

@end

