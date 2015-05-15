//
//  TopWalletBar.h
//  Ziffi
//
//  Created by Hardik on 12/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopWalletBar : UIView

@property (nonatomic,strong) UIButton *backButton;

-(void)popNavigation:(id)sender;
-(void)ShowBackButton;
@end
