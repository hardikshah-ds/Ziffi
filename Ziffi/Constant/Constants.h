//
//  Constants.h
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
#import "UIImageView+AFNetworking.h"
#import "SBJson.h"

#import "CommonFunctions.h"
#import "UserData.h"
#import "LoginModuleServices.h"
#import "SearchModuleSerivces.h"
#import "SVProgressHUD.h"
#import "TablePagination.h"

#import "AppDelegate.h"

#import "ProfileVerificationVC.h"
#import "HomeVC.h"
#import "SearchVC.h"
#import "OfferVC.h"
#import "BookingVC.h"
#import "ReferVC.h"
#import "SalonListingCell.h"
#import "ListingVC.h"
#import "TopWalletBar.h"
#import "DoctorListingCell.h"
#import "DiagnosticsListingCell.h"
#import "SalonListingData.h"
#import "DoctorsLisitingData.h"
#import "DiagnosticsListingData.h"
#import "VerticalListingServices.h"

#ifndef Ziffi_Constants_h
#define Ziffi_Constants_h

#define GreenColor @"0AB4B4"
#define RedColor @"DF4A32"
#define BlueColor @"49639F"
#define BackGroundColor @"E5E6E7"
#define TabBarColor @"0C2238"

#define FONTBOLD @"Roboto-Bold"
#define FONTLIGHT @"Roboto-Light"
#define FONTREGULAR @"Roboto-Regular"
#define FONTMEDIUM @"Roboto-Medium"

#define FACEBOOK_ID_PRO @"181896131828390"
#define FACEBOOK_ID_DEV @"838403506246406"
#define GOOGLE_ID_PRO @"AIzaSyBi_CbFLs4_JuEtbdaxyNswjPepB0L-mb0"
#define GOOGLE_ID_DEV @"988738071539-ob6669vrbt73hul2pgrket8pu9n4ip8g.apps.googleusercontent.com"

#define APP_NAME @"Ziffi - Custormer App"

//==================================================================
//============ ALL Messages =================================
//==================================================================
#pragma mark ALL Messages
#define FBWarningForUserprofile @"Sorry ! Could not fetch user details, please try again later"
#define FBWarningForPermission @"Sorry ! You have to give us permission to read your basic profile"
#define FBWarningForCancelled @"Opps ! You have cancelled the facebook login process"
#define GOWarningForUserprofile @"Sorry ! Could not fetch user details, please try again later"
#define ReachabilityWarning @"Sorry ! It seems that you are not connected to internet. Please try again"

//Login and Registration
#define EmailWarning @"Sorry ! Please enter correct email address"
#define PasswordWarning @"Sorry ! Password field should not be blank"
#define NameWarning @"Sorry ! Please enter valid name"
#define ContactWarning @"Sorry ! Please enter valid contact no."
#define PasswordMisMatchWarning @"Sorry ! Your password and confirm password does not match. Please correct it !"
#define ValidTextWarning @"Sorry ! Please enter e-mail or mobile number"
#define OTPTextWarning @"Sorry ! Please enter correct OTP"

//==================================================================
//============ API CALLS =================================
//==================================================================
#ifdef DEBUG
#define kAPIEndpointHost @"http://10.0.0.8/api/"
#else
#define kAPIEndpointHost @"http://www.example.com"
#endif

#define LOGIN                                           [kAPIEndpointHost stringByAppendingString:@"login"]
#define REGISTER                                    [kAPIEndpointHost stringByAppendingString:@"register"]
#define FORGET_PASSWORD                     [kAPIEndpointHost stringByAppendingString:@"login/resetpassword"]
#define VERIFY_PASSWORD                     [kAPIEndpointHost stringByAppendingString:@"login/setpassword"]
#define UPDATE_PROFILE                          [kAPIEndpointHost stringByAppendingString:@"account/verify_profile"]
#define VERIFY_PROFILE_OTP                  [kAPIEndpointHost stringByAppendingString:@"account/verify"]
#define DISCOUNTS                                [kAPIEndpointHost stringByAppendingString:@"discounts/listing"]
#define SUGGESTIONQUERY                                [kAPIEndpointHost stringByAppendingString:@"search/suggestions/q"]
#define LOCATIONSUGGESTIONQUERY                                [kAPIEndpointHost stringByAppendingString:@"search/suggestions/location"]
#define SEARCHQUERY                                [kAPIEndpointHost stringByAppendingString:@"search/"]

#endif
