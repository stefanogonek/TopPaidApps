//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppItem;


@interface AppCell : UITableViewCell

+ (instancetype)appCellWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)configureWithAppItem:(AppItem *)appItem atRow:(NSInteger)row;

@end