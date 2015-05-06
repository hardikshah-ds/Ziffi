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
    self.phoneNumberView.hidden = YES;
}

- (IBAction)SubmitPressedAfterEmail:(id)sender {
    
    
    if ([CommonFunctions isNetworkReachable]) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [WebServices ForgetPassword:self.resetWithText.text withCompletionHandler:^(NSInteger success) {
            if (success == ResultWithIsEmailTrue) {
                //Redirect to login page
                //[self.navigationController popToRootViewControllerAnimated:YES];
                self.phoneNumberView.hidden = NO;
                self.emailView.hidden = YES;
            }
            else if (success == ResultWithIsMobileTrue) {
                self.phoneNumberView.hidden = NO;
                self.emailView.hidden = YES;
            }
            else {
                //Redirect to register page
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
}

- (IBAction)SubmitPressedAfterMobile:(id)sender {
    
    
    if ([CommonFunctions isNetworkReachable]) {
        
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
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }

}
@end
