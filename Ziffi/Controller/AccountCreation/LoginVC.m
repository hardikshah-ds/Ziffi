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
    
    self.emailAddress.text = @"shaha@gmail.com";
    self.password.text = @"aaa";
    [self SetAttributedTextForSignup];
}

-(void)SetAttributedTextForSignup
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    UIColor *foregroundColor = [UIColor whiteColor];
    
    UIFont *font1 = [UIFont fontWithName:@"Roboto-Regular" size:14];
    UIFont *font2 = [UIFont fontWithName:@"Roboto-Bold" size:14];
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font1,
                            foregroundColor:NSForegroundColorAttributeName,
                            NSParagraphStyleAttributeName:style}; // Added line
    NSDictionary *dict2 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                            NSFontAttributeName:font2,
                            foregroundColor:NSForegroundColorAttributeName,
                            NSParagraphStyleAttributeName:style}; // Added line
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Don't have an account? "    attributes:dict1]];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Sign Up Now"      attributes:dict2]];
    [self.textSignupBtn setAttributedTitle:attString forState:UIControlStateNormal];
    [[self.textSignupBtn titleLabel] setNumberOfLines:0];
    [[self.textSignupBtn titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    [[self.textSignupBtn titleLabel] setTextColor:[UIColor whiteColor]];
    
    
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
                [LoginModuleServices LoginWithZiffi:self.emailAddress.text withPassword:self.password.text withCompletionHandler:^(NSInteger success) {
                    if (success == LoginStatusSuccessfulWithOutVerication) {
                        [SVProgressHUD showSuccessWithStatus:@"Login with ziffi successful with out verification"];
                        ProfileVerificationVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVerification"];
                        [self.navigationController pushViewController:newView animated:YES];
                    }
                    else if (success == LoginStatusSuccessfulWithVerication)
                    {
                        [SVProgressHUD showSuccessWithStatus:@"Login with ziffi successful with verification"];
                        AppDelegate  *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [appD LoadStoryBoardWithMainTabModule];

                    }
                    else {
                        //[SVProgressHUD showSuccessWithStatus:@"Error in Login with ziffi"];
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
        [LoginModuleServices LoginWithFacebook:^(NSInteger success) {
            if (success == LoginStatusSuccessfulWithOutVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with facebook successful with out verification"];
                ProfileVerificationVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVerification"];
                [self.navigationController pushViewController:newView animated:YES];
            }
            else if (success == LoginStatusSuccessfulWithVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with facebook successful with verification"];
                AppDelegate  *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appD LoadStoryBoardWithMainTabModule];
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

-(IBAction)LoginWithGoogle:(id)sender
{
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.clientID= GOOGLE_ID_DEV;
    [signIn setScopes:[NSArray arrayWithObject:@"https://www.googleapis.com/auth/plus.login"]];
    [signIn setDelegate:self];
    signIn.shouldFetchGoogleUserID=YES;
    signIn.shouldFetchGoogleUserEmail=YES;
    [signIn authenticate];
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
        [LoginModuleServices LoginWithGoogle:^(NSInteger success) {
            if (success == LoginStatusSuccessfulWithOutVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with google successful with out verification"];
                ProfileVerificationVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVerification"];
                [self.navigationController pushViewController:newView animated:YES];
            }
            else if (success == LoginStatusSuccessfulWithVerication) {
                [SVProgressHUD showSuccessWithStatus:@"Login with google successful with verification"];
                AppDelegate  *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appD LoadStoryBoardWithMainTabModule];

            }
            else {
                //[SVProgressHUD showSuccessWithStatus:@"Error in Login with google"];
            }
            
            
        }];
    }
}

@end
