//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "Parser.h"
#import "AppItem.h"

@interface Parser()

@property (nonatomic, retain) NSData *jsonData;

@end

@implementation Parser


- (void)dealloc
{
    [_jsonData release];
    [super dealloc];
}

+ (instancetype)parserWithJsonData:(NSData *)data
{
    return [[[self alloc] initWithJsonData:data] autorelease];
}

- (id)initWithJsonData:(NSData *)data
{
    self = [super init];
    if (self) {
       _jsonData = [data retain];
    }
    return self;
}

- (NSArray *)parse:(NSError **)pError
{
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:self.jsonData
                                                             options:0
                                                               error:&error];
    if (error) {
        *pError = error;
        return nil;
    }

    NSArray *appsList = [self convertJsonDictToAppEntries:jsonDict];
    return appsList;
}

- (NSArray *)convertJsonDictToAppEntries:(NSDictionary *)jsonDict
{
    NSMutableArray *appsList = [NSMutableArray array];
    NSArray *entries = jsonDict[@"feed"][@"entry"];

    NSUInteger rank = 1;
    for (NSDictionary *appDict in entries) {

        AppItem *appItem = [AppItem appItem];
        appItem.rank = rank++;
        appItem.name = appDict[@"im:name"][@"label"];
        appItem.imageUrl = [self getImageUrlFromImageArray:appDict[@"im:image"]];
        [appsList addObject:appItem];
    }

    return [NSArray arrayWithArray:appsList];
}

- (NSString *)getImageUrlFromImageArray:(NSArray *)imageArray
{
    NSDictionary *imageDict = [self findImageDictWithHeight100:imageArray];
    NSString *imageUrl = imageDict[@"label"];
    return imageUrl;
}

- (NSDictionary *)findImageDictWithHeight100:(NSArray *)imageArray
{
    NSDictionary *foundImageDict = nil;
    for (NSDictionary *imageDict in imageArray) {

        NSInteger height = [self getImageHeightFromImageDict:imageDict];
        if (height == 100) {
            foundImageDict = imageDict;
            break;
        }
    }
    return foundImageDict;
}

- (NSInteger)getImageHeightFromImageDict:(NSDictionary *)imageDict
{
    NSString *heightString = imageDict[@"attributes"][@"height"];
    NSInteger height = [heightString integerValue];
    return height;
}

@end