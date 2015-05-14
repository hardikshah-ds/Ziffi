//
//  DiagnosticsListingData.h
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiagnosticsListingData : NSObject

@property (nonatomic, strong) NSString *diagnostics_id;
@property (nonatomic, strong) NSString *diagnostics_name;
@property (nonatomic, strong) NSString *diagnostics_location;
@property (nonatomic, strong) NSString *diagnostics_address;
@property (nonatomic, strong) NSString *diagnostics_image;
@property (nonatomic, strong) NSString *diagnostics_review_count;
@property (nonatomic, strong) NSString *diagnostics_rating;
@property (nonatomic, strong) NSString *diagnostics_fees_min;
@property (nonatomic, strong) NSString *diagnostics_fees_service;
@property (nonatomic, strong) NSString *diagnostics_fees_max;
@property (nonatomic, strong) NSString *diagnostics_fees_max_service;
@property (nonatomic, strong) NSString *diagnostics_type;
@property (nonatomic, strong) NSString *diagnostics_lat;
@property (nonatomic, strong) NSString *diagnostics_long;
@property (nonatomic, strong) NSString *diagnostics_time;
@property (nonatomic, strong) NSString *diagnostics_services;
@property (nonatomic, strong) NSString *diagnostics_offer_text;
@property (nonatomic, strong) NSString *diagnostics_offer_description;
@property (nonatomic, strong) NSString *diagnostics_rank;
@property (nonatomic, strong) NSMutableArray *diagnostics_package_names;
@property (nonatomic, strong) NSString *diagnostics_package;
@end
