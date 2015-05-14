//
//  ShadowView.m
//  Ziffi
//
//  Created by Hardik on 13/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1,1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;

    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.clipsToBounds = NO;
}


@end
