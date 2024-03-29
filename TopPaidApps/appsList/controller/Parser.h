//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Parser : NSObject

+ (instancetype)parserWithJsonData:(NSData *)data;

- (NSArray *)parse:(NSError **)pError;


@end