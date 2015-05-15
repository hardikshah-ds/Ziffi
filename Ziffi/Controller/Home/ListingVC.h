//
//  ListingVC.h
//  Ziffi
//
//  Created by Hardik on 08/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "TablePagination.h"
#import "VerticalListingServices.h"

@interface ListingVC : BaseVC <ZiffiPaginationDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listingTable;
@property (nonatomic, strong) IBOutlet UITextField *searchTextField;

@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) VerticalListingServices *verticalListingServices;

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSString *locationText;
@property (nonatomic) NSUInteger optionSelected;
@property (strong, nonatomic) NSString *currentLat;
@property (strong, nonatomic) NSString *currentLong;


@end
