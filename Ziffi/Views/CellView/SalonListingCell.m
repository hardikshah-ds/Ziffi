//
//  SalonListingCell.m
//  Ziffi
//
//  Created by Hardik on 08/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "SalonListingCell.h"

@implementation SalonListingCell

- (void)awakeFromNib {
    // Initialization code
    
//    self.myrateView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
//    self.myrateView.maximumValue = 5;
//    self.myrateView.minimumValue = 0;
//    self.myrateView.value = 0;
//    self.myrateView.tintColor = [UIColor whiteColor];
//    [self addSubview:self.myrateView];
    
    [self.bgView.layer setCornerRadius:0.0f];
    [self.bgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.bgView.layer setBorderWidth:0.5f];
    [self.bgView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [self.bgView.layer setShadowOpacity:0.5];
    [self.bgView.layer setShadowRadius:2.0];
    [self.bgView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
