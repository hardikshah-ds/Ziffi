//
//  ForgotPasswordVC.m
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()

@end

@implementation ForgotPasswordVC

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
    [self.resetWithText becomeFirstResponder];
    self.phoneNumberView.hidden = YES;
}

- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textValidation
{
    if ([self.textOTP.text length] > 0) {
        
        if ([self.setNewPassword.text length] > 0 ) {
            
            if ([self.confirmNewPassword.text length] > 0) {
                
                if ([self.setNewPassword.text isEqualToString:self.confirmNewPassword.text]) {
                    return YES;
                    
                }
                else{
                    [CommonFunctions showWarningAlert:PasswordMisMatchWarning title:APP_NAME];
                    return NO;
                }
                
            }
            else {
                [CommonFunctions showWarningAlert:PasswordWarning title:APP_NAME];
                return NO;
            }
        }
        else {
            [CommonFunctions showWarningAlert:PasswordWarning title:APP_NAME];
            return NO;
        }
    }
    else {
        [CommonFunctions showWarningAlert:OTPTextWarning title:APP_NAME];
        return NO;
    }
}

- (IBAction)SubmitPressedAfterEmail:(id)sender {
    
    
    if ([CommonFunctions isNetworkReachable]) {
        
        if ([self.resetWithText.text length] > 0) {
            [SVProgressHUD showWithStatus:@"Loading..."];
            [WebServices ForgetPassword:self.resetWithText.text withCompletionHandler:^(NSInteger success) {
                
                [self.resetWithText resignFirstResponder];
                if (success == ResultWithIsEmailTrue) {
                    //Redirect to login page
                    //[self.navigationController popToRootViewControllerAnimated:YES];
                    self.phoneNumberView.hidden = NO;
                    self.emailView.hidden = YES;
                }
                else if (success == ResultWithIsMobileTrue) {
                    
                    [self.textOTP becomeFirstResponder];
                    self.phoneNumberView.hidden = NO;
                    self.emailView.hidden = YES;
                }
                else {
                    //Redirect to register page
                    //[self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
        else{
            [CommonFunctions showWarningAlert:ValidTextWarning title:APP_NAME];
        }
    }
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
}

- (IBAction)SubmitPressedAfterMobile:(id)sender {
    
    
    if ([CommonFunctions isNetworkReachable]) {
        
        if ([self textValidation]) {
            
            [SVProgressHUD showWithStatus:@"Loading..."];
            
            
            NSString *userid = [[NSUserDefaults standardUserDefaults]valueForKey:@"UserId"];
            [WebServices VerifyPasswordWithOTP:self.textOTP.text withPass1:self.setNewPassword.text withPass2:self.confirmNewPassword.text withUserid:userid withCompletionHandler:^(NSInteger success) {
                if (success == ResultStatusSuccess) {
                    //Rerdirect to Login page
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else {
                    //Try again
                }
            }];
        }
    }
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }

}
@end
