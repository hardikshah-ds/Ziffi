//
//  UserData.m
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "UserData.h"

@implementation UserData

- (id) init
{
    if (self = [super init])
    {
        self.user_email = @"";
        self.user_facebookid = @"";
        self.user_firstname = @"";
        self.user_gender = @"";
        self.user_lastname = @"";
        self.user_name = @"";
        self.user_profilepic = @"";
        self.user_profile_verified = @"";
        self.user_phone = @"";
        self.user_city = @"";
        self.user_preferred_city = @"";
        self.user_preferred_city_name = @"";
        self.user_wallet_integrated = 0;
        self.user_session_name = @"";
        self.user_session_id = @"";
        self.user_ziffi_balance = @"";
        self.user_own_balance = @"";
        self.user_total_balance = @"";
        self.user_wallet_status = @"";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.user_email = [decoder decodeObjectForKey:@"user_email"];
        self.user_facebookid = [decoder decodeObjectForKey:@"user_facebookid"];
        self.user_firstname = [decoder decodeObjectForKey:@"user_firstname"];
        self.user_gender = [decoder decodeObjectForKey:@"user_gender"];
        self.user_lastname = [decoder decodeObjectForKey:@"user_lastname"];
        self.user_name = [decoder decodeObjectForKey:@"user_name"];
        self.user_profilepic = [decoder decodeObjectForKey:@"user_profilepic"];
        self.user_profile_verified = [decoder decodeObjectForKey:@"user_profile_verified"];
        self.user_phone = [decoder decodeObjectForKey:@"user_phone"];
        self.user_city = [decoder decodeObjectForKey:@"user_city"];
        self.user_preferred_city = [decoder decodeObjectForKey:@"user_preferred_city"];
        self.user_preferred_city_name = [decoder decodeObjectForKey:@"user_preferred_city_name"];
        self.user_wallet_integrated = [[decoder decodeObjectForKey:@"user_wallet_integrated"] boolValue];
        self.user_session_name = [decoder decodeObjectForKey:@"user_session_name"];
        self.user_session_id = [decoder decodeObjectForKey:@"user_session_id"];
        self.user_ziffi_balance = [decoder decodeObjectForKey:@"user_ziffi_balance"];
        self.user_own_balance = [decoder decodeObjectForKey:@"user_own_balance"];
        self.user_total_balance = [decoder decodeObjectForKey:@"user_total_balance"];
        self.user_wallet_status = [decoder decodeObjectForKey:@"user_wallet_status"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.user_email forKey:@"user_email"];
    [encoder encodeObject:self.user_facebookid forKey:@"user_facebookid"];
    [encoder encodeObject:self.user_firstname forKey:@"user_firstname"];
    [encoder encodeObject:self.user_gender forKey:@"user_gender"];
    [encoder encodeObject:self.user_lastname forKey:@"user_lastname"];
    [encoder encodeObject:self.user_name forKey:@"user_name"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_profile_verified"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_phone"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_city"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_preferred_city"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_preferred_city_name"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_wallet_integrated"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_session_name"];
    [encoder encodeObject:self.user_profilepic forKey:@"user_session_id"];
    [encoder encodeObject:self.user_ziffi_balance forKey:@"user_ziffi_balance"];
    [encoder encodeObject:self.user_own_balance forKey:@"user_own_balance"];
    [encoder encodeObject:self.user_total_balance forKey:@"user_total_balance"];
    [encoder encodeObject:self.user_wallet_status forKey:@"user_wallet_status"];
}




@end
