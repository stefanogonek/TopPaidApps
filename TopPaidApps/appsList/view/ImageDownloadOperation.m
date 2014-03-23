//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "ImageDownloadOperation.h"

@interface ImageDownloadOperation()

@property(nonatomic, retain) NSString *imageUrl;
@property(nonatomic, assign) NSInteger row;

@end

@implementation ImageDownloadOperation

- (void)dealloc
{
    [_imageUrl release];
    [super dealloc];
}

- (id)initWithImageUrl:(NSString *)url atRow:(NSInteger)row
{
    self = [super init];
    if (self) {
        _imageUrl = [url retain];
        _row = row;
    }
    return self;
}

+ (instancetype)operationForImageUrl:(NSString *)url atRow:(NSInteger)row
{
    return [[[self alloc] initWithImageUrl:url atRow:row] autorelease];
}

- (void)main
{
    [super main];

    NSURL *url = [NSURL URLWithString:self.imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    NSError *error;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:nil
                                                          error:&error];
    if (!imageData) {
        [self informDelegateAboutError:error];
        return;
    }
    UIImage *image = [UIImage imageWithData:imageData];
    [self informDelegateAboutDownloadedImage:image];
}

- (void)informDelegateAboutError:(NSError *)error
{
    [self.delegate downloadOfImageFailedWithError:error];
}

- (void)informDelegateAboutDownloadedImage:(UIImage *)image
{
    [self.delegate successfullyDownloadedImage:image atRow:self.row];
}


@end