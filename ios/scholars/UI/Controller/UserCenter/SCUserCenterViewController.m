//
//  SCUserCenterViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/26.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCUserCenterViewController.h"
#import "YDUserCenterTableViewCell.h"
#import "YDUserCenterNotLoggedInTableViewCell.h"
#import "YDUserCenterHeaderUITableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "RCTRootView.h"
#import "SCRootNavigationViewController.h"
#import "GSDataEngine.h"
#import "SCUserInfoViewController.h"

//例子
#import "ZZQFloatingViewController.h"

@interface SCUserCenterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
//@property (strong, nonatomic) YDUserCenterViewModel *userCenterViewModel;
@end

@implementation SCUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    
    
    self.dataSource = @[
                        @[
                            @{@"icon":@"", @"title":@""}],
                        
                        @[
                            @{@"icon":@"icon_usercenter_addpaient", @"title":@"React-Native界面"}],
                        @[
                            @{@"icon":@"icon_usercenter_appointment", @"title":@"社区界面"},
                            @{@"icon":@"icon_notification_appointment", @"title":@"我的病厉"}],
                        @[
                            @{@"icon":@"icon_usercenter_mycomment", @"title":@"我的评价"},
                            @{@"icon":@"icon_usercenter_mynotification", @"title":@"我的通知"},
                            @{@"icon":@"icon_usercenter_myqrcode", @"title":@"我的二维码"}]
                        ];
    
    MJRefreshNormalHeader *nearbyHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
    
    self.tableView.mj_header = nearbyHeader;
    nearbyHeader.lastUpdatedTimeLabel.hidden = YES;
    
    
    
//    [[GSDataEngine shareEngine] addGetNetworkDataActionTaskWithResponse:^(GSTaskResponse *aTaskResponse) {
//        if (aTaskResponse.errorCode == GSErrorCMSuccess) {
//
//        } else {
//
//        }
//    } userid:12];
//
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if (!self.navigationController.navigationBarHidden) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }
//}
//
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Model
-(void)commonInit
{
    [super commonInit];
    
//    [[GSDataEngine shareEngine] addObserver:self forKeyPath:kKeyPathUserInfo options:NSKeyValueObservingOptionNew context:nil];
//    //    [self loadModel];
//    [[GSDataEngine shareEngine] addObserver:self forKeyPath:kKeyPathLoginState options:NSKeyValueObservingOptionNew context:nil];
    //    [self loadModel];
}

- (void)dealloc
{
//    [[GSDataEngine shareEngine] removeObserver:self forKeyPath:kKeyPathUserInfo];
//    [[GSDataEngine shareEngine] removeObserver:self forKeyPath:kKeyPathLoginState];
}

