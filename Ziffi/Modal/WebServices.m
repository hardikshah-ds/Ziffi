//
//  WebServices.m
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices


#pragma mark - Login and Register Methods

+ (void)LoginWithFacebook:(void (^)(NSInteger success))callback
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            [CommonFunctions showWarningAlert:error.description title:APP_NAME];
            callback(LoginStatusFailed);
            
        } else if (result.isCancelled) {
            // Handle cancellations
            [CommonFunctions showWarningAlert:FBWarningForCancelled title:APP_NAME];
            callback(LoginStatusFailed);
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"public_profile"]) {
                // Do work
                NSLog(@"%@",result);
                if ([FBSDKAccessToken currentAccessToken]) {
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             NSLog(@"fetched user:%@", result);
                             UserData *objUser = [[UserData alloc]init];
                             if ([result objectForKey:@"email"] != [NSNull null] || [result objectForKey:@"email"] != nil) {
                                 NSString *userEmail = (NSString *)[result objectForKey:@"email"];
                                 objUser.user_email = userEmail;
                             }
                             if ([result objectForKey:@"first_name"] != [NSNull null] || [result objectForKey:@"first_name"] != nil) {
                                 NSString *userFirstName = (NSString *)[result objectForKey:@"first_name"];
                                 objUser.user_firstname = userFirstName;
                             }
                             if ([result objectForKey:@"gender"] != [NSNull null] || [result objectForKey:@"gender"] != nil) {
                                 NSString *userGender = (NSString *)[result objectForKey:@"gender"];
                                 objUser.user_gender = userGender;
                             }
                             if ([result objectForKey:@"id"] != [NSNull null] || [result objectForKey:@"id"] != nil) {
                                 NSString *userId = (NSString *)[result objectForKey:@"id"];
                                 objUser.user_facebookid = userId;
                                 NSString *finalUserProfileImage = [NSString stringWithFormat:@"http://graph.facebook.com/%@/?fields=picture&type=large",[result objectForKey:@"id"]];
                                 objUser.user_profilepic = finalUserProfileImage;
                             }
                             if ([result objectForKey:@"last_name"] != [NSNull null] || [result objectForKey:@"last_name"] != nil) {
                                 NSString *userLastname = (NSString *)[result objectForKey:@"last_name"];
                                 objUser.user_lastname = userLastname;
                             }
                             if ([result objectForKey:@"name"] != [NSNull null] || [result objectForKey:@"name"] != nil) {
                                 NSString *userName = (NSString *)[result objectForKey:@"name"];
                                 objUser.user_name = userName;
                             }
                             
                             [self RegisterWithZiffi:objUser.user_email withPassword:objUser.user_facebookid withConfirmPassword:objUser.user_facebookid withFirstname:objUser.user_firstname withGender:objUser.user_gender withPhone:@"" withReferral:@"" withCompletionHandler:^(NSInteger success) {
                                 if (success ==  LoginStatusSuccessfulWithOutVerication) {
                                     callback(LoginStatusSuccessfulWithOutVerication);
                                 }
                                 else if (success == LoginStatusSuccessfulWithVerication)
                                 {
                                     callback(LoginStatusSuccessfulWithVerication);
                                 }
                                 else {
                                     callback(LoginStatusFailed);
                                 }
                             }];
                         }
                         else {
                             [CommonFunctions showWarningAlert:FBWarningForUserprofile title:APP_NAME];
                             callback(LoginStatusFailed);
                         }
                     }];
                }
            }
            else {
                [CommonFunctions showWarningAlert:FBWarningForPermission title:APP_NAME];
                callback(LoginStatusFailed);
            }
        }
    }];
}

