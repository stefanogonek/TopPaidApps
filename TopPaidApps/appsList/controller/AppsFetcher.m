//
// Created by Stefan Ogonek on 21/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "AppsFetcher.h"
#import "Parser.h"

@interface AppsFetcher()

@end

@implementation AppsFetcher

+ (instancetype)appsFetcher
{
    return [[[self alloc] init] autorelease];
}

- (void)start
{
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:30];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               if (connectionError) {
                                   [self informDelegateAboutError:connectionError];
                                   return;
                               }

                               [self processFetchedData:data];
                           }];
}

- (void)processFetchedData:(NSData *)data
{
    NSError *error = nil;
    Parser *parser = [Parser parserWithJsonData:data];
    NSArray *appsList = [parser parse:&error];
    if (error) {
        [self informDelegateAboutError:error];
        return;
    }
    [self informDelegateAboutSuccess:appsList];
}

- (void)informDelegateAboutSuccess:(NSArray *)appsList
{
    [self.delegate fetcherReturnedWithAppsList:appsList];
}

- (void)informDelegateAboutError:(NSError *)error
{
    [self.delegate fetcherFailedWithError:error];
}

@end