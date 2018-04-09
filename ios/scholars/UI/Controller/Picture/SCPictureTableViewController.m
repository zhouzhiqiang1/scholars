//
//  SCPictureTableViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
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
#import "SCEncapsulation.h"
#import "GSImageCollectionViewController.h"
#import "ViewUtil.h"

@interface SCPictureTableViewController ()<SCPictureTableViewCellDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MJRefreshAutoNormalFooter *refreshFooter;
@property (strong, nonatomic) SCPictureViewModel *pictureViewModel;
@end

@implementation SCPictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"部落";
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCPictureInfo *pictureInfo = [self.pictureViewModel objectAtIndex:indexPath.row];
    GSImageCollectionViewController *imageVC = [GSImageCollectionViewController viewControllerWithDataSource:pictureInfo.photosArray];
    imageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageVC animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 400;
    SCPictureInfo *pictureInfo = [self.pictureViewModel objectAtIndex:indexPath.row];
    return [SCPictureTableViewCell sizeForCellWithData:pictureInfo tableViewWidth:[ViewUtil screenWidth]];
}

#pragma mark -- SCPictureTableViewCellDelegate
- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onLoveButtonAction:(UIButton *)sender;
{
    DDLogDebug(@"点赞");
    
//    aCell.pictureInfo.lovestatus = !aCell.pictureInfo.lovestatus;
//    aCell.pictureInfo.lovecount +=  !aCell.pictureInfo.lovestatus?1:-1;
//    [aCell updateLikeButton];
    
    [[GSDataEngine shareEngine] addPhotoLoveStatusTaskWithResponse:^(GSTaskResponse *aTaskResponse) {
        if (aTaskResponse.errorCode == GSErrorCMSuccess) {
            
            UIButton *btn = sender;
            sender.selected =! sender.selected;
            //点赞动画
            btn.imageView.hidden = YES;
            UIImageView *imageView = [[UIImageView alloc] init];
            UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
            CGRect rect = [keyWindow convertRect:btn.imageView.frame fromView:btn.imageView.superview];
            imageView.frame = rect;
            imageView.image = [UIImage imageNamed:@"picture_like_highlight"];
            [keyWindow addSubview:imageView];
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DScale(transform, 2.0, 2.0, 1.0f);
            self.view.userInteractionEnabled = NO;
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                imageView.layer.transform = transform;
                imageView.alpha = 0.4;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    imageView.layer.transform = CATransform3DIdentity;
                    imageView.alpha = 1;
                } completion:^(BOOL finished) {
                    [imageView removeFromSuperview];
                    btn.imageView.hidden = NO;
                    self.view.userInteractionEnabled = YES;
                }];
            }];
            [self startRefresh];
        } else {
            
        }
    } loveStatus:!aCell.pictureInfo.lovestatus photoID:aCell.pictureInfo.photoID];
}

- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onMessageButtonAction:(id)sender
{
     DDLogDebug(@"聊天");
}

- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onShareButtonAction:(id)sender
{
    DDLogDebug(@"分享");
}

- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onCollectButtonAction:(id)sender
{
    DDLogDebug(@"屏蔽");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:aCell ];
    [ORIndicatorView showLoading];
    [self.pictureViewModel removeObjectAtIndex:indexPath.row];
    [ORIndicatorView hideLoading];
}



#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.isViewLoaded == NO)
    {
        return;
    }
    if ([keyPath isEqualToString:kKeyPathDataSource]) {
        NSIndexSet          *set = change[NSKeyValueChangeIndexesKey];
        NSKeyValueChange    valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        switch (valueChange) {
            case NSKeyValueChangeInsertion:
            {
                NSMutableArray *indexes = [NSMutableArray array];
                [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                    [indexes addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
                }];
                //                [self.tableView insertItemsAtIndexPaths:indexes];
                [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }
                break;
                
            case NSKeyValueChangeRemoval:
            {
                NSMutableArray *indexes = [NSMutableArray array];
                [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                    [indexes addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
                    
                }];
                //                [self.tableView deleteItemsAtIndexPaths:indexes];
                [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
                
            case NSKeyValueChangeReplacement:
            {
                NSMutableArray *indexes = [NSMutableArray array];
                
                [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                    [indexes addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
                    
                }];
                //                [self.tableView reloadItemsAtIndexPaths:indexes];
                [self.tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
                
            case NSKeyValueChangeSetting:
            {
                [self.tableView reloadData];
            }
                break;
            default:
                break;
        }
    } else if ([keyPath isEqualToString:kKeyPathDataSource]) {
        [self.tableView reloadData];
    } else if ([keyPath isEqualToString:kKeyPathDataFetchResult]) {
        [self stopLoadingWithSuccess:YES];
    }
}


@end
