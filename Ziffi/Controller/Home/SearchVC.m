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
@synthesize optionSelected,recentSearchArray,suggestedArray,searchText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recentSearchArray = [[NSMutableArray alloc]init];
    self.suggestedArray = [[NSMutableArray alloc]init];
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

    [self.recentSearchArray removeAllObjects];
    [self.suggestedArray removeAllObjects];
    
    [self.searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
        [WebServices SuggestionListing:vertical withCityId:cityID withSearchText:@"" withSessionId:sessionid withCompletionHandler:^(NSDictionary *result) {
            
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

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
}

#pragma mark - Location Update Method
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    
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

#pragma mark - TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
    [self.navigationController pushViewController:newView animated:YES];
    return YES;
}


- (void)backForNavigationPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableView Delegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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

    if (section == 0) {
        return self.recentSearchArray.count;
    }
    else {
        return self.suggestedArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.recentSearchArray objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [self.suggestedArray objectAtIndex:indexPath.row];
        
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.textLabel.font = [UIFont fontWithName:FONTLIGHT size:12];
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListingVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListingVC"];
    newView.optionSelected = optionSelected;
    if (indexPath.section == 0) {
        newView.searchText = [self.recentSearchArray objectAtIndex:indexPath.row];
    }
    else {
        newView.searchText = [self.suggestedArray objectAtIndex:indexPath.row];
        
    }
    [self.navigationController pushViewController:newView animated:YES];
}

@end
