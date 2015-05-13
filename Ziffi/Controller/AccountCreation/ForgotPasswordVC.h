//
//  ForgotPasswordVC.h
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ForgotPasswordVC : BaseVC

@property (weak, nonatomic) IBOutlet UITextField *resetWithText;
@property (weak, nonatomic) IBOutlet UIView *emailView;

@property (weak, nonatomic) IBOutlet UIView *phoneNumberView;
@property (weak, nonatomic) IBOutlet UITextField *textOTP;
@property (weak, nonatomic) IBOutlet UITextField *confirmNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *setNewPassword;

- (IBAction)SubmitPressedAfterEmail:(id)sender;
- (IBAction)SubmitPressedAfterMobile:(id)sender;

@end
