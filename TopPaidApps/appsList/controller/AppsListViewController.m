//
//  AppsListViewController.m
//  TopPaidApps
//
//  Created by Stefan Ogonek on 20/03/14.
//  Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "AppsListViewController.h"

@interface AppsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@end

@implementation AppsListViewController

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Top Paid Apps";
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma mark - UITableViewDelegate

@end
