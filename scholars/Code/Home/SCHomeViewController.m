//
//  SCHomeViewController.m
//  scholars
//
//  Created by mgc1105 on 16/3/9.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import "SCHomeViewController.h"
#import "SCHotViewController.h"

@interface SCHomeViewController ()

@end

@implementation SCHomeViewController

- (NSArray<NSString *> *)titles {
    return @[@"热门", @"新闻", @"段子",@"你好", @"支持我", @"点赞"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    SCHotViewController *hotView = [sb instantiateViewControllerWithIdentifier:@"SCHotViewController"];
//    pageController.title = @"Line";
//    pageController.menuViewStyle = WMMenuViewStyleLine;
//    pageController.titleSizeSelected = 15;
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleColorNormal = [UIColor brownColor];
    pageController.titleColorSelected = [UIColor purpleColor];

    return hotView;
}


@end
