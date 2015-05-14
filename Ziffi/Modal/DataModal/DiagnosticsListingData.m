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


@end
