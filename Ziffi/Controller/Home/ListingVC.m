//
//  ListingVC.m
//  Ziffi
//
//  Created by Hardik on 08/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "ListingVC.h"
#import "Constants.h"

@interface ListingVC ()
@end

@implementation ListingVC
@synthesize optionSelected,searchText;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listingTable.backgroundColor = [UIColor clearColor];
    self.searchTextField.text = searchText;
    [self GetListing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetListing {
    
    if ([CommonFunctions isNetworkReachable]) {
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        NSUInteger cityID=Mumbai;
        NSString *vertical = @"salons-spas";
        if (optionSelected == 0) {
            vertical = @"salons-spas";
        }
        else if (optionSelected == 1) {
            vertical = @"doctors";
        }
        else {
            vertical = @"diagnostic-centers";
        }
        NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
        [WebServices SearchListing:vertical withCityId:cityID withSearchText:searchText withPageNo:@"1" withSessionId:sessionid withCompletionHandler:^(NSDictionary *result) {
            if (result != NULL || result != nil) {
                
                [SVProgressHUD dismiss];
                NSLog(@"%@",result);
            }
        }];
        
    }
    else {
        
        [SVProgressHUD dismiss];
        [self.listingTable reloadData];
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }

}

- (void)backForNavigationPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (optionSelected == 0) {
        [userDefaults setObject:self.searchTextField.text forKey:@"SalonRecent"];
    }
    else if (optionSelected == 1)
    {
        [userDefaults setObject:self.searchTextField.text forKey:@"DoctorsRecent"];
    }
    else {
        [userDefaults setObject:self.searchTextField.text forKey:@"DiagnosticsRecent"];
    }
    [userDefaults synchronize];
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (optionSelected == 0) {
        SalonListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"SalonListingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (optionSelected == 1)
    {
        DoctorListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DoctorListingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        DiagnosticsListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"DiagnosticsListingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (optionSelected == 0) {
        return 207;
    }
    else if (optionSelected == 1)
    {
        return 165;
    }
    else {
        return 116;
    }
}

@end
