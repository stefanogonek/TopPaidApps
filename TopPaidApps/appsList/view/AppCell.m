//
// Created by Stefan Ogonek on 23/03/14.
// Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "AppCell.h"
#import "AppItem.h"


@implementation AppCell

+ (instancetype)appCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    AppCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:reuseIdentifier];
    return [cell autorelease];
}

- (void)configureWithAppItem:(AppItem *)appItem atRow:(NSInteger)row
{
    self.textLabel.text = [self getCellTitle:appItem];
}

- (NSString *)getCellTitle:(AppItem *)appItem
{
    NSString *rankString = [@(appItem.rank) stringValue];
    NSString *name = appItem.name;
    return [NSString stringWithFormat:@"%@. %@", rankString, name];
}


@end