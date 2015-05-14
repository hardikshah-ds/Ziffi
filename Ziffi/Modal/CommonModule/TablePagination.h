//
//  TablePagination.h
//  Ziffi
//
//  Created by Hardik on 14/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RequestStatusNone,
    RequestStatusInProgress,
    RequestStatusDone // request succeeded or failed
} RequestStatus;

@protocol ZiffiPaginationDelegate
@required
- (void)Pagination:(id)Pagination didReceiveResults:(NSArray *)results;
@optional
- (void)PaginationDidFailToRespond:(id)paginator;
- (void)PaginationDidReset:(id)paginator;
@end

@interface TablePagination : NSObject {
    id <ZiffiPaginationDelegate> __weak delegate;
}

@property (weak) id delegate;
@property (assign, readonly) NSInteger pageSize; // number of results per page
@property (assign, readonly) NSInteger page; // number of pages already fetched
@property (assign, readonly) NSInteger total; // total number of results
@property (assign, readonly) RequestStatus requestStatus;
@property (nonatomic, strong, readonly) NSMutableArray *results;

- (id)initWithPageSize:(NSInteger)pageSize delegate:(id<ZiffiPaginationDelegate>)PaginationDelegate;
- (void)reset;
- (BOOL)reachedLastPage;

- (void)fetchFirstPage:(NSDictionary *)dict;
- (void)fetchNextPage:(NSDictionary *)dict;

// call these from subclass when you receive the results
- (void)receivedResults:(NSArray *)results total:(NSInteger)total;
- (void)failed;

@end
