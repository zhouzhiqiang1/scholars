//
//  SCRootNavigationViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/9.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCRootNavigationViewController.h"
#import "SCRootBarViewController.h"
#import "SCMenuLeftViewController.h"

#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "SCRootBarViewController.h"
#import "SCMenuLeftViewController.h"

//缩放比例
static CGFloat scaleF = 0;
//手势滑动的速度系数
static CGFloat speedF = 0.5;

@interface SCRootNavigationViewController ()
@property (strong, nonatomic) SCRootBarViewController *rootBarView;
@property (strong, nonatomic) SCMenuLeftViewController *leftView;
@property (strong, nonatomic) MMDrawerController *drawerController;
@end

@implementation SCRootNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarHidden = YES;//隐藏系统导航栏

//    //初始化中心视图
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SCRootBarViewController *rootBarVC = [storyboard instantiateViewControllerWithIdentifier:@"SCRootBarViewController"];
//    
//    //初始化左视图
//    UIStoryboard *storyboards = [UIStoryboard storyboardWithName:@"AboutMenu" bundle:nil];
//    SCMenuLeftViewController * menuLeftVC = [storyboards instantiateViewControllerWithIdentifier:@"SCMenuLeftViewController"];
//    
//    UINavigationController * centerNvaVC = [[UINavigationController alloc] initWithRootViewController:rootBarVC];
//    UINavigationController * boutiqueNC = [[UINavigationController alloc] initWithRootViewController:menuLeftVC];
//    
//    //初始化抽屉视图控制器
//    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNvaVC leftDrawerViewController:boutiqueNC];
//    
//    [self.drawerController setShowsShadow:NO];
//    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
//    //设置抽屉的宽度
//    [self.drawerController setMaximumLeftDrawerWidth:[UIScreen mainScreen].bounds.size.width - 100];
//    //
//    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//    
//    [self setViewControllers:@[self.drawerController]];
}


//-------------------------------------------用于参考-代码实现抽屉-------------------------------------------
//
//    //绑定具体的菜单
//    UIStoryboard *storyboardLeftView = [UIStoryboard storyboardWithName:@"AboutMenu" bundle:nil];
//    self.leftView = [storyboardLeftView instantiateViewControllerWithIdentifier:@"SCMenuLeftViewController"];
//    [self.view addSubview:self.leftView.view];
//
//
//    UIStoryboard *storyboardRootBarView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    self.rootBarView = [storyboardRootBarView instantiateViewControllerWithIdentifier:@"SCRootBarViewController"];
//    [self.view addSubview:self.rootBarView.view];
//
//
//    //Pan 拖动手势
//    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragGestureEvents:)];
//    [self.rootBarView.view addGestureRecognizer:pan];
//
//
//    //Tap 点击手势
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureClickEvent:)];
//    tap.numberOfTapsRequired = 1;
//
//    tap.cancelsTouchesInView = NO;/*YES 手势遮挡了 */
//    [self.rootBarView.view addGestureRecognizer:tap];
//
//    //设置隐藏和显示
//    self.leftView.view.hidden = YES;
//    self.rootBarView.view.hidden = NO;
- (void)dragGestureEvents:(UIPanGestureRecognizer *)pan
{
    //1.判断方向
    CGPoint point = [pan translationInView:self.view];
    
    scaleF = point.x + speedF + scaleF;
    
    if (pan.view.frame.origin.x >= 0) {
        //显示左面菜单
        //计算当前菜单的显示中心点位置
        CGFloat x = pan.view.center.x + point.x + speedF;
        pan.view.center = CGPointMake(x, pan.view.center.y);
        
        //计算缩放比例
        //得到一个滑动偏移量的百分比
        CGFloat sx = 1 - scaleF / 1000;
        CGFloat sy = 1 - scaleF / 1000;
        //CGAffineTransformScale 收缩
        //CGAffineTransformTranslate  平移
        pan.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, sx, sy);
        
        //还原手势
        [pan setTranslation:CGPointZero inView:self.view];
        
        //显示对应的菜单
        self.leftView.view.hidden = NO;
        
    } else if (pan.view.frame.origin.x <= 0) {
        scaleF = 0;
    }
//    else {
//        //显示右面菜单
//        //计算当前菜单的显示中心点位置
//        CGFloat x = pan.view.center.x + point.x + speedF;
//        pan.view.center = CGPointMake(x, pan.view.center.y);
//        
//        //计算缩放比例
//        //得到一个滑动偏移量的百分比
//        CGFloat sx = 1 + scaleF / 1000;
//        CGFloat sy = 1 + scaleF / 1000;
//        pan.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, sx, sy);
//        
//        //还原手势
//        [pan setTranslation:CGPointZero inView:self.view];
//        
//        //显示对应的菜单
//        self.leftView.view.hidden = YES;
//    }
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //手势结束
        //滑动偏移量
        //定义偏移量范围: 160
        CGFloat offsetX = speedF + 160;
        if (scaleF > offsetX) {
            //显示左边菜单
            [self showMenuLeftVC];
        } else  if (scaleF < -offsetX) {
            //显示右边菜单
//            [self showMenuRightVC];
            [self showRootBarVC];
        } else {
            //显示主菜单
            [self showRootBarVC];

        }
    }
}

//左面菜单显示
- (void)showMenuLeftVC
{
    //自定义组件中常用到
    [UIView beginAnimations:nil context:nil];
    
    self.rootBarView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);//1 缩放比例
    
    self.rootBarView.view.center = CGPointMake(360 + 100, self.view.bounds.size.height/2);
    
    //执行动画
    [UIView commitAnimations];
}

//中间菜单显示
- (void)showRootBarVC
{
    //自定义组件中常用到
    [UIView beginAnimations:nil context:nil];
    
    self.rootBarView.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    self.rootBarView.view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    //执行动画
    [UIView commitAnimations];
    
    //当我们手指离开屏幕的时候还原偏移量
    scaleF = 0;
}



//手势点击事件还原主菜单
- (void)gestureClickEvent:(UIPanGestureRecognizer *)pan
{
    //判断手势弹起
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self showRootBarVC];
        scaleF = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
