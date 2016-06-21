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
    self.isVideoLayout = NO;
}

- (void)configNavBar
{
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_layout_horizontal"] style:UIBarButtonItemStylePlain target:self action:@selector(onLayoutButtonAction:)];
    
    [self.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [self.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [self.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
}

- (void)onLayoutButtonAction:(UIBarButtonItem *)sender
{
    if ([sender.image isEqual:[UIImage imageNamed:@"img_layout_horizontal"]]) {
        [self.rightBarButtonItem setImage:[UIImage imageNamed:@"img_layout_rules"]];
        self.isVideoLayout = YES;
    } else {
        [self.rightBarButtonItem setImage:[UIImage imageNamed:@"img_layout_horizontal"]];
        self.isVideoLayout = NO;
    }
     [self reloadData];
    DDLogDebug(@"布局");
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
    
    //    pageController.title = @"Line";
    //    pageController.menuViewStyle = WMMenuViewStyleLine;
    //    pageController.titleSizeSelected = 15;
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

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info
{
    if ([viewController isKindOfClass:[SCWorkListViewController class]]) {
        [self configNavBar];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}


@end
