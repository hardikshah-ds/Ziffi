//
//  LoginVC.m
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC
@synthesize signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[GPPSignIn sharedInstance] trySilentAuthentication];
//    if ([[GPPSignInButton sharedInstance] authentication]) {
//        NSLog(@"Already Login With Google");
//    }
//    else{
//        NSLog(@"Not Login With Google");
//    }
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login Methods

- (IBAction)LoginWithZiffi:(id)sender {
    
    if ([CommonFunctions isNetworkReachable]) {
        if ([CommonFunctions NSStringIsValidEmail:self.emailAddress.text]) {
            if ([self.password.text length] > 0) {
                
                [SVProgressHUD showWithStatus:@"Loading..."];
                [WebServices LoginWithZiffi:self.emailAddress.text withPassword:self.password.text withCompletionHandler:^(NSInteger success) {
                    if (success == LoginStatusSuccessfulWithOutVerication) {
                        [SVProgressHUD showSuccessWithStatus:@"Login with ziffi successful with out verification"];
                        ProfileVerificationVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVerification"];
                        [self.navigationController pushViewController:newView animated:YES];
                    }
                    else if (success == LoginStatusSuccessfulWithVerication)
                    {
                        [SVProgressHUD showSuccessWithStatus:@"Login with ziffi successful with verification"];
                        HomeVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                        [self.navigationController pushViewController:newView animated:YES];

                    }
                    else {
                        [SVProgressHUD showSuccessWithStatus:@"Error in Login with ziffi"];
                    }
                }];
            }
            else {
                [CommonFunctions showWarningAlert:PasswordWarning title:APP_NAME];
            }
        }
        else {
            [CommonFunctions showWarningAlert:EmailWarning title:APP_NAME];
        }
    }
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
}



-(IBAction)LoginWithFacebook:(id)sender
{
    if ([CommonFunctions isNetworkReachable]) {

        [SVProgressHUD showWithStatus:@"Loading..."];
        [WebServices LoginWithFacebook:^(NSInteger success) {
            if (success == LoginStatusSuccessfulWithOutVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with facebook successful with out verification"];
                ProfileVerificationVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVerification"];
                [self.navigationController pushViewController:newView animated:YES];
            }
            else if (success == LoginStatusSuccessfulWithVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with facebook successful with verification"];
                HomeVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                [self.navigationController pushViewController:newView animated:YES];

            }
            else {
                [SVProgressHUD showSuccessWithStatus:@"Error in Login with facebook"];
            }
        }];
    }
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
}

#pragma mark - Login With Google Delegates

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        // Do some error handling here.
    } else {
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [WebServices LoginWithGoogle:^(NSInteger success) {
            if (success == LoginStatusSuccessfulWithOutVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with google successful with out verification"];
                ProfileVerificationVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVerification"];
                [self.navigationController pushViewController:newView animated:YES];
            }
            else if (success == LoginStatusSuccessfulWithVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with google successful with verification"];
                HomeVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                [self.navigationController pushViewController:newView animated:YES];

            }
            else {
                [SVProgressHUD showSuccessWithStatus:@"Error in Login with google"];
            }
            
            
        }];
    }
}

@end
