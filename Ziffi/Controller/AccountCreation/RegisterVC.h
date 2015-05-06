//
//  RegisterVC.h
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class GPPSignInButton;

@interface RegisterVC : UIViewController<GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScroll;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userContactNo;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UITextField *userRepassword;
@property (weak, nonatomic) IBOutlet UITextField *userReferral;
@property (strong, nonatomic) NSString *userGender;

- (IBAction)LoginWithFacebook:(id)sender;
- (IBAction)RegisterWithZiffi:(id)sender;
- (IBAction)GenderSelection:(id)sender;

@end
