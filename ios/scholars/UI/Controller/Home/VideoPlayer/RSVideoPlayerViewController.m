//
//  AppDelegate.m
//  videoPlayer
//
//  Created by r_zhou on 16/5/25.
//  Copyright © 2016年 r_zhous. All rights reserved.
//

#import "RSVideoPlayerViewController.h"
#import "ZFPlayerView.h"
#import "RSDataSource.h"
#import <MJRefresh.h>
#import "SCWorkListViewModel.h"
#import "SCEncapsulation.h"
#import "ORIndicatorView.h"
#import "GSDataDef.h"

@interface RSVideoPlayerViewController ()
@property (weak, nonatomic) IBOutlet ZFPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet RSDataSource *dataSource;

@property (strong, nonatomic) MJRefreshAutoNormalFooter *refreshFooter;
@property (strong, nonatomic) SCWorkListViewModel *videoDataViewModel;
@end

@implementation RSVideoPlayerViewController

-(void)dealloc
{
    NSLog(@"%@释放了",self.class);
    [self.playerView cancelAutoFadeOutControlBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
#endif
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //跳转多个页面关闭视频
    [self.playerView resetPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    //if use Masonry,Please open this annotation
    //代码创建
    /*
     self.playerView = [ZFPlayerView setupZFPlayer];
     [self.view addSubview:self.playerView];
     [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
     }];
    */
    //storyboard创建
    self.playerView.videoURL     = self.videoURL;
    __weak typeof(self) weakSelf = self;
    self.playerView.goBackBlock  = ^{
        if (weakSelf.navigationController.viewControllers.count > 2) {
            //跳转多个页面 直接返回视频列表页
            self.tabBarController.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    
    //UITableView
    _dataSource.cellIdentifier = @"RSVideoPlayerTableViewCell";
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
    self.videoDataViewModel = [[SCWorkListViewModel alloc] init];
    
    [self.videoDataViewModel addObserver:self forKeyPath:kKeyPathDataSource options:NSKeyValueObservingOptionNew context:nil];
    [self.videoDataViewModel addObserver:self forKeyPath:kKeyPathDataFetchResult options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unloadModel
{
    @try {
        [self.videoDataViewModel removeObserver:self forKeyPath:kKeyPathDataSource];
        [self.videoDataViewModel removeObserver:self forKeyPath:kKeyPathDataFetchResult];
        [self setVideoDataViewModel:nil];
    }
    @catch (NSException *exception) {
    }
}

-(void)startRefresh
{
    NSLog(@"下拉刷新");
    [ORIndicatorView showLoadingInView:self.view];
    [self.videoDataViewModel fetchList];
}

- (void)startLoadMore
{
    NSLog(@"上拉刷新");
    [ORIndicatorView showLoadingInView:self.view];
    [self.videoDataViewModel fetchMore];
}

- (void)stopLoadingWithSuccess:(BOOL)aSuccess
{
    [super stopLoadingWithSuccess:aSuccess];
    [ORIndicatorView hideAllInView:self.view];
    self.tableView.mj_footer = [self.videoDataViewModel hasMore]?self.refreshFooter:nil;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - RSTableDelegate 实现
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SCVideoDataInfo *videoDataInfo =  [self.dataSource modelsAtIndexPath:indexPath];
    RSVideoPlayerViewController *movie = [self.storyboard instantiateViewControllerWithIdentifier:@"RSVideoPlayerViewController"];
    NSURL *videoURL = [NSURL URLWithString:videoDataInfo.vediourl];
    movie.videoURL = videoURL;
    [self.navigationController pushViewController:movie animated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.isViewLoaded == NO)
    {
        return;
    }
    
    if ([keyPath isEqualToString:kKeyPathDataSource]) {
        [_dataSource addModels:self.videoDataViewModel];
        _dataSource.cellConfigureBefore = ^(id cell, id model, NSIndexPath *indexPath) {
            
        };
        [self.tableView reloadData];
    } else if ([keyPath isEqualToString:kKeyPathDataFetchResult]) {
        [self stopLoadingWithSuccess:YES];
        
    }
}

@end
