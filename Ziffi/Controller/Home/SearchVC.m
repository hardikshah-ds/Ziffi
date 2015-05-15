//
//  SearchVC.m
//  Ziffi
//
//  Created by Hardik on 13/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "SearchVC.h"
#import "CommonFunctions.h"

@interface SearchVC ()

@end

@implementation SearchVC
@synthesize optionSelected,recentSearchArray,suggestedArray,searchText,autocompleteTableView,autocompleteUrls;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recentSearchArray = [[NSMutableArray alloc]init];
    self.suggestedArray = [[NSMutableArray alloc]init];
    self.autocompleteUrls = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backForNavigationPressed:)
                                                 name:@"BackPressed"
                                               object:nil];
    [super requestAlwaysAuth:^(NSString *currentLocation) {
        if ([currentLocation isEqualToString:@"No"]) {
            self.currentLocation.text = @"Unable to detected";
        }
        else {
            
            self.currentLocation.text = currentLocation;
        }
    }];

}

-(void)viewWillAppear:(BOOL)animated
{

    self.autocompleteTableView.hidden = YES;
    [self.recentSearchArray removeAllObjects];
    [self.suggestedArray removeAllObjects];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (optionSelected == 0) {
        
        NSArray *arr = [userDefaults objectForKey:@"SalonRecent"];
        if ([arr count] != 0) {
            self.recentSearchArray = [NSMutableArray arrayWithArray:arr];
        }
    }
    else if (optionSelected == 1)
    {
        NSArray *arr = [userDefaults objectForKey:@"DoctorsRecent"];
        if ([arr count] != 0) {
            self.recentSearchArray = [NSMutableArray arrayWithArray:arr];
        }
    }
    else {
        
        NSArray *arr = [userDefaults objectForKey:@"DiagnosticsRecent"];
        if ([arr count] != 0) {
            self.recentSearchArray = [NSMutableArray arrayWithArray:arr];
        }
    }
    [self GetTopSuggestion];
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}


-(void)GetTopSuggestion
{
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
        [SearchModuleSerivces SuggestionListing:vertical withCityId:cityID withSearchText:@"" withSessionId:sessionid withCompletionHandler:^(NSDictionary *result) {
            
            [SVProgressHUD dismiss];
            if (result !=  NULL || result != nil) {
                NSMutableArray *temp =[result objectForKey:@"q"];
                if ([temp count] > 0) {
                    for (int i=0; i<[temp count]; i++)
                    {
                        NSDictionary *tempDict = [temp objectAtIndex:i];
                        [self.suggestedArray addObject:[tempDict objectForKey:@"term"]];
                    }
                }
                [self.listTableView reloadData];
            }
            else {
                
                [self.listTableView reloadData];
                [SVProgressHUD dismiss];
            }
        }];
    }
    else {
        [self.listTableView reloadData];
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
    
}

#pragma mark - TextField Delegate Method

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteUrls removeAllObjects];
    if ([CommonFunctions isNetworkReachable]) {
        
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
        
        if (self.currentTextField == self.currentLocation) {
            [SearchModuleSerivces LocationSuggestionListing:vertical withCityId:cityID withSearchText:substring withSessionId:sessionid withCompletionHandler:^(NSDictionary *result) {
                
                if (result !=  NULL || result != nil) {
                    NSMutableArray *temp =[result objectForKey:@"location"];
                    if ([temp count] > 0) {
                        for (int i=0; i<[temp count]; i++)
                        {
                            NSDictionary *tempDict = [temp objectAtIndex:i];
                            [self.autocompleteUrls addObject:[tempDict objectForKey:@"term"]];
                        }
                    }
                    [self.autocompleteTableView reloadData];
                }
                else {
                    
                    [self.autocompleteTableView reloadData];
                    [SVProgressHUD dismiss];
                }
            }];
        }
        else {
            [SearchModuleSerivces SuggestionListing:vertical withCityId:cityID withSearchText:substring withSessionId:sessionid withCompletionHandler:^(NSDictionary *result) {
                
                if (result !=  NULL || result != nil) {
                    NSMutableArray *temp =[result objectForKey:@"q"];
                    if ([temp count] > 0) {
                        for (int i=0; i<[temp count]; i++)
                        {
                            NSDictionary *tempDict = [temp objectAtIndex:i];
                            [self.autocompleteUrls addObject:[tempDict objectForKey:@"term"]];
                        }
                    }
                    [self.autocompleteTableView reloadData];
                }
                else {
                    
                    [self.autocompleteTableView reloadData];
                    [SVProgressHUD dismiss];
                }
            }];
        }
 
    }
    else {
        [self.autocompleteTableView reloadData];
        [CommonFunctions showWarningAlert:ReachabilityWarning title:APP_NAME];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentTextField = textField;
    if (textField == self.currentLocation) {
            autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.currentLocation.frame.origin.x, self.currentLocation.frame.origin.y + 60, self.currentLocation.frame.size.width, 150) style:UITableViewStylePlain];
    }
    else {
        autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.searchText.frame.origin.x, self.searchText.frame.origin.y + 60, self.searchText.frame.size.width, 150) style:UITableViewStylePlain];
    }
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    autocompleteTableView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    autocompleteTableView.layer.borderWidth = 1.0f;
    [self.view addSubview:autocompleteTableView];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    autocompleteTableView.hidden = NO;
    
    //NSLog(@"search text %@",textField.text);
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    
    if ([substring isEqualToString:@""]) {
        self.autocompleteTableView.hidden = YES;
    }
    else {
        [self searchAutocompleteEntriesWithSubstring:substring];
    }

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.autocompleteTableView.hidden = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if ([textField.text length] > 0) {
        [self.recentSearchArray addObject:self.searchText.text];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (optionSelected == 0) {
            [userDefaults setObject:self.recentSearchArray forKey:@"SalonRecent"];
        }
        else if (optionSelected == 1)
        {
            [userDefaults setObject:self.recentSearchArray forKey:@"DoctorsRecent"];
        }
        else {
            [userDefaults setObject:self.recentSearchArray forKey:@"DiagnosticsRecent"];
        }
        [userDefaults synchronize];
        ListingVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListingVC"];
        newView.optionSelected = optionSelected;
        newView.searchText = self.searchText.text;
        newView.locationText = self.currentLocation.text;
        newView.currentLat =  self.currentLocationLat;
        newView.currentLong = self.currentLocationLong;
        [self.navigationController pushViewController:newView animated:YES];
    }

    return YES;
}

