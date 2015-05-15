//
//  MoreVC.m
//  Ziffi
//
//  Created by Hardik on 11/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "MoreVC.h"
#import "Constants.h"

@interface MoreVC ()

@end

@implementation MoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitialLoadView];

    // Do any additional setup after loading the view.
}

-(void)InitialLoadView
{
    self.listArray = [[NSMutableArray alloc]init];
//    [self.listArray addObject:@"Profile"];
//    [self.listArray addObject:@"Settings"];
    [self.listArray addObject:@"Rate in AppStore"];
    [self.listArray addObject:@"Share App With Friends"];
    [self.listArray addObject:@"Contact Us"];
    [self.listArray addObject:@"About"];
    [self.listArray addObject:@"Logout"];
    self.aboutUsText.text = @"Ziffi helps you look, feel and be your best self. \n\nWhether you want some grooming services, feel the need for some spa style pampering, or need wellness services. Ziffi is your No.1 bet. \n\nIntuitively designed for discovery, ease of booking, and ranked by 100% genuine verified user ratings, Ziffi packs quite a powerful punch in one neat little package.";
    self.aboutUsText.font = [UIFont fontWithName:FONTREGULAR size:16];
    self.aboutUsView.hidden = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ClosePressed:(id)sender
{
    self.aboutUsView.hidden = YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    cell.textLabel.text = [self.listArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:FONTREGULAR size:18];
    cell.textLabel.textColor = [CommonFunctions colorWithHexString:TabBarColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"rate-icon"];
    }
    else if (indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"share-icon"];
    }
    else if (indexPath.row == 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"contact-icon"];
    }
    else if (indexPath.row == 3)
    {
        cell.imageView.image = [UIImage imageNamed:@"about-icon"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"logout-icon"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //Open app store
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNESURL]];
    }
    else if (indexPath.row == 1)
    {
        //Share app with friends
        UserData *object = [CommonFunctions retriveCompleteUserData];
        NSString *textToShare = [NSString stringWithFormat:@"Register on ziffi.com and get \u20B9 %@ on in your wallet. Use referral code %@",object.user_referral_amount,object.user_referral_code];
        //UIImage *imageToShare = [UIImage imageNamed:@"AppIcon"];
        NSArray *itemsToShare = @[textToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //or whichever you don't need
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else if (indexPath.row == 2)
    {
        NSString *phNo = PHONENO;
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            [CommonFunctions showWarningAlert:@"Call facility is not available!!!" title:APP_NAME];
        }
    }
    else if (indexPath.row == 3)
    {
        //About Us
        self.aboutUsView.hidden = NO;
    }
    else
    {
        //Logout
        AppDelegate  *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appD LoadStoryBoardWithLoginModule];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