+ (void)LoginWithGoogle:(void (^)(NSInteger success))callback
{
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    NSLog(@"email %@ ", [NSString stringWithFormat:@"Email: %@",[GPPSignIn sharedInstance].authentication.userEmail]);
    
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
    plusService.apiVersion = @"v1";
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPerson *person,
                                NSError *error) {
                if (error) {
                    [CommonFunctions showWarningAlert:GOWarningForUserprofile title:APP_NAME];
                    callback(LoginStatusFailed);
                } else {
                    NSLog(@"Email= %@", [GPPSignIn sharedInstance].authentication.userEmail);
                    NSLog(@"GoogleID=%@", person.identifier);
                    NSLog(@"User Name=%@", [person.name.givenName stringByAppendingFormat:@" %@", person.name.familyName]);
                    NSLog(@"Gender=%@", person.gender);
                    NSLog(@"Image=%@", person.image);
                    NSLog(@"Name=%@", person.name.givenName);
                    
                    UserData *objUser = [[UserData alloc]init];
                    if ([GPPSignIn sharedInstance].authentication.userEmail != NULL || [GPPSignIn sharedInstance].authentication.userEmail != nil) {
                        objUser.user_email = [GPPSignIn sharedInstance].authentication.userEmail;
                    }
                    if (person.name.givenName != NULL || person.name.givenName != nil) {
                        objUser.user_firstname = person.name.givenName;
                    }
                    if (person.gender != NULL || person.gender != nil) {
                        objUser.user_gender = person.gender;
                    }
                    if (person.identifier != NULL || person.identifier != nil) {
                        objUser.user_facebookid = person.identifier;
                    }
                    if (person.name.familyName != NULL || person.name.familyName != nil) {
                        objUser.user_lastname = person.name.familyName;
                    }
                    if (person.nickname != NULL || person.nickname != nil) {
                        objUser.user_name = person.nickname;
                    }
                    
                    if (person.image != NULL || person.image != nil) {
                        objUser.user_profilepic = person.image.url;
                    }

                    [self RegisterWithZiffi:objUser.user_email withPassword:objUser.user_facebookid withConfirmPassword:objUser.user_facebookid withFirstname:objUser.user_firstname withGender:objUser.user_gender withPhone:@"" withReferral:@"" withCompletionHandler:^(NSInteger success) {
                        if (success ==  LoginStatusSuccessfulWithOutVerication) {
                            callback(LoginStatusSuccessfulWithOutVerication);
                        }
                        else if (success == LoginStatusSuccessfulWithVerication)
                        {
                            callback(LoginStatusSuccessfulWithVerication);
                        }
                        else {
                            callback(LoginStatusFailed);
                        }
                    }];
                }
            }];
}


