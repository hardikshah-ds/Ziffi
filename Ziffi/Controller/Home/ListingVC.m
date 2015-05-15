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
@property (nonatomic, strong) NSString *vertical;
@property (nonatomic) NSUInteger cityID;
@end

@implementation ListingVC
@synthesize optionSelected,searchText,locationText,currentLat,currentLong;
@synthesize verticalListingServices=_verticalListingServices;
@synthesize footerLabel=_footerLabel;
@synthesize activityIndicator=_activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listingTable.backgroundColor = [UIColor clearColor];
    self.searchTextField.text = searchText;
    [self setupTableViewFooter];
    [self GetListing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetListing {
    
    if ([CommonFunctions isNetworkReachable]) {
        
        self.cityID=Mumbai;
        self.vertical = @"salons-spas";
        if (optionSelected == 0) {
            self.vertical = @"salons-spas";
        }
        else if (optionSelected == 1) {
            self.vertical = @"doctors";
        }
        else {
            self.vertical = @"diagnostic-centers";
        }
        NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
        NSString *strCoordinates = [NSString stringWithFormat:@"%@,%@",currentLat,currentLong];
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:self.vertical,@"vertical",@"4",@"cityid",searchText,@"q",
                              sessionid,@"sessionid",
                              locationText,@"location",
                              strCoordinates,@"coordinates",
                              nil];
        self.verticalListingServices = [[VerticalListingServices alloc] initWithPageSize:10 delegate:self];
        [self.verticalListingServices fetchFirstPage:dict];
    }
    else
    {
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
    
    return [self.verticalListingServices.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (optionSelected == 0) {
        SalonListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"SalonListingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }
        
        SalonListingData *object = [self.verticalListingServices.results objectAtIndex:indexPath.row];
        cell.salonName.text = object.salon_name;
        cell.salonType.text = object.salon_type;
        cell.salonAddress.text = object.salon_address;
        cell.salonPrice.attributedText = [self SetAttributedTextForSalonPrice:[NSString stringWithFormat:@"%@",object.salon_fees_min] forText2:[NSString stringWithFormat:@" for %@",object.salon_fees_service] forType:@"SalonPrice"];
        
        float salonlat = [object.salon_lat floatValue];
        float salonglong = [object.salon_long floatValue];
        CLLocation *currentLoc = [super locationManager].location;
        CLLocation *salonLoc = [[CLLocation alloc] initWithLatitude:salonlat longitude:salonglong];
        CLLocationDistance kmeters = [salonLoc distanceFromLocation:currentLoc]/1000;
        cell.salonDistance.attributedText = [self SetAttributedTextForSalonPrice:[NSString stringWithFormat:@"%.2f",kmeters] forText2:@" kms" forType:@"SalonDistance"];
        
        if ([object.salon_offer_text length] > 2) {
            
            cell.salonOffer.hidden = NO;
            cell.offerView.hidden = NO;
            NSArray *arrTemp = [object.salon_offer_text componentsSeparatedByString:@"#"];
            cell.salonOffer.text = [NSString stringWithFormat:@"%@ %@",[arrTemp objectAtIndex:0],[arrTemp objectAtIndex:1]];
        }
        else {
            cell.salonOffer.hidden = YES;
            cell.offerView.hidden = YES;
        }
        
        cell.salonRating.value = [object.salon_rating floatValue];
        [cell.salonImage setImageWithURL:[NSURL URLWithString:object.salon_image] placeholderImage:[UIImage imageNamed:@"default-bg"]];
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

        DoctorsLisitingData *object = [self.verticalListingServices.results objectAtIndex:indexPath.row];
        cell.doctorName.text = object.doctor_name;
        NSMutableArray *tempDegree = object.doctor_degrees;
        NSString *tempStr =[NSString new];
        for (int i =0; i<[tempDegree count]; i++) {
            tempStr = [[tempStr stringByAppendingString:[tempDegree objectAtIndex:i]]stringByAppendingFormat:@","];
        }
        NSString *doctorDegrees = [tempStr substringToIndex:[tempStr length]-1];
        cell.doctorDegree.text = doctorDegrees;
        
        cell.doctorExp.text = [NSString stringWithFormat:@"Exeperience: %@ years",object.doctor_exeperience];
        
        cell.doctorFees.text = [NSString stringWithFormat:@"FEES \u20B9 %@",object.doctor_fees_min];
        cell.doctorReviews.text = [NSString stringWithFormat:@"%@ Reviews",object.doctor_review_count];
        cell.doctorSpeciality.text = object.doctor_type;
        cell.doctorsRating.value = [object.doctor_rating floatValue];
        
        NSMutableArray *tempHospitals = object.doctor_hospital_names;
        if ([tempHospitals count] > 0) {
            cell.doctorHospitals.text = [NSString stringWithFormat:@"%@",[tempHospitals objectAtIndex:0]];
        }
        else {
            cell.doctorHospitals.text = @"No hospitals";
        }
        
        cell.doctorWorkingAt.text = object.doctor_time;
        
        [cell.doctorImage setImageWithURL:[NSURL URLWithString:object.doctor_image] placeholderImage:[UIImage imageNamed:@"default-bg"]];
        
        float doctorlat = [object.doctor_lat floatValue];
        float doctorlong = [object.doctor_long floatValue];
        CLLocation *currentLoc = [super locationManager].location;
        CLLocation *doctorLoc = [[CLLocation alloc] initWithLatitude:doctorlat longitude:doctorlong];
        CLLocationDistance kmeters = [doctorLoc distanceFromLocation:currentLoc]/1000;
        cell.doctorDistance.attributedText = [self SetAttributedTextForSalonPrice:[NSString stringWithFormat:@"%.2f",kmeters] forText2:@" kms" forType:@"SalonDistance"];
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
        
        DiagnosticsListingData *object = [self.verticalListingServices.results objectAtIndex:indexPath.row];
        cell.diagnosticsName.text = object.diagnostics_name;
        cell.diagnosticsAddress.text = object.diagnostics_address;
        cell.diagnosticsTime.text = object.diagnostics_package;
        float diagnosticslat = [object.diagnostics_lat floatValue];
        float diagnosticslong = [object.diagnostics_long floatValue];
        CLLocation *currentLoc = [super locationManager].location;
        CLLocation *diagnosticsLoc = [[CLLocation alloc] initWithLatitude:diagnosticslat longitude:diagnosticslong];
        CLLocationDistance kmeters = [diagnosticsLoc distanceFromLocation:currentLoc]/1000;
        cell.diagnosticsDistance.attributedText = [self SetAttributedTextForSalonPrice:[NSString stringWithFormat:@"%.2f",kmeters] forText2:@" kms" forType:@"SalonDistance"];
        cell.diagnosticsRating.value = [object.diagnostics_rating floatValue];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SalonDetailsVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"SalonDetailsVC"];
//    [self.navigationController pushViewController:newView animated:YES];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // when reaching bottom, load a new page
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        // ask next page only if we haven't reached last page
        if(![self.verticalListingServices reachedLastPage])
        {
            // fetch next page of results
            NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
            NSString *strCoordinates = [NSString stringWithFormat:@"%@,%@",currentLat,currentLong];
            NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:self.vertical,@"vertical",@"4",@"cityid",searchText,@"q",
                                  sessionid,@"sessionid",
                                  locationText,@"location",
                                  strCoordinates,@"coordinates",
                                  nil];
            [self.verticalListingServices fetchNextPage:dict];
        }
    }
}


