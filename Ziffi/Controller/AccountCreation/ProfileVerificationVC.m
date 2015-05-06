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
    self.genderSegment.selectedSegmentIndex = 0;
    self.userGender = @"Male";
}

- (IBAction)genderSelection:(id)sender {
    
    if (self.genderSegment.selectedSegmentIndex == 0) {
        self.userGender = @"Male";
    }
    else {
        self.userGender = @"Female";
    }
}

- (IBAction)submitProfile:(id)sender {
    
    if ([CommonFunctions isNetworkReachable]) {
        
        if ([self FieldValidation]) {
            
            NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
            [WebServices UpdateProfile:self.userEmail.text withName:self.userName.text withContactNo:self.userContactno.text withGender:self.userGender withSessionId:sessionid withCompletionHandler:^(bool success) {
                if (success) {
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
            
            NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
            [WebServices UpdateProfileWithOTP:self.textOTP.text withSessionId:sessionid withContactNo:self.userContactno.text withCompletionHandler:^(bool success) {
                if (success) {
                    //Redirect to home screen
                    HomeVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                    [self.navigationController pushViewController:newView animated:YES];
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
