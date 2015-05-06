//
//  CommonFunctions.m
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "CommonFunctions.h"

@implementation CommonFunctions

+(void)showWarningAlert:(NSString *)message title:(NSString *)alertTitle
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertTitle message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


+(BOOL)isNetworkReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (UserData *) retriveCompleteUserData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"UserData"];
    UserData *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

@end
