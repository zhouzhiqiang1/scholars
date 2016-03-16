//
//  SCPictureTableViewController.m
//  scholars
//
//  Created by r_zhou on 16/3/15.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import "SCPictureTableViewController.h"
#import "SCPictureTableViewCell.h"
#import <MJRefresh.h>
#import "ORIndicatorView.h"

@interface SCPictureTableViewController ()
@property (strong, nonatomic) MJRefreshAutoNormalFooter *refreshFooter;
@end

@implementation SCPictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"趣味";
    
    //监听
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
    self.tableView.mj_header = header;
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(startLoadMore)];
//    [header beginRefreshing];
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
//    self.listModel = [[YDInviteFriendsModel alloc] init];
//    
//    [self.listModel addObserver:self forKeyPath:kKeyPathDataSource options:NSKeyValueObservingOptionNew context:nil];
//    [self.listModel addObserver:self forKeyPath:kKeyPathDataFetchResult options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unloadModel
{
    @try {
//        [self.listModel removeObserver:self forKeyPath:kKeyPathDataSource];
//        [self.listModel removeObserver:self forKeyPath:kKeyPathDataFetchResult];
//        [self setModel:nil];
    }
    @catch (NSException *exception) {
    }
}

-(void)startRefresh
{
//    [self.listModel fetchList];
    [ORIndicatorView showLoading];
    NSLog(@"下拉刷新");
    [self stopLoadingWithSuccess:YES];
}

- (void)startLoadMore
{
    [ORIndicatorView showLoading];
    NSLog(@"上拉刷新");
//    [self.listModel fetchMore];
     [self stopLoadingWithSuccess:YES];
}

- (void)stopLoadingWithSuccess:(BOOL)aSuccess
{
    [super stopLoadingWithSuccess:aSuccess];
    [ORIndicatorView hideLoading];
    self.tableView.mj_footer = [self.listModel hasMore]?self.refreshFooter:nil;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    NSString *cell = @"SCPictureTableViewCell";
    
    SCPictureTableViewCell *pictureTableViewCell = [tableView dequeueReusableCellWithIdentifier:cell forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    return pictureTableViewCell;
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
