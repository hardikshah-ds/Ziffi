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

@end
