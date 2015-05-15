//
//  OfferVC.m
//  Ziffi
//
//  Created by Hardik on 08/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "OfferVC.h"
#import "OfferListingCell.h"
#import "Constants.h"

@interface OfferVC ()

@end

@implementation OfferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetDiscounts];
    // Do any additional setup after loading the view.
}

-(void)GetDiscounts
{
    if ([CommonFunctions isNetworkReachable]) {
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
        [SearchModuleSerivces DiscountListing:@"1" withSessionId:sessionid withCompletionHandler:^(NSDictionary *result) {
            if (result != nil) {
                
                [SVProgressHUD dismiss];
                self.pagesArray =[result objectForKey:@"discounts"];
                [self.offerTableView reloadData];
            }
        }];
    }
    else {
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
}


#pragma mark - TextField Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OfferListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"OfferListingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    
    NSDictionary *tempDict = [self.pagesArray objectAtIndex:indexPath.row];
    cell.offerText.text = [tempDict objectForKey:@"title"];
    cell.offerPrice.text = [NSString stringWithFormat:@"%@",[tempDict objectForKey:@"value"]];
    cell.offerCode.text = [tempDict objectForKey:@"code"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
