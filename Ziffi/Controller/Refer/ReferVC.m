//
//  ReferVC.m
//  Ziffi
//
//  Created by Hardik on 08/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "ReferVC.h"
#import "Constants.h"

@interface ReferVC ()

@end

@implementation ReferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UserData *object = [CommonFunctions retriveCompleteUserData];
    self.friendsGet.text = [NSString stringWithFormat:@"Friends get \u20B9 %@",object.user_referral_amount];
    self.youGet.text = [NSString stringWithFormat:@"Friends signs up, you get \u20B9 %@",object.user_referral_amount];
    self.shareCode.text = [NSString stringWithFormat:@"Share your refferal code: %@",object.user_referral_code];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ViewEarning:(id)sender
{
    
}

-(IBAction)ShareitPressed:(id)sender
{
    UserData *object = [CommonFunctions retriveCompleteUserData];
    NSString *textToShare = [NSString stringWithFormat:@"Loving the Ziffi app right now, you should totally try it. Use my refferal code %@ and enjoy your first service free. Get the app here: bit.ly/Ziffi",object.user_referral_code];
    //UIImage *imageToShare = [UIImage imageNamed:@"AppIcon"];
    NSArray *itemsToShare = @[textToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //or whichever you don't need
    [self presentViewController:activityVC animated:YES completion:nil];
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
