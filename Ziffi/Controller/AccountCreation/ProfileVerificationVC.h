//
//  ProfileVerificationVC.h
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "BaseVC.h"

@interface ProfileVerificationVC : BaseVC

@property (weak, nonatomic) IBOutlet UIView *updateProfileView;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userContactno;
@property (weak, nonatomic) IBOutlet UIButton *genderMale;
@property (weak, nonatomic) IBOutlet UIButton *genderFemale;
@property (strong, nonatomic) NSString *userGender;
@property (weak, nonatomic) IBOutlet UIView *otpView;
@property (weak, nonatomic) IBOutlet UITextField *textOTP;


- (IBAction)genderSelection:(id)sender;
- (IBAction)submitProfile:(id)sender;
- (IBAction)verifyProfileWithOTP:(id)sender;


@end