- (void)fetchNextPage:(NSDictionary *)dict
{
//    NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
//    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:self.vertical,@"vertical",@"4",@"cityid",searchText,@"q",sessionid,@"sessionid",nil];
    [self.verticalListingServices fetchNextPage:dict];
    [self.activityIndicator startAnimating];
}

- (void)setupTableViewFooter
{
    // set up label
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.listingTable.frame.size.width, 44)];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.listingTable.frame.size.width, 44)];
    label.font = [UIFont fontWithName:FONTMEDIUM size:14];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    self.footerLabel = label;
    [footerView addSubview:label];
    
    // set up activity indicator
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = CGPointMake(40, 22);
    activityIndicatorView.hidesWhenStopped = YES;
    
    self.activityIndicator = activityIndicatorView;
    [footerView addSubview:activityIndicatorView];
    
    self.listingTable.tableFooterView = footerView;
}

- (void)updateTableViewFooter
{
    if ([self.verticalListingServices.results count] != 0)
    {
        self.footerLabel.text = [NSString stringWithFormat:@"%lu results out of %ld", (unsigned long)[self.verticalListingServices.results count], (long)self.verticalListingServices.total];
    } else
    {
        self.footerLabel.text = @"";
    }
    
    [self.footerLabel setNeedsDisplay];
}

#pragma mark - Paginator delegate methods

- (void)Pagination:(id)Pagination didReceiveResults:(NSArray *)results
{
    // update tableview footer
    [self updateTableViewFooter];
    [self.activityIndicator stopAnimating];
    
    // update tableview content
    // easy way : call [tableView reloadData];
    // nicer way : use insertRowsAtIndexPaths:withAnimation:
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger i = [self.verticalListingServices.results count] - [results count];
    
    for(NSDictionary *result in results)
    {
        NSLog(@"%@",result);
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        i++;
    }
    
    [self.listingTable beginUpdates];
    [self.listingTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.listingTable endUpdates];
}

- (void)PaginationDidReset:(id)paginator
{
    [self.listingTable reloadData];
    [self updateTableViewFooter];
}

- (void)PaginationDidFailToRespond:(id)paginator
{
    // Todo
}


-(NSMutableAttributedString *)SetAttributedTextForSalonPrice:(NSString *)text1 forText2:(NSString *)text2 forType:(NSString *)forDisorPrice
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    UIColor *color1 = [CommonFunctions colorWithHexString:GreenColor];
    UIColor *color2 = [UIColor redColor];
    UIFont *font1 = [UIFont fontWithName:@"Roboto-Regular" size:14];
    UIFont *font2 = [UIFont fontWithName:@"Roboto-Light" size:12];
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font1,
                            color1:NSForegroundColorAttributeName,
                            NSParagraphStyleAttributeName:style}; // Added line
    NSDictionary *dict2 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font2,
                            color2:NSForegroundColorAttributeName,
                            NSParagraphStyleAttributeName:style}; // Added line
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    if ([forDisorPrice isEqualToString:@"SalonPrice"]) {
        [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\u20B9 "   attributes:nil]];
    }
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:text1   attributes:dict1]];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:text2      attributes:dict2]];
    if ([forDisorPrice isEqualToString:@"SalonPrice"]) {
        [attString addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(1, [text1 length]+1)];
    }
    else {
        [attString addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, [text1 length])];
    }
    
    return attString;
}


@end
