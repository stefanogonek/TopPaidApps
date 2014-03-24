//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppItem;
@class AppCell;

@protocol AppCellDelegate

- (void)appCellNeedsRefresh:(AppCell*)appCell;

@end

@interface AppCell : UITableViewCell

@property(nonatomic, assign) id<AppCellDelegate>delegate;
@property(nonatomic, assign) NSInteger currentRow;

+ (instancetype)appCellWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)configureWithAppItem:(AppItem *)appItem atRow:(NSInteger)row forceRefresh:(BOOL)refresh;

@end