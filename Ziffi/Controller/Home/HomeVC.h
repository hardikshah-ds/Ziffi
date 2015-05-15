//
//  HomeVC.h
//  Ziffi
//
//  Created by Hardik on 06/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "BaseVC.h"

@interface HomeVC : BaseVC <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *salonBtn;
@property (nonatomic, strong) IBOutlet UIButton *doctorBtn;
@property (nonatomic, strong) IBOutlet UIButton *disgnosticsBtn;
@property (nonatomic, strong) IBOutlet UILabel *salonText;
@property (nonatomic, strong) IBOutlet UILabel *doctorText;
@property (nonatomic, strong) IBOutlet UILabel *disgnosticsText;
@property (nonatomic, strong) IBOutlet UIImageView *salonBackground;
@property (nonatomic, strong) IBOutlet UIImageView *doctorBackground;
@property (nonatomic, strong) IBOutlet UIImageView *disgnosticsBackground;
@property (nonatomic, strong) IBOutlet UIView *salonView;
@property (nonatomic, strong) IBOutlet UIView *doctorView;
@property (nonatomic, strong) IBOutlet UIView *disgnosticsView;
@property (nonatomic, strong) IBOutlet UIView *offerView;

@property (strong, nonatomic) NSMutableArray *pagesArray;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *textPageControl;

@property (weak, nonatomic) IBOutlet UILabel *myBalance;
@property (weak, nonatomic) IBOutlet UILabel *myLocation;

@end
