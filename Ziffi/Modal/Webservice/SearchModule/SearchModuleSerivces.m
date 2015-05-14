//
//  SearchModuleSerivces.m
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import "SearchModuleSerivces.h"
#import "Constants.h"

@implementation SearchModuleSerivces

+(void)DiscountListing:(NSString *)page
         withSessionId:(NSString *)sessionId
 withCompletionHandler:(void (^)(NSDictionary *result))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"page" : @"1", @"session_id" : sessionId};
    [manager POST:DISCOUNTS parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if (jsonObject != NULL || jsonObject != nil) {
            callback(jsonObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(nil);
    }];
}


+(void)SuggestionListing:(NSString *)vertical
              withCityId:(NSUInteger )cityid
          withSearchText:(NSString *)searcxhtext
           withSessionId:(NSString *)sessionId
   withCompletionHandler:(void (^)(NSDictionary *result))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"vertical" :vertical,@"city_id" :[NSString stringWithFormat:@"%lu",(unsigned long)cityid],@"str" :searcxhtext, @"session_id" : sessionId};
    [manager POST:SUGGESTIONQUERY parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if (jsonObject != NULL || jsonObject != nil) {
            callback(jsonObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(nil);
    }];
}



+(void)LocationSuggestionListing:(NSString *)vertical
              withCityId:(NSUInteger )cityid
          withSearchText:(NSString *)searcxhtext
           withSessionId:(NSString *)sessionId
   withCompletionHandler:(void (^)(NSDictionary *result))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"vertical" :vertical,@"city_id" :[NSString stringWithFormat:@"%lu",(unsigned long)cityid],@"str" :searcxhtext, @"session_id" : sessionId};
    [manager POST:LOCATIONSUGGESTIONQUERY parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *feedStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [parser objectWithString:feedStr error:NULL];
        if (jsonObject != NULL || jsonObject != nil) {
            callback(jsonObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonFunctions showWarningAlert:error.description title:APP_NAME];
        [SVProgressHUD dismiss];
        callback(nil);
    }];
}


@end
