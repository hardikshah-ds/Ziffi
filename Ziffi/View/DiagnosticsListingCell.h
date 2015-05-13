//
//  DiagnosticsListingCell.h
//  Ziffi
//
//  Created by Hardik on 13/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiagnosticsListingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *diagnosticsName;
@property (weak, nonatomic) IBOutlet UILabel *diagnosticsTime;
@property (weak, nonatomic) IBOutlet UILabel *diagnosticsAddress;
@property (weak, nonatomic) IBOutlet UILabel *diagnosticsDistance;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
