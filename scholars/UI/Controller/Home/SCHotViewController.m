//
//  SCHotViewController.m
//  scholars
//
//  Created by r_zhou on 16/3/10.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCHotViewController.h"
#import "YDHotTableViewCell.h"
#import "WMLoopView.h"
#import "WMPageConst.h"
#import "GSImageCollectionViewController.h"
#import <MJRefresh.h>
#import "SCEncapsulation.h"
#import "ORIndicatorView.h"

@interface SCHotViewController ()<WMLoopViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSNumber *age;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) MJRefreshAutoNormalFooter *refreshFooter;
@end

@implementation SCHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.showsVerticalScrollIndicator = NO;
    
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

    
    
    self.images = @[@"http://7xk3oj.com2.z0.glb.qiniucdn.com/banner-20150908-002-1.png",
                    @"http://7xk3oj.com2.z0.glb.qiniucdn.com/20151209114207-78f389d4",
                    @"http://7xk3oj.com2.z0.glb.qiniucdn.com/20151209114210-ed2c0a1c"];
    WMLoopView *loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:self.images autoPlay:YES delay:2.0];
    loopView.timeInterval = 5;
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.tableView.rowHeight = 80;
    NSLog(@"%@", self.age);
    
    
    
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
//    self.newsTableViewModel = [[SCNewsTableViewModel alloc] init];
//    
//    [self.newsTableViewModel addObserver:self forKeyPath:kKeyPathDataSource options:NSKeyValueObservingOptionNew context:nil];
//    [self.newsTableViewModel addObserver:self forKeyPath:kKeyPathDataFetchResult options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unloadModel
{
    @try {
//        [self.newsTableViewModel removeObserver:self forKeyPath:kKeyPathDataSource];
//        [self.newsTableViewModel removeObserver:self forKeyPath:kKeyPathDataFetchResult];
//        [self setNewsTableViewModel:nil];
    }
    @catch (NSException *exception) {
    }
}

-(void)startRefresh
{
    NSLog(@"下拉刷新");
    [ORIndicatorView showLoading];
    [self stopLoadingWithSuccess:YES];
//    [self.newsTableViewModel fetchList];
}

- (void)startLoadMore
{
    NSLog(@"上拉刷新");
    [ORIndicatorView showLoading];
    [self stopLoadingWithSuccess:YES];
//    [self.newsTableViewModel fetchMore];
}

- (void)stopLoadingWithSuccess:(BOOL)aSuccess
{
    [super stopLoadingWithSuccess:aSuccess];
    [ORIndicatorView hideLoading];
//    self.tableView.mj_footer = [self.newsTableViewModel hasMore]?self.refreshFooter:nil;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- (WMLoopViewDelegate)
- (void)loopViewDidSelectedImage:(WMLoopView *)loopView index:(int)index
{
    GSImageCollectionViewController *imageVC = [GSImageCollectionViewController viewControllerWithDataSource:self.images];
    imageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageVC animated:YES];
    imageVC.defaultPageIndex = index;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
// UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
     NSString *cell = @"YDHotTableViewCell";
     YDHotTableViewCell *hotTableView = [tableView dequeueReusableCellWithIdentifier:cell forIndexPath:indexPath];
     [hotTableView loadTheData:@"imageThree.jpg" title:@"This is a project" content:@"Project data are local, welcome to watch"];
 
     return hotTableView;
 }


@end
