//
//  RegisterVC.m
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()

@end

@implementation RegisterVC

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
    self.genderSegment.selectedSegmentIndex = 0;
    self.userGender = @"Male";
}

- (IBAction)RegisterWithZiffi:(id)sender {
    
    if ([CommonFunctions isNetworkReachable]) {
        if ([self FieldValidation]) {
            
            [SVProgressHUD showWithStatus:@"Loading..."];
            [WebServices RegisterWithZiffi:self.userEmail.text withPassword:self.userPassword.text withConfirmPassword:self.userRepassword.text  withFirstname:self.userName.text withGender:self.userGender withPhone:self.userContactNo.text withReferral:self.userReferral.text withCompletionHandler:^(NSInteger success) {
                if (success == LoginStatusSuccessfulWithOutVerication) {
                    [SVProgressHUD showSuccessWithStatus:@"Register with ziffi successful with out verification"];
                    ProfileVerificationVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVerification"];
                    [self.navigationController pushViewController:newView animated:YES];
                }
                else if (success == LoginStatusSuccessfulWithVerication)
                {
                    [SVProgressHUD showSuccessWithStatus:@"Register with ziffi successful with verification"];
                    HomeVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                    [self.navigationController pushViewController:newView animated:YES];
                }
                else {
                    [SVProgressHUD showSuccessWithStatus:@"Error in registration with ziffi"];
                }
            }];
        }
    }
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
}

- (IBAction)GenderSelection:(id)sender {
    
    if (self.genderSegment.selectedSegmentIndex == 0) {
        self.userGender = @"Male";
    }
    else {
        self.userGender = @"Female";
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

-(BOOL)FieldValidation {
    
    if ([self.userName.text length] > 0) {
        
        if ([self.userContactNo.text length] > 0) {
            
            if ([self.userPassword.text length] > 0) {
                
                if ([self.userRepassword.text length] > 0) {
                    
                    if ([self.userEmail.text length] > 0 && [CommonFunctions NSStringIsValidEmail:self.userEmail.text]) {
                        
                        if ([self.userPassword.text isEqualToString:self.userRepassword.text]) {
                                return YES;
                        }
                        else {
                            [CommonFunctions showWarningAlert:PasswordMisMatchWarning title:APP_NAME];
                            return NO;
                        }
                        
                    }
                    else {
                        [CommonFunctions showWarningAlert:EmailWarning title:APP_NAME];
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
