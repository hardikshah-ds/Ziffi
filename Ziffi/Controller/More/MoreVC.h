//
//  MoreVC.h
//  Ziffi
//
//  Created by Hardik on 11/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopWalletBar.h"

@interface MoreVC : UIViewController

@property (nonatomic, strong) IBOutlet UITextView *aboutUsText;
@property (nonatomic, strong) IBOutlet UIView *aboutUsView;
@property (nonatomic, strong) IBOutlet UITableView *moreTableView;

@property (nonatomic, strong) IBOutlet TopWalletBar *topView;
@property (nonatomic, strong) NSMutableArray *listArray;

@end
