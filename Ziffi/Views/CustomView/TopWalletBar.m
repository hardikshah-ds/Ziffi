//
//  TopWalletBar.m
//  Ziffi
//
//  Created by Hardik on 12/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "TopWalletBar.h"
#import "UserData.h"
#import "CommonFunctions.h"

@implementation TopWalletBar

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(self.frame.origin.x + 5, self.frame.origin.y + 3, 20, 40);
    [backButton setImage:[UIImage imageNamed:@"black-back-arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popNavigation:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
    UILabel *myBalance = [[UILabel alloc]init];
    myBalance.frame = CGRectMake(self.frame.size.width - 141, self.frame.origin.y + 7, 100, 27);
    myBalance.textAlignment = NSTextAlignmentRight;
    myBalance.font = [UIFont fontWithName:@"Roboto-Light" size:14];
    UserData *object = [CommonFunctions retriveCompleteUserData];
    myBalance.text = [NSString stringWithFormat:@"\u20B9 %@", object.user_total_balance];;
    [self addSubview:myBalance];
    
    UIImageView *walletImage = [[UIImageView alloc]init];
    walletImage.frame = CGRectMake(self.frame.size.width - 36 , self.frame.origin.y + 7, 26, 21);
    walletImage.image = [UIImage imageNamed:@"wallet-icon"];
    [self addSubview:walletImage];
    
}

-(void)popNavigation:(id)sender
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"BackPressed"
     object:self];
}


@end
