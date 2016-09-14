//
//  SCMessageLoginViewController.m
//  scholars
//
//  Created by r_zhou on 16/9/12.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SCMessageLoginViewController.h"
#import "SCMessageListViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCAnimatedImagesView.h"
#import "GSUserSetting.h"
/*
 *   用户 token
 */
static NSString *RongYunToken1 = @"s4nzNqjHgcayJ56pdjBeAByJBMXDC5tk4uk/mAGTlO0YTCs55+gjcbGwrn1A0Mvi2CJoO+LUBMdjLyvASojdkQ==";

static NSString *RongYunToken2 = @"KcNWyV4fy5vYTYNHQFDCZxyJBMXDC5tk4uk/mAGTlO0YTCs55+gjcY6a3dZ8oW5miWmbxlrY/RrlMhVvvZ6CCw==";

@interface SCMessageLoginViewController ()<RCIMUserInfoDataSource,RCIMReceiveMessageDelegate,RCAnimatedImagesViewDelegate>

// 动态界面
@property (retain, nonatomic) IBOutlet RCAnimatedImagesView* animatedImagesView;

// 提示Label
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) NSString *token;
@end

@implementation SCMessageLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通讯";
    
    
    [self.userLabel setAlpha:0.0];
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    
    // 消息接收监听器
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(onRCIMReceiveMessage:left:)
     name:RCKitDispatchMessageNotification
     object:nil];
    
    // 消息接收监听器
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(onRCIMCustomLocalNotification:withSenderName:)
     name:RCKitDispatchMessageNotification
     object:nil];
    
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    
    
    //添加动态图代理
    self.animatedImagesView.delegate = self;
    
    
    if ([GSUserSetting stringOfKey:ORSettingsStrRYToken] != nil) {
        [self login:[GSUserSetting stringOfKey:ORSettingsStrRYToken]];
    }
    
}

/*
 *  视图加载前执行方法
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开始动画
    [self.animatedImagesView startAnimating];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

/*
 *  视图结束后执行方法
 */
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //停止动画
    [self.animatedImagesView stopAnimating];
}

#pragma mark -- RCIMReceiveMessageDelegate   动画代理

- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView*)animatedImagesView
{
    return 5;
}

- (UIImage*)animatedImagesView:(RCAnimatedImagesView*)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return [UIImage imageNamed:@"login_background.png"];//图片大小: 1322 × 1096 pixels
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Action 按钮事件
- (IBAction)onOnebtnAction:(id)sender {
    self.token = RongYunToken1;
}

- (IBAction)onTowBtnAction:(id)sender {
    self.token = RongYunToken2;
}

- (IBAction)onThreeBtnAction:(id)sender {
    self.token = RongYunToken1;
}

/*
 * 登录
 */
- (IBAction)onLoginAction:(id)sender {
    
    if (self.token.length == 0) {
        [UIView animateWithDuration:1 animations:^{
            [self.userLabel setAlpha:1.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:2 animations:^{
                [self.userLabel setAlpha:0.0];
            }];
        }];
        return;
    }
    
    //登录调用
    [self login:self.token];
}

-(void)login:(NSString *)token
{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"Login successfully with userId: %@.", userId);
        //保存toKen
        if ([GSUserSetting stringOfKey:ORSettingsStrRYToken] == nil) {
            [GSUserSetting setString:self.token forKey:ORSettingsStrRYToken];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            SCMessageListViewController *messageListViewController = [[SCMessageListViewController alloc]init];
            [self.navigationController pushViewController:messageListViewController animated:YES];
        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
}

/*!
 获取用户信息
 
 @param userId                  用户ID
 @param completion              获取用户信息完成之后需要执行的Block
 @param userInfo(in completion) 该用户ID对应的用户信息
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"user1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"测试1";
        user.portraitUri = @"http://www.rongcloud.cn/docs/assets/img/logo_s.png";
        
        return completion(user);
    }else if([@"user2" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"2";
        user.name = @"测试2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }
}




/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
- (void)onRCIMReceiveMessage:(RCMessage *)message  left:(int)left
{
    NSLog(@"剩余的未接收的消息数 %@",message);
    //    [[[RCIM sharedRCIM] receiveMessageDelegate] onRCIMCustomLocalNotification:message withSenderName:@"123"];
}

/*!
 当App处于后台时，接收到消息并弹出本地通知的回调方法
 
 @param message     接收到的消息
 @param senderName  消息发送者的用户名称
 @return            当返回值为NO时，SDK会弹出默认的本地通知提示；当返回值为YES时，SDK针对此消息不再弹本地通知提示
 
 @discussion 如果您设置了IMKit消息监听之后，当App处于后台，收到消息时弹出本地通知之前，会执行此方法。
 如果App没有实现此方法，SDK会弹出默认的本地通知提示。
 流程：
 SDK接收到消息 -> App处于后台状态 -> 通过用户/群组/群名片信息提供者获取消息的用户/群组/群名片信息
 -> 用户/群组信息为空 -> 不弹出本地通知
 -> 用户/群组信息存在 -> 回调此方法准备弹出本地通知 -> App实现并返回YES        -> SDK不再弹出此消息的本地通知
 -> App未实现此方法或者返回NO -> SDK弹出默认的本地通知提示
 */
-(BOOL)onRCIMCustomLocalNotification:(RCMessage*)message  withSenderName:(NSString *)senderName
{
    NSLog(@"%@",message);
    NSLog(@"%@",senderName);
    return NO;
}



@end

