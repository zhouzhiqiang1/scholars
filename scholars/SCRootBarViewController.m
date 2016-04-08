//
//  SCRootBarViewController.m
//  scholars
//
//  Created by r_zhou on 16/3/9.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCRootBarViewController.h"
#import <EAIntroView/EAIntroView.h>
#import "ORColorUtil.h"
#import "ORBaseViewController.h"
#import "ORBaseTableViewController.h"
#import "GSUserSetting.h"

@interface SCRootBarViewController ()<EAIntroDelegate>

@end

@implementation SCRootBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //第一次登陆
    BOOL isFirstLaunch = ![GSUserSetting boolOfKey:ORSettingsBoolEverLaunched];
    
    if (isFirstLaunch) {
        [self showIntroduceView];
        
        [GSUserSetting setBool:YES forKey:ORSettingsBoolEverLaunched];
        [GSUserSetting synchronize];
    }

    
    /**
     试图控制器中添加  storyboard 视图
     */
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, 0.5f)];
    [self.tabBar addSubview:lineView];
    
    NSMutableArray *viewControlles = [NSMutableArray arrayWithArray:self.viewControllers];
    
    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UINavigationController *homeNavController = [homeStoryboard instantiateInitialViewController];
    [viewControlles replaceObjectAtIndex:0 withObject:homeNavController];
    
    UIStoryboard *pictureStoryboard = [UIStoryboard storyboardWithName:@"Picture" bundle:nil];
    UINavigationController *pictureNavController = [pictureStoryboard instantiateInitialViewController];
    [viewControlles replaceObjectAtIndex:1 withObject:pictureNavController];

    
    UIStoryboard *userCenterStoryboard = [UIStoryboard storyboardWithName:@"UserCenter" bundle:nil];
    UINavigationController *userCenterNavController = [userCenterStoryboard instantiateInitialViewController];
    
    [viewControlles replaceObjectAtIndex:3 withObject:userCenterNavController];
    
    [self setViewControllers:viewControlles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 启动页 内部函数
- (void)showIntroduceView
{
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    for (int i = 0; i<3; i++) {
        NSString *imgName = [NSString stringWithFormat:@"wizard_%d.jpg", i+1];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imgView.image = [UIImage imageNamed:imgName];
        EAIntroPage *page = [EAIntroPage pageWithCustomView:imgView];
        [pages addObject:page];
    }
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.navigationController.view.bounds andPages:pages];
    intro.pageControl.pageIndicatorTintColor = ORColor(@"a2a2a2");
    intro.pageControl.currentPageIndicatorTintColor = ORColor(@"595959");
    intro.delegate = self;
    [intro.skipButton setTitleColor:ORColor(@"a2a2a2") forState:UIControlStateNormal];

    
    [intro showInView:self.navigationController.view animateDuration:0];
}

#pragma mark - EAIntroViewDelegate

- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSInteger)pageIndex
{
    
}

- (void)intro:(EAIntroView *)introView pageStartScrolling:(EAIntroPage *)page withIndex:(NSInteger)pageIndex
{
    
}

- (void)intro:(EAIntroView *)introView pageEndScrolling:(EAIntroPage *)page withIndex:(NSInteger)pageIndex
{
    
}

@end

#pragma mark - 全局
SCRootBarViewController* rootTabBarController()
{
    UINavigationController *nav = rootViewController();
    return [nav.viewControllers objectAtIndex:0];
}
