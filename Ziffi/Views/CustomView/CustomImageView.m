//
//  CustomImageView.m
//  Ziffi
//
//  Created by Hardik on 12/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView


- (void)awakeFromNib {
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;
    self.clipsToBounds = NO;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
}


@end
