//
//  CommonFunctions.h
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UserData.h"

@interface CommonFunctions : NSObject

//Alerts Methods
+(void)showWarningAlert:(NSString *)message title:(NSString *)alertTitle;


// Validation Methods
+(BOOL)isNetworkReachable;
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
+(UserData *) retriveCompleteUserData;

// CoreGraphics Methods
+ (UIImage *)imageWithGradient:(UIImage *)img startColor:(UIColor *)color1 endColor:(UIColor *)color2;
+ (UIColor *)colorWithHexString:(NSString *)str;
+ (void)ApplyShadow:(UIView *)forView;

// Animation Methods
+ (void)performAnimationOnViewWithoutHandler:(UIView *)view duration:(NSTimeInterval) duration delay:(NSTimeInterval)delay;
+(void)performAnimationOnView:(UIView *)view duration:(NSTimeInterval) duration delay:(NSTimeInterval)delay withCompletionHandler:(void (^)(NSInteger success))callback;
+ (void)fadeInLayer:(CALayer *)l;
+ (void)viewSlideInFromTopToBottom:(UIView *)views;
+ (void)viewSlideInFromBottomToTop:(UIView *)views;

@end