+ (void)LoginWithZiffi:(NSString *)emailAddress withPassword:(NSString *)password withCompletionHandler:(void (^)(NSInteger success))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"email" : emailAddress, @"pass" : password};
    [manager POST:LOGIN parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if ([[[jsonObject objectForKey:@"message"] objectForKey:@"result"] boolValue] == false) {
            [SVProgressHUD showErrorWithStatus:[[jsonObject objectForKey:@"message"] objectForKey:@"errors"]];
            callback(LoginStatusFailed);
        }
        else {
            
            UserData *objUser = [[UserData alloc]init];
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"email"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"email"] != nil) {
                NSString *userEmail = (NSString *)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"email"];
                objUser.user_email = userEmail;
            }
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"id"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"id"] != nil) {
                NSString *userId = (NSString *)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"id"];
                objUser.user_facebookid = userId;
            }
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"image"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"image"] != nil) {
                NSString *userImage = (NSString *)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"image"];
                objUser.user_profilepic = userImage;
            }
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"city"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"city"] != nil) {
                NSString *userCity = (NSString *)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"city"];
                objUser.user_city = userCity;
            }
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"preferred_city"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"preferred_city"] != nil) {
                NSString *userPreferred_city = (NSString *)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"preferred_city"];
                objUser.user_preferred_city = userPreferred_city;
            }
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"preferred_city_name"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"preferred_city_name"] != nil) {
                NSString *userPreferred_city_name = (NSString *)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"preferred_city_name"];
                objUser.user_preferred_city_name = userPreferred_city_name;
            }
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"wallet_integrated"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"wallet_integrated"] != nil) {
                BOOL userWallet_integrated = (BOOL)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"wallet_integrated"];
                objUser.user_wallet_integrated = userWallet_integrated;
            }
            if ([[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"city"] != [NSNull null] ||
                [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"city"] != nil) {
                NSString *userCity = (NSString *)[[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"city"];
                objUser.user_city = userCity;
            }
            if ([jsonObject objectForKey:@"session_id"] != [NSNull null] ||
                [jsonObject objectForKey:@"session_id"] != nil) {
                NSString *userSessionId = (NSString *)[jsonObject objectForKey:@"session_id"];
                objUser.user_session_id= userSessionId;
            }
            

            NSMutableArray *temp = [[[jsonObject objectForKey:@"message"] objectForKey:@"user_data"] objectForKey:@"profiles"];
            if ([temp count] > 0) {
                
                for (int i =0 ; i<[temp count]; i++) {
                    NSDictionary *tempDict = [temp objectAtIndex:0];
                    if ([[tempDict objectForKey:@"main"] boolValue] == true) {
                        
                    
                        if ([tempDict objectForKey:@"first_name"] != [NSNull null] || [tempDict objectForKey:@"first_name"] != nil) {
                            NSString *userFirstName = (NSString *)[tempDict objectForKey:@"first_name"];
                            objUser.user_firstname = userFirstName;
                        }
                        if ([tempDict objectForKey:@"gender"] != [NSNull null] || [tempDict objectForKey:@"gender"] != nil) {
                            NSString *userGender = (NSString *)[tempDict objectForKey:@"gender"];
                            objUser.user_gender = userGender;
                        }
                        if ([tempDict objectForKey:@"last_name"] != [NSNull null] || [tempDict objectForKey:@"last_name"] != nil) {
                            NSString *userLastname = (NSString *)[tempDict objectForKey:@"last_name"];
                            objUser.user_lastname = userLastname;
                        }
                        if ([tempDict objectForKey:@"phone"] != [NSNull null] || [tempDict objectForKey:@"phone"] != nil) {
                            NSString *userName = (NSString *)[tempDict objectForKey:@"phone"];
                            objUser.user_phone = userName;
                        }
                        
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        if ([[tempDict objectForKey:@"profile_verified"] boolValue] == true) {
                            callback(LoginStatusSuccessfulWithVerication);
                            break;
                        }
                        else{
                            callback(LoginStatusSuccessfulWithOutVerication);
                            break;
                        }
                        
                    }
                }
            }
            
            NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:objUser];
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setValue:objUser.user_facebookid forKey:@"UserId"];
            [prefs setValue:objUser.user_session_id forKey:@"SessionId"];
            [prefs setObject:myEncodedObject forKey:@"UserData"];
            [prefs synchronize];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(LoginStatusFailed);
    }];
}


+ (void)RegisterWithZiffi:(NSString *)emailAddress
             withPassword:(NSString *)password
      withConfirmPassword:(NSString *)confiormPassword
            withFirstname:(NSString *)firstName
               withGender:(NSString *)gender
                withPhone:(NSString *)phone
                    withReferral:(NSString *)referral
                    withCompletionHandler:(void (^)(NSInteger success))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"email" : emailAddress, @"pass" : password, @"pass2" : confiormPassword, @"first_name" : firstName, @"gender" : gender, @"phone" : phone, @"referral_code" : referral};
    [manager POST:REGISTER parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if ([[[jsonObject objectForKey:@"user"] objectForKey:@"result"]boolValue] == false) {
            //[SVProgressHUD showErrorWithStatus:[[jsonObject objectForKey:@"user"] objectForKey:@"errors"]];
        }
        else {
            [SVProgressHUD dismiss];
        }
        [self LoginWithZiffi:emailAddress withPassword:password withCompletionHandler:^(NSInteger success) {
            if (success == LoginStatusSuccessfulWithOutVerication) {
                callback(LoginStatusSuccessfulWithOutVerication);
            }
            else if (success == LoginStatusSuccessfulWithVerication) {
                callback(LoginStatusSuccessfulWithVerication);
            }
            else {
                callback(LoginStatusFailed);
            }
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(LoginStatusFailed);
    }];
}

