//
//  DoctorsLisitingData.m
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "DoctorsLisitingData.h"

@implementation DoctorsLisitingData

- (id) init
{
    if (self = [super init])
    {
        self.doctor_id = @"";
        self.doctor_name = @"";
        self.doctor_address = @"";
        self.doctor_image = @"";
        self.doctor_review_count = @"";
        self.doctor_rating = @"";
        self.doctor_fees_min = @"";
        self.doctor_fees_service = @"";
        self.doctor_fees_max = @"";
        self.doctor_fees_max_service = @"";
        self.doctor_type = @"";
        self.doctor_lat = 0;
        self.doctor_long = @"";
        self.doctor_time = @"";
        self.doctor_awards = [[NSMutableArray alloc] init];
        self.doctor_services = @"";
        self.doctor_offer_text = @"";
        self.doctor_offer_description = @"";
        self.doctor_rank = @"";

        self.doctor_locations = [[NSMutableArray alloc] init];
        self.doctor_degrees = [[NSMutableArray alloc] init];
        self.doctor_positions = [[NSMutableArray alloc] init];
        self.doctor_exepertise = [[NSMutableArray alloc] init];
        self.doctor_equqa = [[NSMutableArray alloc] init];
        self.doctor_proqa = [[NSMutableArray alloc] init];
        self.doctor_resqa = [[NSMutableArray alloc] init];
        self.doctor_exeperience = @"";
        self.doctor_specialties = [[NSMutableArray alloc] init];
        self.doctor_hospitals = [[NSMutableArray alloc] init];
        self.doctor_hospital_names = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {

        self.doctor_id = [decoder decodeObjectForKey:@"doctor_id"];
        self.doctor_name = [decoder decodeObjectForKey:@"doctor_name"];
        self.doctor_locations = [decoder decodeObjectForKey:@"doctor_location"];
        self.doctor_address = [decoder decodeObjectForKey:@"doctor_address"];
        self.doctor_image = [decoder decodeObjectForKey:@"doctor_image"];
        self.doctor_review_count = [decoder decodeObjectForKey:@"doctor_review_count"];
        self.doctor_rating = [decoder decodeObjectForKey:@"doctor_rating"];
        self.doctor_fees_min = [decoder decodeObjectForKey:@"doctor_fees_min"];
        self.doctor_fees_service = [decoder decodeObjectForKey:@"doctor_fees_service"];
        self.doctor_fees_max = [decoder decodeObjectForKey:@"doctor_fees_max"];
        self.doctor_fees_max_service = [decoder decodeObjectForKey:@"doctor_fees_max_service"];
        self.doctor_type = [decoder decodeObjectForKey:@"doctor_type"];
        self.doctor_lat = [decoder decodeObjectForKey:@"doctor_lat"];
        self.doctor_long = [decoder decodeObjectForKey:@"doctor_long"];
        self.doctor_time = [decoder decodeObjectForKey:@"doctor_time"];
        self.doctor_awards = [decoder decodeObjectForKey:@"doctor_awards"];
        self.doctor_services = [decoder decodeObjectForKey:@"doctor_services"];
        self.doctor_offer_text = [decoder decodeObjectForKey:@"doctor_offer_text"];
        self.doctor_offer_description = [decoder decodeObjectForKey:@"doctor_offer_description"];
        self.doctor_rank = [decoder decodeObjectForKey:@"doctor_rank"];

        self.doctor_locations = [decoder decodeObjectForKey:@"doctor_locations"];
        self.doctor_degrees = [decoder decodeObjectForKey:@"doctor_degrees"];
        self.doctor_positions = [decoder decodeObjectForKey:@"doctor_positions"];
        self.doctor_exepertise = [decoder decodeObjectForKey:@"doctor_exepertise"];
        self.doctor_equqa = [decoder decodeObjectForKey:@"doctor_equqa"];
        self.doctor_proqa = [decoder decodeObjectForKey:@"doctor_proqa"];
        self.doctor_resqa = [decoder decodeObjectForKey:@"doctor_resqa"];
        self.doctor_exeperience = [decoder decodeObjectForKey:@"doctor_exeperience"];
        self.doctor_specialties = [decoder decodeObjectForKey:@"doctor_specialties"];
        self.doctor_hospitals = [decoder decodeObjectForKey:@"doctor_hospitals"];
        self.doctor_hospital_names = [decoder decodeObjectForKey:@"doctor_hospital_names"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    
    [encoder encodeObject:self.doctor_locations forKey:@"doctor_locations"];
    [encoder encodeObject:self.doctor_degrees forKey:@"doctor_degrees"];
    [encoder encodeObject:self.doctor_positions forKey:@"doctor_positions"];
    [encoder encodeObject:self.doctor_exepertise forKey:@"doctor_exepertise"];
    [encoder encodeObject:self.doctor_equqa forKey:@"doctor_equqa"];
    [encoder encodeObject:self.doctor_proqa forKey:@"doctor_proqa"];
    [encoder encodeObject:self.doctor_resqa forKey:@"doctor_resqa"];
    [encoder encodeObject:self.doctor_exeperience forKey:@"doctor_exeperience"];
    [encoder encodeObject:self.doctor_specialties forKey:@"doctor_specialties"];
    [encoder encodeObject:self.doctor_hospitals forKey:@"doctor_hospitals"];
    [encoder encodeObject:self.doctor_hospital_names forKey:@"doctor_hospital_names"];

    [encoder encodeObject:self.doctor_address forKey:@"doctor_address"];
    [encoder encodeObject:self.doctor_awards forKey:@"doctor_awards"];
    [encoder encodeObject:self.doctor_fees_max forKey:@"doctor_fees_max"];
    [encoder encodeObject:self.doctor_fees_max_service forKey:@"doctor_fees_max_service"];
    [encoder encodeObject:self.doctor_fees_min forKey:@"doctor_fees_min"];
    [encoder encodeObject:self.doctor_fees_service forKey:@"doctor_fees_service"];
    [encoder encodeObject:self.doctor_id forKey:@"doctor_id"];
    [encoder encodeObject:self.doctor_image forKey:@"doctor_image"];
    [encoder encodeObject:self.doctor_lat forKey:@"doctor_lat"];
    [encoder encodeObject:self.doctor_locations forKey:@"doctor_location"];
    [encoder encodeObject:self.doctor_long forKey:@"doctor_long"];
    [encoder encodeObject:self.doctor_name forKey:@"doctor_name"];
    [encoder encodeObject:self.doctor_offer_description forKey:@"doctor_offer_description"];
    [encoder encodeObject:self.doctor_offer_text forKey:@"doctor_offer_text"];
    [encoder encodeObject:self.doctor_rank forKey:@"doctor_rank"];
    [encoder encodeObject:self.doctor_rating forKey:@"doctor_rating"];
    [encoder encodeObject:self.doctor_review_count forKey:@"doctor_review_count"];
    [encoder encodeObject:self.doctor_services forKey:@"doctor_services"];
    [encoder encodeObject:self.doctor_time forKey:@"doctor_time"];
    [encoder encodeObject:self.doctor_type forKey:@"doctor_type"];
    
}


@end
