//
//  SCRootBarViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
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
#import "GSDataEngine.h"
#import "SCPictureTableViewController.h"
#import "SCMessageLoginViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "RSAdvertisingPackaging.h"

@interface SCRootBarViewController ()<EAIntroDelegate>
@property (strong, nonatomic) NSMutableArray *viewControlles;
@end

@implementation SCRootBarViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [[GSDataEngine shareEngine] addObserver:self forKeyPath:kKeyPathActionInfo options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[GSDataEngine shareEngine] removeObserver:self forKeyPath:kKeyPathActionInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //iOS 12.1 tabbar从二级页面返回跳动问题的解决方法
    [[UITabBar appearance] setTranslucent:NO];
    
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
    
    self.viewControlles = [NSMutableArray arrayWithArray:self.viewControllers];
    
    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UINavigationController *homeNavController = [homeStoryboard instantiateInitialViewController];
    [self.viewControlles replaceObjectAtIndex:0 withObject:homeNavController];
    
    UIStoryboard *pictureStoryboard = [UIStoryboard storyboardWithName:@"Picture" bundle:nil];
    UINavigationController *pictureNavController = [pictureStoryboard instantiateInitialViewController];
    [self.viewControlles replaceObjectAtIndex:1 withObject:pictureNavController];
    
    
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavController = [messageStoryboard instantiateInitialViewController];
    [self.viewControlles replaceObjectAtIndex:2 withObject:messageNavController];

    
    UIStoryboard *userCenterStoryboard = [UIStoryboard storyboardWithName:@"UserCenter" bundle:nil];
    UINavigationController *userCenterNavController = [userCenterStoryboard instantiateInitialViewController];
    
    [self.viewControlles replaceObjectAtIndex:3 withObject:userCenterNavController];

    [self setViewControllers:self.viewControlles];

    // 设置启动页广告
    [[RSAdvertisingPackaging advertising] setupAdvert];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
- (void)introDidFinish:(EAIntroView *)introView
{
    NSLog(@"悬浮按钮");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZLRemoveAdvertView" object:nil userInfo:nil];
}

- (void)intro:(EAIntroView *)introView pageAppeared:(EAIntroPage *)page withIndex:(NSInteger)pageIndex
{
    
}

- (void)intro:(EAIntroView *)introView pageStartScrolling:(EAIntroPage *)page withIndex:(NSInteger)pageIndex
{
    
}

- (void)intro:(EAIntroView *)introView pageEndScrolling:(EAIntroPage *)page withIndex:(NSInteger)pageIndex
{
    NSLog(@"%@ %@  %ld",introView,page,pageIndex);
    [self setViewControllers:self.viewControlles];
}

#pragma mark - TabbarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([tabBar.items indexOfObject:item] == YDTabTypeMarket) {
        
        DDLogDebug(@"1点击 YDTabTypeMarket");
    } else if ([tabBar.items indexOfObject:item] == YDTabTypeHome) {
        DDLogDebug(@"2点击 YDTabTypeHome");
    } else if ([tabBar.items indexOfObject:item] == YDTabTypeMessage) {
        DDLogDebug(@"3点击 YDTabTypeMessage");
    } else if ([tabBar.items indexOfObject:item] == YDTabTypeMine) {
        DDLogDebug(@"4点击 YDTabTypeMine");
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.isViewLoaded == NO)
    {
        return;
    }

    if ([keyPath isEqualToString:kKeyPathActionInfo]) {
        [self checkRedirectAction];
    }
}

- (void)checkRedirectAction
{
    if ([GSDataEngine shareEngine].actionInfo) {
        YDRedirectActionInfo *actionInfo = [GSDataEngine shareEngine].actionInfo;
        //        if (actionInfo.actionType != PCRedirectActionTypeChat) {
        [GSDataEngine shareEngine].actionInfo = nil;
        [self jumpToActionType:actionInfo.actionType extraData:actionInfo.extraInfo];
        //        }
    }
}

- (void)jumpToActionType:(YDRedirectActionType)aType extraData:(id)aData
{
     dismissAllPresentedController();
    
    if (aType == YDRedirectActionTypePicture) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Picture" bundle:nil];
        SCPictureTableViewController *pictureVC = [storyboard instantiateViewControllerWithIdentifier:@"SCPictureTableViewController"];
        pictureVC.needCloseButtonWhenPresent = YES;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:pictureVC];
        UIViewController *rootVC = lastPresentedController();
        [rootVC presentViewController:navController animated:YES completion:^{}];
    } else if (aType == YDRedirectActionTypeMessage) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SCMessageLoginViewController *messageVC = [storyboard instantiateViewControllerWithIdentifier:@"SCMessageLoginViewController"];
//        messageVC.hidesBottomBarWhenPushed = YES;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:messageVC];
        UIViewController *rootVC = lastPresentedController();
        [rootVC presentViewController:navController animated:YES completion:^{}];
    }
}
@end

#pragma mark - 全局
SCRootBarViewController* rootTabBarController()
{
    UINavigationController *nav = rootViewController();
    return [nav.viewControllers objectAtIndex:0];
}
