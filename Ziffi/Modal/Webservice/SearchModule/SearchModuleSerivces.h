//
//  SearchModuleSerivces.h
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModuleSerivces : NSObject

+(void)DiscountListing:(NSString *)page
         withSessionId:(NSString *)sessionId
 withCompletionHandler:(void (^)(NSDictionary *result))callback;

+(void)SuggestionListing:(NSString *)vertical
              withCityId:(NSUInteger)cityid
          withSearchText:(NSString *)searcxhtext
           withSessionId:(NSString *)sessionId
   withCompletionHandler:(void (^)(NSDictionary *result))callback;

+(void)LocationSuggestionListing:(NSString *)vertical
                      withCityId:(NSUInteger )cityid
                  withSearchText:(NSString *)searcxhtext
                   withSessionId:(NSString *)sessionId
           withCompletionHandler:(void (^)(NSDictionary *result))callback;

@end
