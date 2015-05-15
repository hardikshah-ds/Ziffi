//
//  ProfileVerificationVC.m
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "ProfileVerificationVC.h"

@interface ProfileVerificationVC ()

@end

@implementation ProfileVerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadWithInitialValues];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LoadWithInitialValues
{
    UserData *object = [CommonFunctions retriveCompleteUserData];
    self.updateProfileView.hidden = NO;
    self.otpView.hidden = YES;
    self.userEmail.text = object.user_email;
    self.userGender = @"Male";
}

- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)genderSelection:(id)sender {
    
    if ([sender tag] == 0) {
        
        [self.genderMale setBackgroundImage:[UIImage imageNamed:@"male-tap"] forState:UIControlStateNormal];
        [self.genderFemale setBackgroundImage:[UIImage imageNamed:@"female"] forState:UIControlStateNormal];
        self.userGender = @"Male";
    }
    else {
        
        [self.genderFemale setBackgroundImage:[UIImage imageNamed:@"female-tap"] forState:UIControlStateNormal];
        [self.genderMale setBackgroundImage:[UIImage imageNamed:@"male"] forState:UIControlStateNormal];
        self.userGender = @"Female";
    }
}

- (IBAction)submitProfile:(id)sender {
    
    if ([CommonFunctions isNetworkReachable]) {
        
        if ([self FieldValidation]) {
            
            [SVProgressHUD showWithStatus:@"Loading..."];
            NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
            [LoginModuleServices UpdateProfile:self.userEmail.text withName:self.userName.text withContactNo:self.userContactno.text withGender:self.userGender withSessionId:sessionid withCompletionHandler:^(bool success) {
                if (success) {
                    
                    [SVProgressHUD dismiss];
                    self.updateProfileView.hidden = YES;
                    self.otpView.hidden = NO;
                }
            }];
        }
    }
    
}

- (IBAction)verifyProfileWithOTP:(id)sender {
    
    if ([CommonFunctions isNetworkReachable]) {
        
        if ([self.textOTP.text length] > 0) {
            
            [SVProgressHUD showWithStatus:@"Loading..."];
            NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
            [LoginModuleServices UpdateProfileWithOTP:self.textOTP.text withSessionId:sessionid withContactNo:self.userContactno.text withCompletionHandler:^(bool success) {
                if (success) {
                    //Redirect to home screen
                    [SVProgressHUD dismiss];
                    AppDelegate  *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [appD LoadStoryBoardWithMainTabModule];
                }
            }];
        }
    }
}

-(BOOL)FieldValidation {
    
    if ([self.userName.text length] > 0) {
        
        if ([self.userContactno.text length] > 0) {
            
            if ([self.userEmail.text length] > 0 && [CommonFunctions NSStringIsValidEmail:self.userEmail.text]) {
                return YES;
            }
            else {
                [CommonFunctions showWarningAlert:EmailWarning title:APP_NAME];
                return NO;
            }
            
        }
        else {
            [CommonFunctions showWarningAlert:ContactWarning title:APP_NAME];
            return NO;
        }
        
    }
    else {
        [CommonFunctions showWarningAlert:NameWarning title:APP_NAME];
        return NO;
    }
}
@end
