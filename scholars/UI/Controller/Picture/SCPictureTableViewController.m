//
//  SCPictureTableViewController.m
//  scholars
//
//  Created by r_zhou on 16/3/15.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCPictureTableViewController.h"
#import "SCPictureTableViewCell.h"
#import <MJRefresh.h>
#import "ORIndicatorView.h"
#import "SCPictureViewModel.h"
#import "GSDataEngine.h"

@interface SCPictureTableViewController ()<SCPictureTableViewCellDelegate>
@property (strong, nonatomic) MJRefreshAutoNormalFooter *refreshFooter;
@property (strong, nonatomic) SCPictureViewModel *pictureViewModel;
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
    self.pictureViewModel = [[SCPictureViewModel alloc] init];
    
    [self.pictureViewModel addObserver:self forKeyPath:kKeyPathDataSource options:NSKeyValueObservingOptionNew context:nil];
    [self.pictureViewModel addObserver:self forKeyPath:kKeyPathDataFetchResult options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unloadModel
{
    @try {
        [self.pictureViewModel removeObserver:self forKeyPath:kKeyPathDataSource];
        [self.pictureViewModel removeObserver:self forKeyPath:kKeyPathDataFetchResult];
        [self setPictureViewModel:nil];
    }
    @catch (NSException *exception) {
    }
}

-(void)startRefresh
{
    NSLog(@"下拉刷新");
    [ORIndicatorView showLoading];
    [self.pictureViewModel fetchList];
}

- (void)startLoadMore
{
    NSLog(@"上拉刷新");
    [ORIndicatorView showLoading];
    [self.pictureViewModel fetchMore];
}

- (void)stopLoadingWithSuccess:(BOOL)aSuccess
{
    [super stopLoadingWithSuccess:aSuccess];
    [ORIndicatorView hideLoading];
    self.tableView.mj_footer = [self.pictureViewModel hasMore]?self.refreshFooter:nil;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pictureViewModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    NSString *cell = @"SCPictureTableViewCell";
    
    SCPictureTableViewCell *pictureTableViewCell = [tableView dequeueReusableCellWithIdentifier:cell forIndexPath:indexPath];
    pictureTableViewCell.delegate = self;
    
    SCPictureInfo *pictureInfo = [self.pictureViewModel objectAtIndex:row];
    
    [pictureTableViewCell dataLoad:pictureInfo];
    
    return pictureTableViewCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}

#pragma mark -- SCPictureTableViewCellDelegate
- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onLoveButtonAction:(UIButton *)sender;
{
    sender.selected =! sender.selected;
    
}

- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onMessageButtonAction:(id)sender
{
    
}

- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onShareButtonAction:(id)sender
{

}

- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onCollectButtonAction:(id)sender
{
    
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
