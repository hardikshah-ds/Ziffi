//
//  OfferListingCell.h
//  Ziffi
//
//  Created by Hardik on 15/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferListingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *offerText;
@property (weak, nonatomic) IBOutlet UILabel *offerPrice;
@property (weak, nonatomic) IBOutlet UILabel *offerCode;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