- (void)loadModel
{
    [self unloadModel];
//    self.userCenterViewModel = [[YDUserCenterViewModel alloc] init];
//    
//    [self.userCenterViewModel addObserver:self forKeyPath:kKeyPathDataSource options:NSKeyValueObservingOptionNew context:nil];
//    [self.userCenterViewModel addObserver:self forKeyPath:kKeyPathDataFetchResult options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unloadModel
{
    @try {
//        [self.userCenterViewModel removeObserver:self forKeyPath:kKeyPathDataSource];
//        [self.userCenterViewModel removeObserver:self forKeyPath:kKeyPathDataFetchResult];
    }@catch (NSException *exception) {
        
    }
}

-(void)startRefresh
{
//    if ([GSDataEngine shareEngine].isAnonymous) {
//        [self.tableView reloadData];
//        [self stopLoadingWithSuccess:YES];
//    } else {
//        [ORIndicatorView showLoading];
//        [self.userCenterViewModel fetchData];
//    }
    [self stopLoadingWithSuccess:YES];
}

- (void)stopLoadingWithSuccess:(BOOL)aSuccess
{
    [super stopLoadingWithSuccess:aSuccess];
    [self.tableView.mj_header endRefreshing];
    
}


#pragma mark -- Action
////未登录状态
//- (void)cell:(YDUserCenterNotLoggedInTableViewCell *)aCell onLoginImmediatelyButton:(id)aSender
//{
//    DDLogDebug(@"登录");
//    [YDLoginViewController showLoginViewController];
//}
//
//- (void)cell:(YDUserCenterNotLoggedInTableViewCell *)aCell onSetUpButton:(id)aSender
//{
//    DDLogDebug(@"未登录设置");
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SetUp" bundle:nil];
//    YDSetUpViewController *setUpView = [storyboard instantiateViewControllerWithIdentifier:@"YDSetUpViewController"];
//    setUpView.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:setUpView animated:YES];
//}
//
////登录状态
//- (void)cell:(YDUserCenterHeaderUITableViewCell *)aCell onInformationButtonAction:(id)aSender
//{
//    DDLogDebug(@"登录个人资料");
//    YDPersonalDataTableViewController *personalDataTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"YDPersonalDataTableViewController"];
//    personalDataTableView.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:personalDataTableView animated:YES];
//}
//
//- (void)cell:(YDUserCenterHeaderUITableViewCell *)aCell onSetUpButtonAction:(id)aSender
//{
//    DDLogDebug(@"登录设置");
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SetUp" bundle:nil];
//    YDSetUpViewController *setUpView = [storyboard instantiateViewControllerWithIdentifier:@"YDSetUpViewController"];
//    setUpView.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:setUpView animated:YES];
//    
//}
//
#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.dataSource objectAtIndex:section];
    return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static  NSString *cellID = @"YDUserCenterTableViewCell";
    static  NSString *cellHeader = @"YDUserCenterHeaderUITableViewCell";
//    static  NSString *cellNotLoggedIn = @"YDUserCenterNotLoggedInTableViewCell";
    
    if (section == 0) {
//        if ([GSDataEngine shareEngine].isAnonymous) {
//            //未登录状态
//            YDUserCenterNotLoggedInTableViewCell *cellUserCenterNotLoggedIn = [tableView dequeueReusableCellWithIdentifier:cellNotLoggedIn forIndexPath:indexPath];
//            cellUserCenterNotLoggedIn.delegate = self;
//            return cellUserCenterNotLoggedIn;
//        } else {
            //登录状态
            YDUserCenterHeaderUITableViewCell *userCenterHeaderCell = [tableView dequeueReusableCellWithIdentifier:cellHeader forIndexPath:indexPath];
//            [userCenterHeaderCell bindWithData:[[GSDataEngine shareEngine] userInfo]];
//            userCenterHeaderCell.delegate = self;
            return userCenterHeaderCell;
//        }
        
    } else {
        
        NSArray *array = [self.dataSource objectAtIndex:section];
        NSDictionary *dict = [array objectAtIndex:row];
        NSString *title = [dict objectForKey:@"title"];
        NSString *imgName = [dict objectForKey:@"icon"];
        
        YDUserCenterTableViewCell *cellUserCenter= [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        
        [cellUserCenter tabelCellImageView:imgName cellTitle:title];
        return cellUserCenter;
    }
    return 0;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    return 50;
}

// section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    } if (section == 1) {
        return 0.1;
    } else {
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

//设置区域的名称
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    DDLogDebug(@"设置区域的名称");
    //    if(section == 0){
    //        return 0;
    //    }else if(section == 1){
    //        return 0;
    //    }else if(section == 2){
    //        return 0;
    //    } else if (section == 3) {
    //        return 0;
    //    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
//        NSLog(@"登陆");
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserCenter"  bundle:nil];
        SCUserInfoViewController *userinfoVC = [storyboard instantiateViewControllerWithIdentifier:@"SCUserInfoViewController"];
        userinfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userinfoVC animated:YES];
    }else if (section == 1) {
        NSLog(@"React-native");
        NSURL *jsCodeLocation = [NSURL
                                 URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
        
//        NSURL *jsCodeLocation = [NSURL
//                                 URLWithString:@"http://192.168.2.5:8081/index.ios.bundle?platform=ios"];
        RCTRootView *rootView =
        [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                             moduleName        : @"scholars"
                             initialProperties :
         @{
           @"scores" : @[
                   @{
                       @"name" : @"Alex",
                       @"value": @"42"
                       },
                   @{
                       @"name" : @"Joel",
                       @"value": @"10"
                       }
                   ]
           }
                              launchOptions    : nil];
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view = rootView;
//        [self presentViewController:vc animated:YES completion:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (section == 2) {
        if (row == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ZZQFloatingViewController" bundle:nil];
            ZZQFloatingViewController *floatingVC = [storyboard instantiateViewControllerWithIdentifier:@"ZZQFloatingViewController"];
            [self.navigationController pushViewController:floatingVC animated:YES];
        } else if (row == 1) {
          
        }
    } else if (section == 3) {
        if (row == 0) {
            
        } else if (row == 1) {
        
        } else if (row == 2) {
            
        }
    }
    
    NSLog(@"%ld %ld",(long)indexPath.section, (long)indexPath.row);
}

//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat yOffset  = scrollView.contentOffset.y;
//    if (yOffset < -kImageOriginHight) {
//        CGRect f = self.imageView.frame;
//        f.origin.y = yOffset;
//        f.size.height =  -yOffset;
//        self.imageView.frame = f;
//    }
//}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.isViewLoaded == NO)
    {
        return;
    }
//    
//    if ([keyPath isEqualToString:kKeyPathLoginState]) {
//        [self startRefresh];
//    }
//    else if ([keyPath isEqualToString:kKeyPathUserInfo]) {
//        [self.tableView reloadData];
//    }
//    else if ([keyPath isEqualToString:kKeyPathDataFetchResult]) {
//        [ORIndicatorView hideLoading];
//        GSTaskResponse *response = change[NSKeyValueChangeNewKey];
//        if (response.status == GSTaskStatusSuccess) {
//            [self stopLoadingWithSuccess:YES];
//            [self.tableView reloadData];
//        }
//        else {
//            [self stopLoadingWithSuccess:NO];
//            if (response.message.length>0) {
//                [ORIndicatorView showString:response.message];
//            }
//            else {
//                [ORIndicatorView showString:@"操作失败"];
//            }
//        }
//    }
//    else{
//        DDLogDebug(@"1231312321313");
//    }
}




//    } else if ([keyPath isEqualToString:kKeyPathLoginState]) {
//        [ORIndicatorView hideLoading];
//        GSTaskResponse *response = change[NSKeyValueChangeNewKey];
//        if (response.errorCode == GSErrorCMSuccess) {
//             [self.tableView reloadData];
//            [ORIndicatorView showString:@"成功"];
//        } else {
//            [ORIndicatorView showString:response.message];
//        }
//    }
//}
@end
