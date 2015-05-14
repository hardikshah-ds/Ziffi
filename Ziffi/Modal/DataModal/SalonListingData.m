//
//  SalonListingData.m
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "SalonListingData.h"

@implementation SalonListingData

- (id) init
{
    if (self = [super init])
    {
        self.salon_id = @"";
        self.salon_name = @"";
        self.salon_location = @"";
        self.salon_address = @"";
        self.salon_image = @"";
        self.salon_review_count = @"";
        self.salon_rating = @"";
        self.salon_fees_min = @"";
        self.salon_fees_service = @"";
        self.salon_fees_max = @"";
        self.salon_fees_max_service = @"";
        self.salon_type = @"";
        self.salon_lat = 0;
        self.salon_long = @"";
        self.salon_time = @"";
        self.salon_awards = [[NSMutableArray alloc] init];
        self.salon_services = @"";
        self.salon_offer_text = @"";
        self.salon_offer_description = @"";
        self.salon_rank = @"";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {

        self.salon_id = [decoder decodeObjectForKey:@"salon_id"];
        self.salon_name = [decoder decodeObjectForKey:@"salon_name"];
        self.salon_location = [decoder decodeObjectForKey:@"salon_location"];
        self.salon_address = [decoder decodeObjectForKey:@"salon_address"];
        self.salon_image = [decoder decodeObjectForKey:@"salon_image"];
        self.salon_review_count = [decoder decodeObjectForKey:@"salon_review_count"];
        self.salon_rating = [decoder decodeObjectForKey:@"salon_rating"];
        self.salon_fees_min = [decoder decodeObjectForKey:@"salon_fees_min"];
        self.salon_fees_service = [decoder decodeObjectForKey:@"salon_fees_service"];
        self.salon_fees_max = [decoder decodeObjectForKey:@"salon_fees_max"];
        self.salon_fees_max_service = [decoder decodeObjectForKey:@"salon_fees_max_service"];
        self.salon_type = [decoder decodeObjectForKey:@"salon_type"];
        self.salon_lat = [decoder decodeObjectForKey:@"salon_lat"];
        self.salon_long = [decoder decodeObjectForKey:@"salon_long"];
        self.salon_time = [decoder decodeObjectForKey:@"salon_time"];
        self.salon_awards = [decoder decodeObjectForKey:@"salon_awards"];
        self.salon_services = [decoder decodeObjectForKey:@"salon_services"];
        self.salon_offer_text = [decoder decodeObjectForKey:@"salon_offer_text"];
        self.salon_offer_description = [decoder decodeObjectForKey:@"salon_offer_description"];
        self.salon_rank = [decoder decodeObjectForKey:@"salon_rank"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.salon_address forKey:@"salon_address"];
    [encoder encodeObject:self.salon_awards forKey:@"salon_awards"];
    [encoder encodeObject:self.salon_fees_max forKey:@"salon_fees_max"];
    [encoder encodeObject:self.salon_fees_max_service forKey:@"salon_fees_max_service"];
    [encoder encodeObject:self.salon_fees_min forKey:@"salon_fees_min"];
    [encoder encodeObject:self.salon_fees_service forKey:@"salon_fees_service"];
    [encoder encodeObject:self.salon_id forKey:@"salon_id"];
    [encoder encodeObject:self.salon_image forKey:@"salon_image"];
    [encoder encodeObject:self.salon_lat forKey:@"salon_lat"];
    [encoder encodeObject:self.salon_location forKey:@"salon_location"];
    [encoder encodeObject:self.salon_long forKey:@"salon_long"];
    [encoder encodeObject:self.salon_name forKey:@"salon_name"];
    [encoder encodeObject:self.salon_offer_description forKey:@"salon_offer_description"];
    [encoder encodeObject:self.salon_offer_text forKey:@"salon_offer_text"];
    [encoder encodeObject:self.salon_rank forKey:@"salon_rank"];
    [encoder encodeObject:self.salon_rating forKey:@"salon_rating"];
    [encoder encodeObject:self.salon_review_count forKey:@"salon_review_count"];
    [encoder encodeObject:self.salon_services forKey:@"salon_services"];
    [encoder encodeObject:self.salon_time forKey:@"salon_time"];
    [encoder encodeObject:self.salon_type forKey:@"salon_type"];

}


@end