#pragma mark - Forget and Reset Methods
+(void)ForgetPassword:(NSString *)resetText withCompletionHandler:(void (^)(NSInteger success))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"source_type" : resetText};
    [manager POST:FORGET_PASSWORD parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if ([[[jsonObject objectForKey:@"result"] objectForKey:@"status"] boolValue] == false) {
            [SVProgressHUD showErrorWithStatus:[[jsonObject objectForKey:@"result"] objectForKey:@"message"]];
            callback(ResultStatusFailed);
        }
        else {
            
            [[NSUserDefaults standardUserDefaults]setValue:[[jsonObject objectForKey:@"result"] objectForKey:@"user_id"] forKey:@"UserId"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            if ([[[jsonObject objectForKey:@"result"] objectForKey:@"is_email"] boolValue] == true) {
                
                [CommonFunctions showWarningAlert:[[jsonObject objectForKey:@"result"] objectForKey:@"message"] title:APP_NAME];
                callback(ResultWithIsEmailTrue);
                [SVProgressHUD dismiss];
            }
            else {
                
                [CommonFunctions showWarningAlert:[[jsonObject objectForKey:@"result"] objectForKey:@"message"] title:APP_NAME];
                callback(ResultWithIsMobileTrue);
                [SVProgressHUD dismiss];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(ResultStatusFailed);
    }];

}

+(void)VerifyPasswordWithOTP:(NSString *)textOTP
               withPass1:(NSString *)password
                  withPass2:(NSString *)confirmPassword
                   withUserid:(NSString *)userid
       withCompletionHandler:(void (^)(NSInteger success))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"code" : textOTP, @"pass" : password, @"pass2" : confirmPassword, @"id" : userid};
    [manager POST:VERIFY_PASSWORD parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if ([[[jsonObject objectForKey:@"result"] objectForKey:@"status"] boolValue] == false) {
            [SVProgressHUD showErrorWithStatus:[[jsonObject objectForKey:@"result"] objectForKey:@"message"]];
            callback(ResultStatusFailed);
        }
        else {
            [SVProgressHUD showSuccessWithStatus:[[jsonObject objectForKey:@"result"] objectForKey:@"message"]];
            callback(ResultStatusSuccess);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(ResultStatusFailed);
    }];
    
}


#pragma mark - Update Profile Methods
+(void)UpdateProfile:(NSString *)emailAddress
           withName:(NSString *)name
           withContactNo:(NSString *)contactno
           withGender:(NSString *)gender
          withSessionId:(NSString *)sessionId
withCompletionHandler:(void (^)(bool success))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"name" : name, @"phone" : contactno,@"gender" : gender, @"session_id" : sessionId};
    [manager POST:UPDATE_PROFILE parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if ([[jsonObject objectForKey:@"is_error"] boolValue] == false) {
            NSMutableArray *arr = [jsonObject objectForKey:@"message"];
            [CommonFunctions showWarningAlert:[arr objectAtIndex:1] title:APP_NAME];
            callback(YES);
        }
        else {
            
            NSMutableArray *arr = [jsonObject objectForKey:@"message"];
            [SVProgressHUD showErrorWithStatus:[arr objectAtIndex:0]];
            callback(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(NO);
    }];
}


+(void)UpdateProfileWithOTP:(NSString *)textOTP
              withSessionId:(NSString *)sessionId
              withContactNo:(NSString *)contactno
            withCompletionHandler:(void (^)(bool success))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"verification-code" : textOTP,@"profile-phone":contactno, @"session_id" : sessionId};
    [manager POST:VERIFY_PROFILE_OTP parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if ([[jsonObject objectForKey:@"is_phone_verified"] boolValue] == false) {
            NSMutableArray *arr = [jsonObject objectForKey:@"message"];
            [CommonFunctions showWarningAlert:[arr objectAtIndex:0] title:APP_NAME];
            callback(NO);
        }
        else {
            callback(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(NO);
    }];
}

@end
