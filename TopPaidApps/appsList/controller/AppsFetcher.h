//
// Created by Stefan Ogonek on 21/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppsFetcherDelegate

- (void)fetcherReturnedWithAppsList:(NSArray *)appsList;
- (void)fetcherFailedWithError:(NSError *)error;

@end


@interface AppsFetcher : NSObject

@property(nonatomic, assign) id<AppsFetcherDelegate> delegate;

+ (instancetype)appsFetcher;

- (void)start;

@end