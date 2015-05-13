//
//  LoginVC.h
//  Ziffi
//
//  Created by Hardik on 05/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class GPPSignInButton;

@interface LoginVC : BaseVC <GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *textSignupBtn;

- (IBAction)LoginWithFacebook:(id)sender;
- (IBAction)LoginWithZiffi:(id)sender;

@end
