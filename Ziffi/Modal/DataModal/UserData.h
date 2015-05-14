//
//  UserData.h
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property (nonatomic, strong) NSString *user_firstname;
@property (nonatomic, strong) NSString *user_lastname;
@property (nonatomic, strong) NSString *user_email;
@property (nonatomic, strong) NSString *user_profile_verified;
@property (nonatomic, strong) NSString *user_facebookid;
@property (nonatomic, strong) NSString *user_gender;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_phone;
@property (nonatomic, strong) NSString *user_city;
@property (nonatomic, strong) NSString *user_preferred_city;
@property (nonatomic, strong) NSString *user_preferred_city_name;
@property (nonatomic) BOOL user_wallet_integrated;
@property (nonatomic, strong) NSString *user_session_name;
@property (nonatomic, strong) NSString *user_session_id;
@property (nonatomic, strong) NSString *user_profilepic;
@property (nonatomic, strong) NSString *user_total_balance;
@property (nonatomic, strong) NSString *user_ziffi_balance;
@property (nonatomic, strong) NSString *user_own_balance;
@property (nonatomic, strong) NSString *user_wallet_status;

@end
