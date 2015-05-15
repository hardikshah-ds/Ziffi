//
//  SearchVC.h
//  Ziffi
//
//  Created by Hardik on 13/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface SearchVC : BaseVC <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITextField *currentLocation;
@property (nonatomic, strong) IBOutlet UITextField *searchText;
@property (nonatomic, strong) UITextField *currentTextField;

@property (nonatomic, strong) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) UITableView *autocompleteTableView;
@property (nonatomic, strong) NSMutableArray *recentSearchArray;
@property (nonatomic, strong) NSMutableArray *suggestedArray;
@property (nonatomic, retain) NSMutableArray *autocompleteUrls;
@property (nonatomic) NSUInteger optionSelected;
@property (nonatomic, strong) NSString *currentLocationLat;
@property (nonatomic, strong) NSString *currentLocationLong;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

@end
