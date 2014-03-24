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

@interface AppsListViewController ()<AppsFetcherDelegate, AppCellDelegate>

@property(nonatomic, retain) AppsFetcher *appsFetcher;
@property(nonatomic, retain) NSArray *appsList;
@property(nonatomic, retain) NSArray *filteredAppsList;
@property(nonatomic, assign) BOOL forceCellsRefresh;

@end

@implementation AppsListViewController

- (void)dealloc
{
    _appsFetcher.delegate = nil;
    [_appsFetcher release];
    [_filteredAppsList release];
    [_appsList release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRefreshControl];
    [self fetchAppsList];
    self.searchDisplayController.displaysSearchBarInNavigationBar = YES;
}

- (void)addRefreshControl
{
    UIRefreshControl *refreshControl = [[[UIRefreshControl alloc] init] autorelease];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)refresh
{
    [self fetchAppsList];
}

- (void)fetchAppsList
{
    self.appsFetcher.delegate = nil;
    self.appsFetcher = [AppsFetcher appsFetcher];
    self.appsFetcher.delegate = self;
    [self.appsFetcher start];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Top Paid Apps";
    self.filteredAppsList = [[self.appsList copy] autorelease];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.filteredAppsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AppCell";
    AppCell *appCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!appCell) {
        appCell = [AppCell appCellWithReuseIdentifier:cellIdentifier];
        appCell.delegate = self;
    }
    [appCell configureWithAppItem:self.filteredAppsList[indexPath.row]
                            atRow:indexPath.row
                     forceRefresh:self.forceCellsRefresh];
    return appCell;
}

#pragma mark - AppsFetcherDelegate

- (void)fetcherReturnedWithAppsList:(NSArray *)appsList
{
    self.appsList = appsList;
    self.filteredAppsList = [[self.appsList copy] autorelease];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)fetcherFailedWithError:(NSError *)error
{
    //TODO: display alert
}

#pragma mark AppCellDelegate

- (void)appCellNeedsRefresh:(AppCell *)appCell
{
    [self.tableView reloadData];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (!searchString || searchString.length == 0) {
        
        self.filteredAppsList = [[self.appsList copy] autorelease];
    }
    else {
        self.filteredAppsList = [self.appsList filteredArrayUsingPredicate:
            [NSPredicate predicateWithFormat:@"name contains[cd] %@",searchString]];
    }
    
    self.forceCellsRefresh = YES;
    [self.tableView reloadData];
    
    return YES;
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {

    self.filteredAppsList = [[self.appsList copy] autorelease];
    self.forceCellsRefresh = NO;
    [self.tableView reloadData];
}


@end
