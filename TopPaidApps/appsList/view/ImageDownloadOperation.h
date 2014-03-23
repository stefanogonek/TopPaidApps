//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageDownloadOperationDelegate

- (void)successfullyDownloadedImage:(UIImage *)image atRow:(NSInteger)row;
- (void)downloadOfImageFailedWithError:(NSError *)error;

@end

@interface ImageDownloadOperation : NSOperation

@property(nonatomic, assign) id<ImageDownloadOperationDelegate> delegate;

+ (instancetype)operationForImageUrl:(NSString *)url atRow:(NSInteger)row;

@end