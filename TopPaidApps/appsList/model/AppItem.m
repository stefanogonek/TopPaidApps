//
// Created by Stefan Ogonek on 21/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "AppItem.h"

@implementation AppItem

+ (instancetype)appItem
{
    return [[[self alloc] init] autorelease];
}

- (void)dealloc
{
    [_name release];
    [_imageUrl release];
    [super dealloc];
}

@end