//
//  VerticalListingServices.m
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "VerticalListingServices.h"
#import "Constants.h"

@implementation VerticalListingServices

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize withDictionary:(NSDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    NSMutableArray *arrayOfObjects = [[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"vertical" :[dict objectForKey:@"vertical"],@"city_id" :[NSString stringWithFormat:@"%ld",(long)[[dict objectForKey:@"cityid"]integerValue]],@"q" :[dict objectForKey:@"q"], @"page" : [NSString stringWithFormat:@"%lu",(unsigned long)page],@"session_id" : [dict objectForKey:@"sessionid"]
                                 ,@"coordinates" : [dict objectForKey:@"coordinates"]
                                 ,@"location" : [dict objectForKey:@"location"]};
    [manager POST:@"http://www.ziffi.com/api/search/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        
        [arrayOfObjects removeAllObjects];
        if ([[dict objectForKey:@"vertical"] isEqualToString:@"salons-spas"])  {
            
            if ([jsonObject objectForKey:@"results"] != nil && [jsonObject objectForKey:@"results"] != NULL) {
                [SVProgressHUD dismiss];
                NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
                arrayTemp = [jsonObject objectForKey:@"results"];
                if ([arrayTemp count] > 0) {
                    for (int i=0; i<[arrayTemp count]; i++) {
                        
                        NSDictionary *tempDict = [arrayTemp objectAtIndex:i];
                        SalonListingData *objUser = [[SalonListingData alloc]init];
                        if ([tempDict objectForKey:@"id"] != [NSNull null] && [tempDict objectForKey:@"id"] != nil) {
                            NSString *salonId = (NSString *)[tempDict objectForKey:@"id"];
                            objUser.salon_id = salonId;
                        }
                        if ([tempDict objectForKey:@"name"] != [NSNull null] && [tempDict objectForKey:@"name"] != nil) {
                            objUser.salon_name = [tempDict objectForKey:@"name"];
                        }
                        if ([tempDict objectForKey:@"location"] != [NSNull null] && [tempDict objectForKey:@"location"] != nil) {
                            objUser.salon_location = [tempDict objectForKey:@"location"];
                        }
                        if ([tempDict objectForKey:@"address"] != [NSNull null] && [tempDict objectForKey:@"address"] != nil) {
                            objUser.salon_address = [tempDict objectForKey:@"address"];
                        }
                        if ([tempDict objectForKey:@"image"] != [NSNull null] && [tempDict objectForKey:@"image"] != nil) {
                            objUser.salon_image = [tempDict objectForKey:@"image"];
                        }
                        if ([tempDict objectForKey:@"reviews_count"] != [NSNull null] && [tempDict objectForKey:@"reviews_count"] != nil) {
                            objUser.salon_review_count = [tempDict objectForKey:@"reviews_count"];
                        }
                        if ([tempDict objectForKey:@"rating"] != [NSNull null] && [tempDict objectForKey:@"rating"] != nil) {
                            objUser.salon_rating = [tempDict objectForKey:@"rating"];
                        }
                        if ([tempDict objectForKey:@"fees_min"] != [NSNull null] && [tempDict objectForKey:@"fees_min"] != nil) {
                            objUser.salon_fees_min = [tempDict objectForKey:@"fees_min"];
                        }
                        if ([tempDict objectForKey:@"fees_min_service"] != [NSNull null] && [tempDict objectForKey:@"fees_min_service"] != nil) {
                            objUser.salon_fees_service = [tempDict objectForKey:@"fees_min_service"];
                        }
                        if ([tempDict objectForKey:@"fees_max"] != [NSNull null] && [tempDict objectForKey:@"fees_max"] != nil) {
                            objUser.salon_fees_max = [tempDict objectForKey:@"fees_max"];
                        }
                        if ([tempDict objectForKey:@"fees_max_service"] != [NSNull null] && [tempDict objectForKey:@"fees_max_service"] != nil) {
                            objUser.salon_fees_max_service = [tempDict objectForKey:@"fees_max_service"];
                        }
                        if ([tempDict objectForKey:@"type"] != [NSNull null] && [tempDict objectForKey:@"type"] != nil) {
                            objUser.salon_type = [tempDict objectForKey:@"type"];
                        }
                        if ([tempDict objectForKey:@"latitude"] != [NSNull null] && [tempDict objectForKey:@"latitude"] != nil) {
                            objUser.salon_lat = [tempDict objectForKey:@"latitude"];
                        }
                        if ([tempDict objectForKey:@"longitude"] != [NSNull null] && [tempDict objectForKey:@"longitude"] != nil) {
                            objUser.salon_long = [tempDict objectForKey:@"longitude"];
                        }
                        if ([tempDict objectForKey:@"working_at"] != [NSNull null] && [tempDict objectForKey:@"working_at"] != nil) {
                            objUser.salon_time = [tempDict objectForKey:@"working_at"];
                        }
                        if ([tempDict objectForKey:@"services"] != [NSNull null] && [tempDict objectForKey:@"services"] != nil) {
                            objUser.salon_services = [tempDict objectForKey:@"services"];
                        }
                        if ([tempDict objectForKey:@"offer_text"] != [NSNull null] && [tempDict objectForKey:@"offer_text"] != nil) {
                            objUser.salon_offer_text = [tempDict objectForKey:@"offer_text"];
                        }
                        if ([tempDict objectForKey:@"offer_description"] != [NSNull null] && [tempDict objectForKey:@"offer_description"] != nil) {
                            objUser.salon_offer_description = [tempDict objectForKey:@"offer_description"];
                        }
                        if ([tempDict objectForKey:@"rank"] != [NSNull null] && [tempDict objectForKey:@"rank"] != nil) {
                            objUser.salon_rank= [tempDict objectForKey:@"rank"];
                        }
                        
                        //NSLog(@"%@ and %@",objUser.salon_name,objUser.salon_rating);
                        [arrayOfObjects addObject:objUser];
                    }
                    
                    NSUInteger totalResult = [[[jsonObject objectForKey:@"meta"]objectForKey:@"total_results"]integerValue];
                    [self receivedResults:arrayOfObjects total:totalResult];
                }
            }
        }
        else if ([[dict objectForKey:@"vertical"] isEqualToString:@"doctors"]) {
            
            if ([jsonObject objectForKey:@"results"] != nil && [jsonObject objectForKey:@"results"] != NULL) {
                [SVProgressHUD dismiss];
                NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
                arrayTemp = [jsonObject objectForKey:@"results"];
                if ([arrayTemp count] > 0) {
                    for (int i=0; i<[arrayTemp count]; i++) {
                        
                        NSDictionary *tempDict = [arrayTemp objectAtIndex:i];
                        DoctorsLisitingData *objUser = [[DoctorsLisitingData alloc]init];
                        if ([tempDict objectForKey:@"id"] != [NSNull null] && [tempDict objectForKey:@"id"] != nil) {
                            NSString *doctorId = (NSString *)[tempDict objectForKey:@"id"];
                            objUser.doctor_id = doctorId;
                        }
                        if ([tempDict objectForKey:@"name"] != [NSNull null] && [tempDict objectForKey:@"name"] != nil) {
                            objUser.doctor_name = [tempDict objectForKey:@"name"];
                        }
                        if ([tempDict objectForKey:@"degrees"] != [NSNull null] && [tempDict objectForKey:@"degrees"] != nil) {
                            objUser.doctor_degrees = [tempDict objectForKey:@"degrees"];
                        }
                        if ([tempDict objectForKey:@"positions"] != [NSNull null] && [tempDict objectForKey:@"positions"] != nil) {
                            objUser.doctor_positions = [tempDict objectForKey:@"positions"];
                        }
                        if ([tempDict objectForKey:@"expertise"] != [NSNull null] && [tempDict objectForKey:@"expertise"] != nil) {
                            objUser.doctor_exepertise = [tempDict objectForKey:@"expertise"];
                        }
                        if ([tempDict objectForKey:@"awards"] != [NSNull null] && [tempDict objectForKey:@"awards"] != nil) {
                            objUser.doctor_awards = [tempDict objectForKey:@"awards"];
                        }
                        if ([tempDict objectForKey:@"educational_qualifications"] != [NSNull null] && [tempDict objectForKey:@"educational_qualifications"] != nil) {
                            objUser.doctor_equqa = [tempDict objectForKey:@"educational_qualifications"];
                        }
                        if ([tempDict objectForKey:@"professional_qualifications"] != [NSNull null] && [tempDict objectForKey:@"professional_qualifications"] != nil) {
                            objUser.doctor_proqa = [tempDict objectForKey:@"professional_qualifications"];
                        }
                        if ([tempDict objectForKey:@"research_qualifications"] != [NSNull null] && [tempDict objectForKey:@"research_qualifications"] != nil) {
                            objUser.doctor_resqa = [tempDict objectForKey:@"fees_min_service"];
                        }
                        if ([tempDict objectForKey:@"languages"] != [NSNull null] && [tempDict objectForKey:@"languages"] != nil) {
                            objUser.doctor_language = [tempDict objectForKey:@"languages"];
                        }
                        if ([tempDict objectForKey:@"image"] != [NSNull null] && [tempDict objectForKey:@"image"] != nil) {
                            objUser.doctor_image = [tempDict objectForKey:@"image"];
                        }
                        if ([tempDict objectForKey:@"experience"] != [NSNull null] && [tempDict objectForKey:@"experience"] != nil) {
                            objUser.doctor_exeperience = [[tempDict objectForKey:@"experience"]stringValue];
                        }
                        if ([tempDict objectForKey:@"reviews_count"] != [NSNull null] && [tempDict objectForKey:@"reviews_count"] != nil) {
                            objUser.doctor_review_count = [[tempDict objectForKey:@"reviews_count"] stringValue];
                        }
                        if ([tempDict objectForKey:@"rating"] != [NSNull null] && [tempDict objectForKey:@"rating"] != nil) {
                            objUser.doctor_rating = [[tempDict objectForKey:@"rating"] stringValue];
                        }
                        if ([tempDict objectForKey:@"fees_min"] != [NSNull null] && [tempDict objectForKey:@"fees_min"] != nil) {
                            objUser.doctor_fees_min = [[tempDict objectForKey:@"fees_min"]stringValue];
                        }
                        if ([tempDict objectForKey:@"fees_min_location"] != [NSNull null] && [tempDict objectForKey:@"fees_min_location"] != nil) {
                            objUser.doctor_fees_service = [tempDict objectForKey:@"fees_min_location"];
                        }
                        if ([tempDict objectForKey:@"fees_max"] != [NSNull null] && [tempDict objectForKey:@"fees_max"] != nil) {
                            objUser.doctor_fees_max = [[tempDict objectForKey:@"fees_max"]stringValue];
                        }
                        if ([tempDict objectForKey:@"fees_max_location"] != [NSNull null] && [tempDict objectForKey:@"fees_max_location"] != nil) {
                            objUser.doctor_fees_max_service = [tempDict objectForKey:@"fees_max_location"];
                        }
                        if ([tempDict objectForKey:@"specialties"] != [NSNull null] && [tempDict objectForKey:@"specialties"] != nil) {
                            objUser.doctor_specialties= [tempDict objectForKey:@"specialties"];
                        }
                        if ([tempDict objectForKey:@"hospitals"] != [NSNull null] && [tempDict objectForKey:@"hospitals"] != nil) {
                            objUser.doctor_hospitals= [tempDict objectForKey:@"hospitals"];
                        }
                        if ([tempDict objectForKey:@"locations"] != [NSNull null] && [tempDict objectForKey:@"locations"] != nil) {
                            objUser.doctor_locations= [tempDict objectForKey:@"locations"];
                        }
                        if ([tempDict objectForKey:@"hospital_names"] != [NSNull null] && [tempDict objectForKey:@"hospital_names"] != nil) {
                            objUser.doctor_hospital_names= [tempDict objectForKey:@"hospital_names"];
                        }
                        if ([tempDict objectForKey:@"type"] != [NSNull null] && [tempDict objectForKey:@"type"] != nil) {
                            objUser.doctor_type= [tempDict objectForKey:@"type"];
                        }
                        if ([tempDict objectForKey:@"working_at"] != [NSNull null] && [tempDict objectForKey:@"working_at"] != nil) {
                            objUser.doctor_time= [tempDict objectForKey:@"working_at"];
                        }
                        if ([tempDict objectForKey:@"services"] != [NSNull null] && [tempDict objectForKey:@"services"] != nil) {
                            objUser.doctor_services= [tempDict objectForKey:@"services"];
                        }
                        if ([tempDict objectForKey:@"offer_text"] != [NSNull null] && [tempDict objectForKey:@"offer_text"] != nil) {
                            objUser.doctor_offer_text= [tempDict objectForKey:@"offer_text"];
                        }
                        if ([tempDict objectForKey:@"offer_description"] != [NSNull null] && [tempDict objectForKey:@"offer_description"] != nil) {
                            objUser.doctor_offer_description= [tempDict objectForKey:@"offer_description"];
                        }
                        if ([tempDict objectForKey:@"rank"] != [NSNull null] && [tempDict objectForKey:@"rank"] != nil) {
                            objUser.doctor_rank= [tempDict objectForKey:@"rank"];
                        }
                        [arrayOfObjects addObject:objUser];
                    }
                    
                    NSUInteger totalResult = [[[jsonObject objectForKey:@"meta"]objectForKey:@"total_results"]integerValue];
                    [self receivedResults:arrayOfObjects total:totalResult];
                }
            }
        }
        
        else {
            
            if ([jsonObject objectForKey:@"results"] != nil && [jsonObject objectForKey:@"results"] != NULL) {
                [SVProgressHUD dismiss];
                NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
                arrayTemp = [jsonObject objectForKey:@"results"];
                if ([arrayTemp count] > 0) {
                    for (int i=0; i<[arrayTemp count]; i++) {
                        
                        NSDictionary *tempDict = [arrayTemp objectAtIndex:i];
                        DiagnosticsListingData *objUser = [[DiagnosticsListingData alloc]init];
                        if ([tempDict objectForKey:@"id"] != [NSNull null] && [tempDict objectForKey:@"id"] != nil) {
                            NSString *salonId = (NSString *)[tempDict objectForKey:@"id"];
                            objUser.diagnostics_id = salonId;
                        }
                        if ([tempDict objectForKey:@"name"] != [NSNull null] && [tempDict objectForKey:@"name"] != nil) {
                            objUser.diagnostics_name = [tempDict objectForKey:@"name"];
                        }
                        if ([tempDict objectForKey:@"location"] != [NSNull null] && [tempDict objectForKey:@"location"] != nil) {
                            objUser.diagnostics_location = [tempDict objectForKey:@"location"];
                        }
                        if ([tempDict objectForKey:@"address"] != [NSNull null] && [tempDict objectForKey:@"address"] != nil) {
                            objUser.diagnostics_address = [tempDict objectForKey:@"address"];
                        }
                        if ([tempDict objectForKey:@"image"] != [NSNull null] && [tempDict objectForKey:@"image"] != nil) {
                            objUser.diagnostics_image = [tempDict objectForKey:@"image"];
                        }
                        if ([tempDict objectForKey:@"reviews_count"] != [NSNull null] && [tempDict objectForKey:@"reviews_count"] != nil) {
                            objUser.diagnostics_review_count = [tempDict objectForKey:@"reviews_count"];
                        }
                        if ([tempDict objectForKey:@"rating"] != [NSNull null] && [tempDict objectForKey:@"rating"] != nil) {
                            objUser.diagnostics_rating = [tempDict objectForKey:@"rating"];
                        }
                        if ([tempDict objectForKey:@"fees_min"] != [NSNull null] && [tempDict objectForKey:@"fees_min"] != nil) {
                            objUser.diagnostics_fees_min = [tempDict objectForKey:@"fees_min"];
                        }
                        if ([tempDict objectForKey:@"fees_min_service"] != [NSNull null] && [tempDict objectForKey:@"fees_min_service"] != nil) {
                            objUser.diagnostics_fees_service = [tempDict objectForKey:@"fees_min_service"];
                        }
                        if ([tempDict objectForKey:@"fees_max"] != [NSNull null] && [tempDict objectForKey:@"fees_max"] != nil) {
                            objUser.diagnostics_fees_max = [tempDict objectForKey:@"fees_max"];
                        }
                        if ([tempDict objectForKey:@"fees_max_service"] != [NSNull null] && [tempDict objectForKey:@"fees_max_service"] != nil) {
                            objUser.diagnostics_fees_max_service = [tempDict objectForKey:@"fees_max_service"];
                        }
                        if ([tempDict objectForKey:@"type"] != [NSNull null] && [tempDict objectForKey:@"type"] != nil) {
                            objUser.diagnostics_type = [tempDict objectForKey:@"type"];
                        }
                        if ([tempDict objectForKey:@"latitude"] != [NSNull null] && [tempDict objectForKey:@"latitude"] != nil) {
                            objUser.diagnostics_lat = [tempDict objectForKey:@"latitude"];
                        }
                        if ([tempDict objectForKey:@"longitude"] != [NSNull null] && [tempDict objectForKey:@"longitude"] != nil) {
                            objUser.diagnostics_long = [tempDict objectForKey:@"longitude"];
                        }
                        if ([tempDict objectForKey:@"working_at"] != [NSNull null] && [tempDict objectForKey:@"working_at"] != nil) {
                            objUser.diagnostics_time = [tempDict objectForKey:@"working_at"];
                        }
                        if ([tempDict objectForKey:@"services"] != [NSNull null] && [tempDict objectForKey:@"services"] != nil) {
                            objUser.diagnostics_services = [tempDict objectForKey:@"services"];
                        }
                        if ([tempDict objectForKey:@"offer_text"] != [NSNull null] && [tempDict objectForKey:@"offer_text"] != nil) {
                            objUser.diagnostics_offer_text = [tempDict objectForKey:@"offer_text"];
                        }
                        if ([tempDict objectForKey:@"offer_description"] != [NSNull null] && [tempDict objectForKey:@"offer_description"] != nil) {
                            objUser.diagnostics_offer_description = [tempDict objectForKey:@"offer_description"];
                        }
                        if ([tempDict objectForKey:@"rank"] != [NSNull null] && [tempDict objectForKey:@"rank"] != nil) {
                            objUser.diagnostics_rank= [tempDict objectForKey:@"rank"];
                        }
                        if ([tempDict objectForKey:@"package_names"] != [NSNull null] && [tempDict objectForKey:@"package_names"] != nil) {
                            objUser.diagnostics_package_names= [tempDict objectForKey:@"package_names"];
                        }
                        if ([tempDict objectForKey:@"package"] != [NSNull null] && [tempDict objectForKey:@"package"] != nil) {
                            objUser.diagnostics_package = [tempDict objectForKey:@"package"];
                        }
                        [arrayOfObjects addObject:objUser];
                    }
                    NSUInteger totalResult = [[[jsonObject objectForKey:@"meta"]objectForKey:@"total_results"]integerValue];
                    [self receivedResults:arrayOfObjects total:totalResult];
                }
                NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:arrayOfObjects];
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [prefs setObject:myEncodedObject forKey:@"ListingData"];
                [prefs synchronize];
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:@"We do not seem to have any related salons/spas for sdfdfg in this city." title:APP_NAME];
        [SVProgressHUD dismiss];
    }];

}


@end
