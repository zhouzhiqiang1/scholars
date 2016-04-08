//
//  ORBaseTableViewController.m
//  ORead
//
//  Created by noname on 14-8-2.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "ORBaseTableViewController.h"
#import "ORIndicatorView.h"
#import "ViewUtil.h"
#import <MJRefresh.h>
#import "ORAppUtil.h"
#import "ORColorUtil.h"
//#import "MobClick.h"//友盟统计用的

@interface ORBaseTableViewController (){
    BOOL _isBaseViewAppearred;
    BOOL _isBaseLoading;
}

@property (nonatomic, strong) UIView *failedView;
@property (nonatomic, strong) ORIndicatorView *loadingView;
@end

@implementation ORBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self commonInit];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    DDLogDebug(@"init - %@",[self class]);
    [self loadModel];
}

- (void)dealloc
{
    [self unloadModel];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.isViewLoaded)
    {
        [self.tableView setDelegate:nil];
        [self.tableView setDataSource:nil];
    }
    DDLogInfo(@"dealloc - %@",[self class]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.hidesBottomBarWhenPushed = YES;
    self.clearsSelectionOnViewWillAppear = NO;
    if (self.needPullRefesh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
        //        [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(startRefresh)];
        //        [self.tableView.header setUpdatedTimeHidden:YES];
    }
    if (self.needLoadMore) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(startLoadMore)];
        [self.tableView.mj_footer setHidden:YES];
    }
    if ([ORAppUtil systemVersion].floatValue < 7.0f)
    {
        if ([self respondsToSelector:@selector(tableView)])
        {
            [[(id)self tableView] setContentInset:UIEdgeInsetsMake(44.0f, 0.0f, 0.0f, 0.0f)];
        }
    }
    
    //修改导航栏颜色
    if ([ORAppUtil systemVersion].floatValue < 7.0f)
    {
        [self.navigationController.navigationBar setTranslucent:NO];
        [self.navigationController.navigationBar setTintColor:ORColor(kORColorOrange_D55403)];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }else{
        [self.navigationController.navigationBar setTranslucent:NO];
        [self.navigationController.navigationBar setBarTintColor:ORColor(kORColorOrange_D55403)];
    }
    
    //导航栏上字体颜色
    NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                            NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    if (self.isNavBarHide == NO)
    {
        if (self.navigationController.viewControllers.count > 1)
        {
            //导航栏左面图片
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            [backButton setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
            [backButton setBackgroundImage:[UIImage imageNamed:@"btn_nav_return"] forState:UIControlStateNormal];
            [backButton sizeToFit];
            [backButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        }
        else if (self.needCloseButtonWhenPresent)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:button];
        }
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (_isBaseViewAppearred == NO)
    {
        _isBaseViewAppearred = YES;
        
        if (self.showLoadingWhenLoadList && self.listModel)
        {
            [self showLoadingView];
            [self startLoadList];
        }
    }
    else if (_isBaseLoading)
    {
        [self showLoadingView];
    }
}

- (IBAction)onFailedViewTapped:(id)sender
{
    [self showLoadingView];
    [self startRefresh];
    
    [self.failedView removeFromSuperview];
    [self setFailedView:nil];
}

- (UIView *)getFailedView
{
    UIView *failedView = ORLoadNib(@"ORGuideLoadingFailed");
    [ViewUtil addSingleTapGestureForView:failedView target:self action:@selector(onFailedViewTapped:)];
    
    return failedView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

#pragma mark - 数据模型

- (void)loadModel
{
//    NSAssert(0, @"子类需要重写该类");
}

- (void)unloadModel
{
    if (self.listModel != nil)
    {
        NSAssert(0, @"子类需要重写该类");
    }
}

- (void)startLoadList
{
    NSAssert(0, @"子类需要重写该类");
}

#pragma mark - 刷新和加载更多
- (void)startRefresh
{
    NSAssert(0, @"需要重写函数 - (void)startRefresh");
}

- (void)startLoadMore
{
    NSAssert(0, @"需要重写函数 - (void)startLoadMore");
}

- (void)stopLoadingWithSuccess:(BOOL)aSuccess
{
    
    if (self.needPullRefesh) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.needLoadMore) {
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = ![self.listModel hasMore];
    }
    
    if (self.showLoadingWhenLoadList)
    {
        [self hideLoadindView];
        if (aSuccess== NO && self.listModel.count == 0)
        {
            if (self.failedView == nil)
            {
                UIView *failedView = [self getFailedView];
                [self setFailedView:failedView];
            }
            [self.failedView setFrame:self.view.frame];
            [self.view.superview addSubview:self.failedView];
        }else{
            [self.failedView removeFromSuperview];
            [self setFailedView:nil];
        }
    }
}

#pragma mark - loading
- (ORIndicatorView *)showLoadingView;
{
    [self hideLoadindView];
    
    _isBaseLoading = YES;
    if (self.view.superview)
    {
        return [self showLoadingViewInView:self.view.superview];
    }
    else if (self.navigationController.view)
    {
        return [self showLoadingViewInView:self.navigationController.view];
    }
    else
    {
        return [self showLoadingViewInView:self.view];
    }
    return self.loadingView;
}

- (void)hideLoadindView
{
    [self.loadingView hide:YES];
    [self setLoadingView:nil];
    
    _isBaseLoading = NO;
}

- (ORIndicatorView *)showLoadingViewInView:(UIView *)aView
{
    [self hideLoadindView];
    
    _isBaseLoading = YES;
    [self setLoadingView:[ORIndicatorView showLoadingString: NSLocalizedString(@"Loading", nil) inView:aView]];
    
    return self.loadingView;
}

#pragma mark - 按钮事件
- (IBAction)onBackButtonPressed:(id)sender
{
    if (self.navigationController)
    {
        if (self.navigationController.viewControllers.count == 1)
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}

@end
