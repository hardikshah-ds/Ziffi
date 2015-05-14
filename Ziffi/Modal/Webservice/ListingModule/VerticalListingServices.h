//
//  VerticalListingServices.h
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TablePagination.h"

@interface VerticalListingServices : TablePagination

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize withDictionary:(NSDictionary *)dict;

@end
