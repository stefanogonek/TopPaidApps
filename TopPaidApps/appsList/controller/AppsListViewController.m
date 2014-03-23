//
//  AppsListViewController.m
//  TopPaidApps
//
//  Created by Stefan Ogonek on 20/03/14.
//  Copyright (c) 2014 Stefan Ogonek. All rights reserved.
//

#import "AppsListViewController.h"
#import "AppsFetcher.h"
#import "AppCell.h"

@interface AppsListViewController ()<UITableViewDataSource, UITableViewDelegate, AppsFetcherDelegate>

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) AppsFetcher *appsFetcher;
@property(nonatomic, retain) NSArray *appsList;

@end

@implementation AppsListViewController

- (void)dealloc
{
    _appsFetcher.delegate = nil;
    [_appsFetcher release];
    [_appsList release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchAppsList];
}

- (void)fetchAppsList
{
    self.appsFetcher = [AppsFetcher appsFetcher];
    self.appsFetcher.delegate = self;
    [self.appsFetcher start];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Top Paid Apps";
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AppCell";
    AppCell *appCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!appCell) {
        appCell = [AppCell appCellWithReuseIdentifier:cellIdentifier];
    }
    [appCell configureWithAppItem:self.appsList[indexPath.row] atRow:indexPath.row];
    return appCell;
}

#pragma mark - AppsFetcherDelegate

- (void)fetcherReturnedWithAppsList:(NSArray *)appsList
{
    self.appsList = appsList;
    [self.tableView reloadData];
}

- (void)fetcherFailedWithError:(NSError *)error
{
    //TODO: display alert
}


@end
