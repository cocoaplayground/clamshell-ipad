//
//  DMMMasterViewController.m
//  ClamShell-iPad
//
//  Created by Delisa Mason on 5/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMMasterViewController.h"
#import "DMMDetailViewController.h"
#import "DMMTokenStore.h"
#import "DMMSearchResult.h"

@interface DMMMasterViewController () {
    NSArray *_objects;
}
@end

@implementation DMMMasterViewController

- (void)awakeFromNib
{
    _objects = [NSMutableArray new];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DMMDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    DMMSearchResult *result = [self resultForIndexPath:indexPath];
    cell.textLabel.text = [result name];
    cell.detailTextLabel.text = [result htmlFileName];
    cell.imageView.image = [result icon];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController.detailItem = [self resultForIndexPath:indexPath];
}

- (DMMSearchResult *) resultForIndexPath:(NSIndexPath *)indexPath
{
    return (DMMSearchResult *)_objects[indexPath.row];
}

#pragma mark - Search

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _objects = [DMMTokenStore tokensWithText:searchText];
    [self.tableView reloadData];
}
@end
