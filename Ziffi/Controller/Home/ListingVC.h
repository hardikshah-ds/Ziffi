//
//  ListingVC.h
//  Ziffi
//
//  Created by Hardik on 08/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface ListingVC : BaseVC

@property (weak, nonatomic) IBOutlet UITableView *listingTable;
@property (nonatomic, strong) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) NSString *searchText;
@property (nonatomic) NSUInteger optionSelected;

@end
