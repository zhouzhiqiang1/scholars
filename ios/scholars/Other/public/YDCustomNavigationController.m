//
//  YDCustomNavitationController.m
//  yxtk
//
//  Created by Aren on 15/6/18.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "YDCustomNavigationController.h"
#import "ORAppUtil.h"
#import "ORColorUtil.h"
#import "SCRootNavigationViewController.h"

@interface YDCustomNavigationController ()
<UIGestureRecognizerDelegate,
UINavigationControllerDelegate>

@end

@implementation YDCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([ORAppUtil systemVersion].floatValue < 7.0f)
    {
        [self.navigationBar setTranslucent:NO];
//        [self.navigationBar setTintColor:ORColor(kORColorGreen_51D6DB)];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }else{
        [self.navigationBar setTranslucent:NO];
        [self.navigationBar setBarTintColor:ORColor(@"ffffff")];
    }
    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
    
//    __weak typeof (self) weakSelf = self;
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = weakSelf;
//        self.delegate = weakSelf;
//    }
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    [super setNavigationBarHidden:hidden animated:YES];
}

- (BOOL)getNavigationBarHidden
{
    return super.navigationBarHidden;
}
- (void)commonInit
{
    //    YDRootTabBarViewController* rootTabBarVC = rootTabBarController();
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // fix 'nested pop animation can result in corrupted navigation bar'
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
