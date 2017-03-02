//
//  YDQrCodeViewController.m
//  yxtk
//
//  Created by zhiqiang zhou on 2017/2/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YDQrCodeViewController.h"
#import "ORQRCodeUtil.h"
#import "GSDataEngine.h"
#import "ORColorUtil.h"
#import "YDQRCodeReaderViewController.h"

@interface YDQrCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UIView *bjView;

@end

@implementation YDQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的二维码";
    
    self.bjView.layer.borderWidth = 1;
    self.bjView.layer.borderColor = [ORColor(@"#d9d9d9") CGColor];
    
    

    [self.qrCodeImageView setImage:[ORQRCodeUtil QRCodeImageFromString:@"https://www.baidu.com/"]];
    
    
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_qrCode_scan"] style:UIBarButtonItemStylePlain target:self action:@selector(onScanAction:)];
//    [rightBarItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
//    [self configNavBar];
}

- (void)configNavBar
{
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:@"icon_qrCode_scan"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onScanAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 32, 32);
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 32)];
    [rightView addSubview:btn];
    
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];

    self.navigationItem.rightBarButtonItem = settingItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)onScanAction:(id)sender
{
    NSLog(@"扫描");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LateralSpreadsMenu" bundle:nil];
    YDQRCodeReaderViewController *qrCodeReaderView = [storyboard instantiateViewControllerWithIdentifier:@"YDQRCodeReaderViewController"];
    qrCodeReaderView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:qrCodeReaderView animated:YES];
    

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
