//
//  SalonListingCell.h
//  Ziffi
//
//  Created by Hardik on 08/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SalonListingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *salonType;
@property (weak, nonatomic) IBOutlet UILabel *salonName;
@property (weak, nonatomic) IBOutlet UILabel *salonPrice;
@property (weak, nonatomic) IBOutlet UILabel *salonAddress;
@property (weak, nonatomic) IBOutlet UILabel *salonDistance;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
