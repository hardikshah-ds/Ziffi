//
//  HomeVC.m
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end
//12,34,56
@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pagesArray = [[NSMutableArray alloc]init];
    self.pageScroll.delegate =self;
    [self startAnimation];
    [CommonFunctions ApplyShadow:self.offerView];
    UserData *object = [CommonFunctions retriveCompleteUserData];
    self.myBalance.text = [NSString stringWithFormat:@"\u20B9 %@", object.user_total_balance];;
    [self GetDiscounts];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetDiscounts
{
    if ([CommonFunctions isNetworkReachable]) {
        NSString *sessionid = [[NSUserDefaults standardUserDefaults]valueForKey:@"SessionId"];
        [SearchModuleSerivces DiscountListing:@"1" withSessionId:sessionid withCompletionHandler:^(NSDictionary *result) {
            if (result != nil) {
                self.pagesArray =[result objectForKey:@"discounts"];
                [self CreateDynamicScrollContent];
            }
        }];
    }
}


-(void)CreateDynamicScrollContent
{
    self.textPageControl.numberOfPages = [self.pagesArray count];
    int x=0;
    for (int i=0; i<[self.pagesArray count]; i++) {
        UITextView *contectText = [[UITextView alloc]init];
        contectText.frame = CGRectMake(x, 0, 295, 111);
        NSDictionary *tempDict = [self.pagesArray objectAtIndex:i];
        contectText.text = [tempDict objectForKey:@"title"];
        contectText.font = [UIFont fontWithName:FONTMEDIUM size:14];
        contectText.backgroundColor = [UIColor clearColor];
        [self.pageScroll addSubview:contectText];
        x+=295;
    }
    self.pageScroll.pagingEnabled = YES;
    self.pageScroll.contentSize = CGSizeMake(295*[self.pagesArray count], 111);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.textPageControl.currentPage=page;
}

#pragma mark - View Animation
-(void)startAnimation
{
    self.salonView.hidden = YES;
    self.doctorView.hidden = YES;
    self.disgnosticsView.hidden = YES;
    self.offerView.hidden = YES;

    [self performSelector:@selector(OfferViewAnimation) withObject:nil afterDelay:0];
    [self performSelector:@selector(SalonViewAnimation) withObject:nil afterDelay:0];
    [self performSelector:@selector(DoctorViewAnimation) withObject:self afterDelay:0.3 ];
    [self performSelector:@selector(DiagnosticsViewAnimation) withObject:self afterDelay:0.6];
}


-(void)SalonViewAnimation {
    
    self.salonView.hidden= NO;
    [CommonFunctions viewSlideInFromTopToBottom:self.salonView];
}

-(void)DoctorViewAnimation {
    
    self.doctorView.hidden = NO;
    [CommonFunctions viewSlideInFromTopToBottom:self.doctorView];
}

-(void)DiagnosticsViewAnimation {
    
    self.disgnosticsView.hidden = NO;
    [CommonFunctions viewSlideInFromTopToBottom:self.disgnosticsView];
}

-(void)OfferViewAnimation {
    
    self.offerView.hidden = NO;
    [CommonFunctions viewSlideInFromBottomToTop:self.offerView];
}


#pragma mark - UIButton Selection
-(IBAction)OptionPressed:(id)sender
{
    if ([sender tag] == 0) {
        
        [CommonFunctions performAnimationOnView:self.salonBtn duration:0.25 delay:0 withCompletionHandler:^(NSInteger success) {
            if (success) {
                SearchVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
                newView.optionSelected = 0;
                [self.navigationController pushViewController:newView animated:YES];
            }
        }];
        [CommonFunctions performAnimationOnViewWithoutHandler:self.salonText duration:0.25 delay:0];
    }
    else if ([sender tag] == 1)
    {

        [CommonFunctions performAnimationOnView:self.doctorBtn duration:0.25 delay:0 withCompletionHandler:^(NSInteger success) {
            if (success) {
                SearchVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
                newView.optionSelected = 1;
                [self.navigationController pushViewController:newView animated:YES];
            }
        }];
        [CommonFunctions performAnimationOnViewWithoutHandler:self.doctorText duration:0.25 delay:0];
    }
    else {

        [CommonFunctions performAnimationOnView:self.disgnosticsBtn duration:0.25 delay:0 withCompletionHandler:^(NSInteger success) {
            if (success) {
                SearchVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
                newView.optionSelected = 2;
                [self.navigationController pushViewController:newView animated:YES];
            }
        }];
        [CommonFunctions performAnimationOnViewWithoutHandler:self.disgnosticsText duration:0.25 delay:0];
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
