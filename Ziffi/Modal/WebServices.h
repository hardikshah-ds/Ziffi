//
//  WebServices.h
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface WebServices : NSObject

typedef NS_ENUM(NSInteger, LoginStateType) {
    LoginStatusSuccessfulWithVerication,
    LoginStatusSuccessfulWithOutVerication,
    LoginStatusFailed
};


typedef NS_ENUM(NSInteger, ForgetPasswordStateType) {
    ResultWithIsEmailTrue,
    ResultWithIsMobileTrue,
    ResultStatusFailed,
    ResultStatusSuccess
};

#pragma mark - Login and Register Methods
//Registation
+ (void)LoginWithFacebook:(void (^)(NSInteger success))callback;
+ (void)LoginWithGoogle:(void (^)(NSInteger success))callback;
+ (void)LoginWithZiffi:(NSString *)emailAddress withPassword:(NSString *)password withCompletionHandler:(void (^)(NSInteger success))callback;
+ (void)RegisterWithZiffi:(NSString *)emailAddress
             withPassword:(NSString *)password
                withConfirmPassword:(NSString *)confiormPassword
                    withFirstname:(NSString *)firstName
                        withGender:(NSString *)gender
                            withPhone:(NSString *)phone
                            withReferral:(NSString *)referral
                                withCompletionHandler:(void (^)(NSInteger success))callback;

#pragma mark - Forget and Reset Methods
//Forget and reset password
+(void)ForgetPassword:(NSString *)resetText withCompletionHandler:(void (^)(NSInteger success))callback;
+(void)VerifyPasswordWithOTP:(NSString *)textOTP
                   withPass1:(NSString *)password
                   withPass2:(NSString *)confirmPassword
                  withUserid:(NSString *)userid
       withCompletionHandler:(void (^)(NSInteger success))callback;


#pragma mark - UpdateProfile Methods
//UpdateProfile
+(void)UpdateProfile:(NSString *)emailAddress
            withName:(NSString *)name
       withContactNo:(NSString *)contactno
          withGender:(NSString *)gender
          withSessionId:(NSString *)sessionId
withCompletionHandler:(void (^)(bool success))callback;

+(void)UpdateProfileWithOTP:(NSString *)textOTP
              withSessionId:(NSString *)sessionId
              withContactNo:(NSString *)contactno
      withCompletionHandler:(void (^)(bool success))callback;

@end
