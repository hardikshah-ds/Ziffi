//
//  DiagnosticsListingData.m
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "DiagnosticsListingData.h"

@implementation DiagnosticsListingData

- (id) init
{
    if (self = [super init])
    {
        self.diagnostics_id = @"";
        self.diagnostics_name = @"";
        self.diagnostics_location = @"";
        self.diagnostics_address = @"";
        self.diagnostics_image = @"";
        self.diagnostics_review_count = @"";
        self.diagnostics_rating = @"";
        self.diagnostics_fees_min = @"";
        self.diagnostics_fees_service = @"";
        self.diagnostics_fees_max = @"";
        self.diagnostics_fees_max_service = @"";
        self.diagnostics_type = @"";
        self.diagnostics_lat = 0;
        self.diagnostics_long = @"";
        self.diagnostics_time = @"";
        self.diagnostics_package_names = [[NSMutableArray alloc] init];
        self.diagnostics_services = @"";
        self.diagnostics_offer_text = @"";
        self.diagnostics_offer_description = @"";
        self.diagnostics_rank = @"";
        self.diagnostics_package =@"";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        
        self.diagnostics_id = [decoder decodeObjectForKey:@"diagnostics_id"];
        self.diagnostics_name = [decoder decodeObjectForKey:@"diagnostics_name"];
        self.diagnostics_location = [decoder decodeObjectForKey:@"diagnostics_location"];
        self.diagnostics_address = [decoder decodeObjectForKey:@"diagnostics_address"];
        self.diagnostics_image = [decoder decodeObjectForKey:@"diagnostics_image"];
        self.diagnostics_review_count = [decoder decodeObjectForKey:@"diagnostics_review_count"];
        self.diagnostics_rating = [decoder decodeObjectForKey:@"diagnostics_rating"];
        self.diagnostics_fees_min = [decoder decodeObjectForKey:@"diagnostics_fees_min"];
        self.diagnostics_fees_service = [decoder decodeObjectForKey:@"diagnostics_fees_service"];
        self.diagnostics_fees_max = [decoder decodeObjectForKey:@"diagnostics_fees_max"];
        self.diagnostics_fees_max_service = [decoder decodeObjectForKey:@"diagnostics_fees_max_service"];
        self.diagnostics_type = [decoder decodeObjectForKey:@"diagnostics_type"];
        self.diagnostics_lat = [decoder decodeObjectForKey:@"diagnostics_lat"];
        self.diagnostics_long = [decoder decodeObjectForKey:@"diagnostics_long"];
        self.diagnostics_time = [decoder decodeObjectForKey:@"diagnostics_time"];
        self.diagnostics_package_names = [decoder decodeObjectForKey:@"diagnostics_package_names"];
        self.diagnostics_services = [decoder decodeObjectForKey:@"diagnostics_services"];
        self.diagnostics_offer_text = [decoder decodeObjectForKey:@"diagnostics_offer_text"];
        self.diagnostics_offer_description = [decoder decodeObjectForKey:@"diagnostics_offer_description"];
        self.diagnostics_rank = [decoder decodeObjectForKey:@"diagnostics_rank"];
        self.diagnostics_package = [decoder decodeObjectForKey:@"diagnostics_package"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    
    
    [encoder encodeObject:self.diagnostics_address forKey:@"diagnostics_address"];
    [encoder encodeObject:self.diagnostics_package_names forKey:@"diagnostics_package_names"];
    [encoder encodeObject:self.diagnostics_fees_max forKey:@"diagnostics_fees_max"];
    [encoder encodeObject:self.diagnostics_fees_max_service forKey:@"diagnostics_fees_max_service"];
    [encoder encodeObject:self.diagnostics_fees_min forKey:@"diagnostics_fees_min"];
    [encoder encodeObject:self.diagnostics_fees_service forKey:@"diagnostics_fees_service"];
    [encoder encodeObject:self.diagnostics_id forKey:@"diagnostics_id"];
    [encoder encodeObject:self.diagnostics_image forKey:@"diagnostics_image"];
    [encoder encodeObject:self.diagnostics_lat forKey:@"diagnostics_lat"];
    [encoder encodeObject:self.diagnostics_location forKey:@"diagnostics_location"];
    [encoder encodeObject:self.diagnostics_long forKey:@"diagnostics_long"];
    [encoder encodeObject:self.diagnostics_name forKey:@"diagnostics_name"];
    [encoder encodeObject:self.diagnostics_offer_description forKey:@"diagnostics_offer_description"];
    [encoder encodeObject:self.diagnostics_offer_text forKey:@"diagnostics_offer_text"];
    [encoder encodeObject:self.diagnostics_rank forKey:@"diagnostics_rank"];
    [encoder encodeObject:self.diagnostics_rating forKey:@"diagnostics_rating"];
    [encoder encodeObject:self.diagnostics_review_count forKey:@"diagnostics_review_count"];
    [encoder encodeObject:self.diagnostics_services forKey:@"diagnostics_services"];
    [encoder encodeObject:self.diagnostics_time forKey:@"diagnostics_time"];
    [encoder encodeObject:self.diagnostics_type forKey:@"diagnostics_type"];
    [encoder encodeObject:self.diagnostics_package forKey:@"diagnostics_package"];
    
}



@end
