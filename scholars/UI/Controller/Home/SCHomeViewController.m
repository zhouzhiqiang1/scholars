//
//  SCHomeViewController.m
//  scholars
//
//  Created by r_zhou on 16/3/9.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCHomeViewController.h"
#import "SCHotViewController.h"
#import "SCNewsTableViewController.h"
#import "SCWorkListViewController.h"

@interface SCHomeViewController ()
@property (strong, nonatomic) UIBarButtonItem *rightBarButtonItem;
@property (assign, nonatomic) BOOL isVideoLayout;
@end

@implementation SCHomeViewController

- (NSArray<NSString *> *)titles {
    return @[@"热门", @"新闻",@"视频", @"段子",@"你好", @"支持我", @"点赞", @"谢谢"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
//    self.preloadPolicy = 1;
    self.isVideoLayout = NO;
}

- (void)configNavBar
{
//    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_layout_horizontal"] style:UIBarButtonItemStylePlain target:self action:@selector(onLayoutButtonAction:)];
    //初始化 UIBarButtonItem
    self.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    self.rightBarButtonItem.style = UIBarButtonItemStylePlain;
    self.rightBarButtonItem.target = self;
    self.rightBarButtonItem.action = @selector(onLayoutButtonAction:);
    //判断显示的图标
    if (self.isVideoLayout) {
         [self.rightBarButtonItem setImage:[UIImage imageNamed:@"img_layout_horizontal"]];
    } else {
         [self.rightBarButtonItem setImage:[UIImage imageNamed:@"img_layout_rules"]];
    }
    [self.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [self.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [self.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
}

//首页导航栏右上角按钮事件
- (void)onLayoutButtonAction:(UIBarButtonItem *)sender
{
    if (self.isVideoLayout == NO) {
        [self.rightBarButtonItem setImage:[UIImage imageNamed:@"img_layout_horizontal"]];
        self.isVideoLayout = YES;
    } else {
        [self.rightBarButtonItem setImage:[UIImage imageNamed:@"img_layout_rules"]];
        self.isVideoLayout = NO;
    }
    [self reloadData];
    DDLogDebug(@"点击后重新布局");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WMPageController DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}


- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleColorNormal = [UIColor brownColor];
    pageController.titleColorSelected = [UIColor purpleColor];
    
    UIViewController *viewContorller = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    if (index == 0) {
        SCHotViewController *hotView = [storyboard instantiateViewControllerWithIdentifier:@"SCHotViewController"];
        viewContorller = hotView;
    } else if ([self.titles[index] isEqualToString:@"视频"]) {
        SCWorkListViewController *workListView = [storyboard instantiateViewControllerWithIdentifier:@"SCWorkListViewController"];
        workListView.isVideoLayout = self.isVideoLayout;
        viewContorller = workListView;
    } else {
        SCNewsTableViewController *hotView = [storyboard instantiateViewControllerWithIdentifier:@"SCNewsTableViewController"];
        viewContorller = hotView;
    }

    return viewContorller;
}

//类似“网易菜单栏”首次点击页面加载事件
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info
{
    //判断视频页面导航栏添加按钮
    if ([viewController isKindOfClass:[SCWorkListViewController class]]) {
        [self configNavBar];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}


@end
