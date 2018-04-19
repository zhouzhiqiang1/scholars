//
//  SCWorkListViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/5/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SCWorkListViewController.h"
#import "SCWorkListCollectionViewCell.h"
#import <MJRefresh.h>
#import "SCWorkListViewModel.h"
#import "SCEncapsulation.h"
#import "ORIndicatorView.h"
#import "GSDataEngine.h"
//转屏
#import "RSVideoPlayerViewController.h"
#import "AppDelegate.h"



#define ApplicationDelegate   ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface SCWorkListViewController ()
@property (strong, nonatomic) MJRefreshAutoNormalFooter *refreshFooter;
@property (strong, nonatomic) SCWorkListViewModel *videoDataViewModel;
@end

@implementation SCWorkListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    self.collectionView.mj_header = header;
    [self startRefresh];

}

// 哪些页面支持自动转屏
- (BOOL)shouldAutorotate{
    
    UINavigationController *nav = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
    // MoviePlayerViewController这个页面支持自动转屏
    if ([nav.topViewController isKindOfClass:[RSVideoPlayerViewController class]]) {
        return !ApplicationDelegate.isLockScreen;  // 调用AppDelegate单例记录播放状态是否锁屏
    }
    //    else if ([nav.topViewController isKindOfClass:[ZFTableViewController class]]) {
    //        return !ApplicationDelegate.isLockScreen;
    //    }
    return NO;
}

// viewcontroller支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    UINavigationController *nav = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
    if ([nav.topViewController isKindOfClass:[RSVideoPlayerViewController class]]) { // MoviePlayerViewController这个页面支持转屏方向
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    //    else if ([nav.topViewController isKindOfClass:[ZFTableViewController class]]) {
    //        if (ApplicationDelegate.isAllowLandscape) {
    //            return UIInterfaceOrientationMaskAllButUpsideDown;
    //        }else {
    //            return UIInterfaceOrientationMaskPortrait;
    //        }
    //    }
    else { // 其他页面支持转屏方向
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskPortrait;
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
    self.collectionView.mj_footer = [self.videoDataViewModel hasMore]?self.refreshFooter:nil;
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}


#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.videoDataViewModel.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger row = indexPath.row;
    static NSString *tribalCellIdentifier = @"SCWorkListCollectionViewCell";
    
    SCWorkListCollectionViewCell *workListCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:tribalCellIdentifier forIndexPath:indexPath];
    SCVideoDataInfo *videoDataInfo = [self.videoDataViewModel objectAtIndex:indexPath.row];
    [workListCollectionViewCell upData:videoDataInfo];
    
    return workListCollectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isVideoLayout) {
        return CGSizeMake(self.view.frame.size.width / 2 - 10, self.view.frame.size.width / 2);
    } else {
        return CGSizeMake(self.view.frame.size.width, 200);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{   if (_isVideoLayout) {
    return UIEdgeInsetsMake(5, 5, 5, 5);
    } else {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsZero;
}


//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//定义每个UICollectionView 横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDLogDebug(@"%ld",(long)indexPath.row);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    RSVideoPlayerViewController *movie = [storyboard instantiateViewControllerWithIdentifier:@"RSVideoPlayerViewController"];
    SCVideoDataInfo *videoDataInfo = [self.videoDataViewModel objectAtIndex:indexPath.row];
    NSURL *videoURL = [NSURL URLWithString:videoDataInfo.vediourl];
    movie.videoURL = videoURL;
    [self.navigationController pushViewController:movie animated:YES];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.isViewLoaded == NO)
    {
        return;
    }
    
    if ([keyPath isEqualToString:kKeyPathDataSource]) {
        [self.collectionView reloadData];
    } else if ([keyPath isEqualToString:kKeyPathDataFetchResult]) {
        [self stopLoadingWithSuccess:YES];
        
    }
}


@end
