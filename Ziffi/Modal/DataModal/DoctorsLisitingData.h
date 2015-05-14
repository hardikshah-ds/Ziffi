//
//  DoctorsLisitingData.h
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorsLisitingData : NSObject

@property (nonatomic, strong) NSString* doctor_id;
@property (nonatomic, strong) NSString* doctor_name;
@property (nonatomic, strong) NSString* doctor_address;
@property (nonatomic, strong) NSString* doctor_image;
@property (nonatomic, strong) NSString* doctor_review_count;
@property (nonatomic, strong) NSString* doctor_rating;
@property (nonatomic, strong) NSString* doctor_fees_min;
@property (nonatomic, strong) NSString* doctor_fees_service;
@property (nonatomic, strong) NSString* doctor_fees_max;
@property (nonatomic, strong) NSString* doctor_fees_max_service;
@property (nonatomic, strong) NSString* doctor_type;
@property (nonatomic, strong) NSString* doctor_lat;
@property (nonatomic, strong) NSString* doctor_long;
@property (nonatomic, strong) NSString* doctor_time;
@property (nonatomic, strong) NSMutableArray* doctor_awards;
@property (nonatomic, strong) NSString* doctor_services;
@property (nonatomic, strong) NSString* doctor_offer_text;
@property (nonatomic, strong) NSString* doctor_offer_description;
@property (nonatomic, strong) NSString* doctor_rank;

@property (nonatomic, strong) NSMutableArray* doctor_degrees;
@property (nonatomic, strong) NSMutableArray* doctor_positions;
@property (nonatomic, strong) NSMutableArray* doctor_exepertise;
@property (nonatomic, strong) NSMutableArray* doctor_equqa;
@property (nonatomic, strong) NSMutableArray* doctor_proqa;
@property (nonatomic, strong) NSMutableArray* doctor_resqa;
@property (nonatomic, strong) NSMutableArray* doctor_language;
@property (nonatomic, strong) NSString* doctor_exeperience;
@property (nonatomic, strong) NSMutableArray* doctor_specialties;
@property (nonatomic, strong) NSMutableArray* doctor_hospitals;
@property (nonatomic, strong) NSMutableArray* doctor_locations;
@property (nonatomic, strong) NSMutableArray* doctor_hospital_names;
@end
