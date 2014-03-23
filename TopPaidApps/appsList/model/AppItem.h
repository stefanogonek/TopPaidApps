//
// Created by Stefan Ogonek on 21/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppItem : NSObject

@property(nonatomic, assign) NSUInteger rank;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *imageUrl;

+ (instancetype)appItem;

@end