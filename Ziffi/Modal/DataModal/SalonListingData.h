//
//  SalonListingData.h
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalonListingData : NSObject

@property (nonatomic, strong) NSString *salon_id;
@property (nonatomic, strong) NSString *salon_name;
@property (nonatomic, strong) NSString *salon_location;
@property (nonatomic, strong) NSString *salon_address;
@property (nonatomic, strong) NSString *salon_image;
@property (nonatomic, strong) NSString *salon_review_count;
@property (nonatomic, strong) NSString *salon_rating;
@property (nonatomic, strong) NSString *salon_fees_min;
@property (nonatomic, strong) NSString *salon_fees_service;
@property (nonatomic, strong) NSString *salon_fees_max;
@property (nonatomic, strong) NSString *salon_fees_max_service;
@property (nonatomic, strong) NSString *salon_type;
@property (nonatomic, strong) NSString *salon_lat;
@property (nonatomic, strong) NSString *salon_long;
@property (nonatomic, strong) NSString *salon_time;
@property (nonatomic, strong) NSMutableArray *salon_awards;
@property (nonatomic, strong) NSString *salon_services;
@property (nonatomic, strong) NSString *salon_offer_text;
@property (nonatomic, strong) NSString *salon_offer_description;
@property (nonatomic, strong) NSString *salon_rank;

@end
