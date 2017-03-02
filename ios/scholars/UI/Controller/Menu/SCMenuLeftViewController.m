//
//  SCMenuLeftViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/25.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCMenuLeftViewController.h"
#import "SCMenuLeftTableViewCell.h"
#import "UIViewController+MMDrawerController.h"
#import "YDQrCodeViewController.h"

@interface SCMenuLeftViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation SCMenuLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"社区",@"社区",@"社区",@"社区",@"社区",@"社区"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏导航栏
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self.mm_drawerController  setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}

//显示信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *menuLeftIdentifier = @"SCMenuLeftTableViewCell";
    SCMenuLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuLeftIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewVC = nil;
    NSLog(@"%ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        NSLog(@"二维码点击事件");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AboutMenu" bundle:nil];
        YDQrCodeViewController *qrCodeViewController = [storyboard instantiateViewControllerWithIdentifier:@"YDQrCodeViewController"];
        viewVC = qrCodeViewController;
    }
    

    
    //拿到我们的LitterLCenterViewController，让它去push
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    if ([viewVC isMemberOfClass:[UITabBarController class]]) {
        nav.navigationBar.hidden = YES;
    } else {
        nav.navigationBar.hidden = NO;
    }
    [nav pushViewController:viewVC animated:NO];
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        //        [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    }];
}
@end
