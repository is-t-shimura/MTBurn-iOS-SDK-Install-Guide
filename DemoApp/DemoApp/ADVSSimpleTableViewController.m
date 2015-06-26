//
//  ADVSSimpleTableViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2015/06/16.
//  Copyright (c) 2015年 MTBurn. All rights reserved.
//

#import "ADVSSimpleTableViewController.h"
#import <AppDavis/ADVSInstreamAdLoader.h>
#import "ADVSAppDelegate.h"
#import "MNMBottomPullToRefreshManager.h"

@interface ADVSSimpleTableViewController () <UITableViewDataSource, UITableViewDelegate, MNMBottomPullToRefreshManagerClient>
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) ADVSInstreamAdLoader *instreamAdLoader;
@property(nonatomic, strong) MNMBottomPullToRefreshManager* refreshManager;
@end

@implementation ADVSSimpleTableViewController

#pragma mark - LifyCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[NSArray alloc]initWithObjects:
                  @"0", @"1", @"2",@"3", nil];
    
    self.instreamAdLoader = [ADVSInstreamAdLoader new];
    
    [self.instreamAdLoader bindToTableView:self.tableView adSpotId:[self getAdSpotId]];
    [self.instreamAdLoader loadAd:2 positions:@[@1,@4]];
    
    // 下部Viewをpullして、追加でリロード処理を開始するためのコード
    self.refreshManager = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0 tableView:self.tableView withClient:self];
    // 上部のセルが隠れてしまうため、オフセットを設定する
    // see https://github.com/emenegro/bottom-pull-to-refresh/issues/8
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top += 60;
    self.refreshManager.contentInset = insets;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.refreshManager relocatePullToRefreshView];
}

- (NSString*)getAdSpotId
{
    ADVSAppDelegate *delegate = (ADVSAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSArray *adSpotIdDictForInstream = [delegate adspotIdDict][@"instream"];
    return adSpotIdDictForInstream[0];
}

- (void)loadMore
{
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_dataSource];
    for (int i = 0; i < 4; i++) {
        [temp addObject: [NSString stringWithFormat:@"%d", _dataSource.count + i]];
    }
    _dataSource = temp;
    
    [self.instreamAdLoader loadAd:2 positions:@[@1,@4]];
    
    [self.view layoutIfNeeded];
    [self.refreshManager tableViewReloadFinished];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped: %@", [self.dataSource objectAtIndex:indexPath.row]);
}

# pragma mark - MNMBottomPullToRefreshManager
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshManager tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.refreshManager tableViewReleased];
}

- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager
{
    [self performSelector:@selector(loadMore) withObject:nil afterDelay:0.3f];
}

@end
