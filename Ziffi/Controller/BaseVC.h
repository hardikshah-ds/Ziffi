//
//  BaseVC.h
//  Ziffi
//
//  Created by Hardik on 07/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class TPKeyboardAvoidingScrollView;

@interface BaseVC : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property(nonatomic)CLLocationManager *locationManager;
@property(nonatomic,retain) NSString *currentLocality;

-(void)PopNavigationController;
-(void)requestAlwaysAuth:(void (^)(NSString *success))callback;

@end
