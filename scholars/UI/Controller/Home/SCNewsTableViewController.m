//
//  YDNewsTableViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/10.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCNewsTableViewController.h"
#import "SCNewsTableViewCell.h"
#import "SCNewsTableViewModel.h"
#import <MJRefresh.h>
#import "SCEncapsulation.h"
#import "ORIndicatorView.h"
#import "ORColorUtil.h"

@interface SCNewsTableViewController ()<MGSwipeTableCellDelegate>
@property (strong, nonatomic) MJRefreshAutoNormalFooter *refreshFooter;
@property (strong, nonatomic) SCNewsTableViewModel *newsTableViewModel;
@end

@implementation SCNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    //设置回调
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
    
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(startLoadMore)];
    //    [header beginRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    [header setImages:[SCEncapsulation nsarry] forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:[SCEncapsulation nsarry] forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:[SCEncapsulation nsarry] forState:MJRefreshStateRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    [self startRefresh];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Model
-(void)commonInit
{
    [super commonInit];
    [self loadModel];
}

- (void)loadModel
{
    [self unloadModel];
    self.newsTableViewModel = [[SCNewsTableViewModel alloc] init];
    
    [self.newsTableViewModel addObserver:self forKeyPath:kKeyPathDataSource options:NSKeyValueObservingOptionNew context:nil];
    [self.newsTableViewModel addObserver:self forKeyPath:kKeyPathDataFetchResult options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unloadModel
{
    @try {
        [self.newsTableViewModel removeObserver:self forKeyPath:kKeyPathDataSource];
        [self.newsTableViewModel removeObserver:self forKeyPath:kKeyPathDataFetchResult];
        [self setNewsTableViewModel:nil];
    }
    @catch (NSException *exception) {
    }
}

-(void)startRefresh
{
    NSLog(@"下拉刷新");
    [ORIndicatorView showLoading];
    [self.newsTableViewModel fetchList];
}

- (void)startLoadMore
{
    NSLog(@"上拉刷新");
    [ORIndicatorView showLoading];
    [self.newsTableViewModel fetchMore];
}

- (void)stopLoadingWithSuccess:(BOOL)aSuccess
{
    [super stopLoadingWithSuccess:aSuccess];
    [ORIndicatorView hideLoading];
    self.tableView.mj_footer = [self.newsTableViewModel hasMore]?self.refreshFooter:nil;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsTableViewModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cell = @"SCNewsTableViewCell";
    
    SCNewsTableViewCell *newsTableViewCell = [tableView dequeueReusableCellWithIdentifier:cell forIndexPath:indexPath];
    SCNewsInfo *newsInfo = [self.newsTableViewModel objectAtIndex:indexPath.row];
    [newsTableViewCell newsData:newsInfo];
    
    newsTableViewCell.delegate = self;
    newsTableViewCell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"img_collection_delete.png"] backgroundColor:ORColor(@"f5f5f9")]];
    newsTableViewCell.rightSwipeSettings.transition = MGSwipeTransition3D;
    
    return newsTableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma mark -- MGSwipeTableCellDelegate
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    DDLogDebug(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
               direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        DDLogDebug(@"删除");
    }
    return YES;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.isViewLoaded == NO)
    {
        return;
    }
    
    if ([keyPath isEqualToString:kKeyPathDataSource]) {
        [self.tableView reloadData];
    } else if ([keyPath isEqualToString:kKeyPathDataFetchResult]) {
        [self stopLoadingWithSuccess:YES];
        
    }
}

@end
