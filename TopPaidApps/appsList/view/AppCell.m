//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "AppCell.h"
#import "AppItem.h"
#import "ImageDownloadOperation.h"
#import "UIImage+Utils.h"

static NSInteger kImageSize = 36;

@interface AppCell()<ImageDownloadOperationDelegate>

@property(nonatomic, retain) ImageDownloadOperation *imageDownloadOperation;
@property(nonatomic, retain) NSOperationQueue *downloadQueue;

@end

@implementation AppCell

- (void)dealloc
{
    [_downloadQueue cancelAllOperations];
    [_downloadQueue release];
    _imageDownloadOperation.delegate = nil;
    [_imageDownloadOperation cancel];
    [_imageDownloadOperation release];
    [super dealloc];
}

+ (instancetype)appCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    AppCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:reuseIdentifier];
    return [cell autorelease];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _currentRow = -1;
        _downloadQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}


- (void)configureWithAppItem:(AppItem *)appItem atRow:(NSInteger)row forceRefresh:(BOOL)forceRefresh
{
    if (self.currentRow != row || forceRefresh) {
        self.imageView.image = nil;
        self.textLabel.text = [self getCellTitle:appItem];
        self.currentRow = row;
        [self startImageDownloadForImage:appItem.imageUrl atRow:row];
    }
}

- (NSString *)getCellTitle:(AppItem *)appItem
{
    NSString *rankString = [@(appItem.rank) stringValue];
    NSString *name = appItem.name;
    return [NSString stringWithFormat:@"%@. %@", rankString, name];
}

- (void)startImageDownloadForImage:(NSString *)imageUrl atRow:(NSInteger)row
{
    self.imageDownloadOperation = [ImageDownloadOperation operationForImageUrl:imageUrl atRow:row];
    self.imageDownloadOperation.delegate = self;
    [self.downloadQueue addOperation:self.imageDownloadOperation];
}

#pragma mark ImageDownloadOperationDelegate

- (void)successfullyDownloadedImage:(UIImage *)image atRow:(NSInteger)row
{
    UIImage *scaledImage = [image scaleToSize:CGSizeMake(kImageSize, kImageSize)];

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self.currentRow == row) {
            self.imageView.image = scaledImage;
            [self.delegate appCellNeedsRefresh:self];
        }
    }];
}

- (void)downloadOfImageFailedWithError:(NSError *)error
{
    //TODO: implement
}

@end