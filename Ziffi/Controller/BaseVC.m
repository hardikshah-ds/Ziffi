//
//  BaseVC.m
//  Ziffi
//
//  Created by Hardik on 07/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "BaseVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CommonFunctions.h"

@interface BaseVC ()

@end

@implementation BaseVC
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager =[[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [_locationManager requestWhenInUseAuthorization];
    }else{
        [_locationManager startUpdatingLocation];
    }
    [_locationManager startUpdatingLocation];
    self.view.backgroundColor = [CommonFunctions colorWithHexString:BackGroundColor];
    [self.scrollView contentSizeToFit];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //NSLog(@"%d AUTH STATUS",status);
    if (status==3 || status ==4) {
        [self.locationManager startUpdatingLocation];
    }
}

-(void)requestAlwaysAuth:(void (^)(NSString *success))callback{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied) {
        
        NSString*title;
        
        title=(status == kCLAuthorizationStatusDenied) ? @"Go to settings" : @"Background use is not enabled";
        
        
        NSString *message = @"Location Services Are Off ! Please enable and allow us to find the nearest place with the your current location";
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Settings", nil];
        
        [alert show];
        callback(@"No");
        
    }else if (status==kCLAuthorizationStatusNotDetermined) {
    
        [_locationManager requestWhenInUseAuthorization];
        callback(@"No");
    }
    else if (status==kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        
        if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [_locationManager requestWhenInUseAuthorization];
        }else{
            [self.locationManager startUpdatingLocation];
        }
        callback(self.currentLocality);
    }
    
}

//#pragma mark - Location Update Method
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    [self.locationManager stopUpdatingLocation];
//    
//    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
//    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        for (CLPlacemark * placemark in placemarks) {
//            //            NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//            //            NSLog(@"placemark.country %@",placemark.country);
//            //            NSLog(@"placemark.postalCode %@",placemark.postalCode);
//            //            NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//            //            NSLog(@"placemark.locality %@",placemark.locality);
//            //            NSLog(@"placemark.subLocality %@",placemark.subLocality);
//                        NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
//            //self.currentLocation.text =placemark.locality;
//        }
//    }];
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        [[UIApplication sharedApplication]openURL:settingsURL];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)PopNavigationController {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
