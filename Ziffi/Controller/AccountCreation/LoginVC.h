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

@interface LoginVC : UIViewController<GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)LoginWithFacebook:(id)sender;
- (IBAction)LoginWithZiffi:(id)sender;

@end