#pragma mark - Location Update Method
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    
    self.currentLocationLat = [NSString stringWithFormat:@"%.2f",newLocation.coordinate.latitude];
    self.currentLocationLong = [NSString stringWithFormat:@"%.2f",newLocation.coordinate.longitude];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
//            NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//            NSLog(@"placemark.country %@",placemark.country);
//            NSLog(@"placemark.postalCode %@",placemark.postalCode);
//            NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//            NSLog(@"placemark.locality %@",placemark.locality);
//            NSLog(@"placemark.subLocality %@",placemark.subLocality);
//            NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
            self.currentLocation.text =placemark.locality;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backForNavigationPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableView Delegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.listTableView) {
        return 2;
    }
    else {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    if (tableView == self.listTableView) {
        UIView *headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.listTableView.frame.size.width, 20)];
        headerBgView.backgroundColor = [CommonFunctions colorWithHexString:GreenColor];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200, 22)];
        lbl.backgroundColor = [UIColor clearColor];
        
        if (section == 0) {
            lbl.text = @"Recent Searches";
        }
        else {
            lbl.text = @"Top Suggestions";
        }
        lbl.font = [UIFont fontWithName:FONTREGULAR size:12];
        lbl.textColor = [UIColor whiteColor];
        [headerBgView addSubview:lbl];
        
        if (section == 0 && self.recentSearchArray.count >0) {
            UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
            btnDelete.frame = CGRectMake(headerBgView.frame.size.width - 20, 0, 12, 22);
            [btnDelete setImage:[UIImage imageNamed:@"delete-search"] forState:UIControlStateNormal];
            [btnDelete addTarget:self action:@selector(deleTeRecentSearches:) forControlEvents:UIControlEventTouchUpInside];
            [headerBgView addSubview:btnDelete];
        }
        return headerBgView;
    }
    else {
        return nil;
    }
}

-(void)deleTeRecentSearches:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:APP_NAME message:@"Are you sure you want to delete recent searches ?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"No",@"Yes",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"YES");
        [self.recentSearchArray removeAllObjects];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if (optionSelected == 0) {
            [userDefaults setObject:self.recentSearchArray forKey:@"SalonRecent"];
        }
        else if (optionSelected == 1)
        {
            [userDefaults setObject:self.recentSearchArray forKey:@"DoctorsRecent"];
        }
        else {
            [userDefaults setObject:self.recentSearchArray forKey:@"DiagnosticsRecent"];
        }
        [userDefaults synchronize];
    }
    [self.listTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.listTableView) {
        if (section == 0) {
            return self.recentSearchArray.count;
        }
        else {
            return self.suggestedArray.count;
        }
    }
    else {
        return autocompleteUrls.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    
    if (tableView ==self.listTableView) {
        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.section == 0) {
            cell.textLabel.text = [self.recentSearchArray objectAtIndex:indexPath.row];
        }
        else {
            cell.textLabel.text = [self.suggestedArray objectAtIndex:indexPath.row];
            
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.textLabel.font = [UIFont fontWithName:FONTLIGHT size:12];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    else {
        cell.textLabel.text = [autocompleteUrls objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:FONTLIGHT size:12];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (tableView == self.listTableView) {
        
        ListingVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListingVC"];
        newView.optionSelected = optionSelected;
        newView.locationText = self.currentLocation.text;
        newView.currentLat =  self.currentLocationLat;
        newView.currentLong = self.currentLocationLong;
        if (indexPath.section == 0) {
            newView.searchText = [self.recentSearchArray objectAtIndex:indexPath.row];
        }
        else {
            newView.searchText = [self.suggestedArray objectAtIndex:indexPath.row];
            
        }
        [self.navigationController pushViewController:newView animated:YES];
    }
    else{
        
        if (self.currentTextField == self.currentLocation) {
            UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            self.currentLocation.text = selectedCell.textLabel.text;
            self.autocompleteTableView.hidden = YES;
        }
        else{
            
            ListingVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListingVC"];
            newView.optionSelected = optionSelected;
            newView.locationText = self.currentLocation.text;
            newView.currentLat =  self.currentLocationLat;
            newView.currentLong = self.currentLocationLong;
            UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            newView.searchText = selectedCell.textLabel.text;
            [self.navigationController pushViewController:newView animated:YES];
        }
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

@end
