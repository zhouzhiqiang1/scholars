//
//  AppDelegate.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/9.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ORColorUtil.h"
#import "JPFPSStatus.h"
#import <CocoaLumberjack/CocoaLumberjack.h>//DDLog
//融云
#import <RongIMKit/RongIMKit.h>
#import "GSDataDef.h"
#import "GSDataEngine.h"

//融云 key
static NSString *RongYunKey = @"3argexb6rzkbe";

@interface AppDelegate ()<RCIMConnectionStatusDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //统一导航条样式
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:ORColor(kORColorOrange_D55403)];
    
    
    // 初始化DDLog
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:RongYunKey];
    
    /**
     * 推送处理1
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
#pragma clang diagnostic pop
    }
    
    //FPS调试
#if defined(DEBUG)||defined(_DEBUG)
    [JPFPSStatus sharedInstance].fpsLabel.textColor = [UIColor blackColor];
    [[JPFPSStatus sharedInstance] open];
#endif
    
    
    //融云即时通讯
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    //3D Touch
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        [self creatShortcutItem];
    }
    return YES;
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        
//        
//        /*
//         * 帐号在别的设备上登录 后跳转登录页面
//         */
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        UINavigationController *rootViewControler = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
//        [rootViewControler presentViewController:navController animated:YES completion:^{}];
        
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //进入前台取消应用消息图标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //进入前台取消应用消息图标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//创建应用图标上的3D touch快捷选项
- (void)creatShortcutItem {
    //创建自定义图标的icon
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"item1@3x.png"];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"item1@3x.png"];
    //创建快捷选项
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"Call" localizedTitle:@"趣味" localizedSubtitle:nil icon:icon1 userInfo:@{@"type":@(YDRedirectActionTypePicture)}];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"IWant" localizedTitle:@"聊天" localizedSubtitle:nil icon:icon2 userInfo:@{@"type":@(YDRedirectActionTypeMessage)}];
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item1, item2];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    NSDictionary *dict = shortcutItem.userInfo;
    YDRedirectActionType type = [[dict objectForKey:@"type"] integerValue];
    //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
    YDRedirectActionInfo *actionInfo = [[YDRedirectActionInfo alloc] init];
    actionInfo.actionType = type;
    actionInfo.extraInfo = nil;
    [GSDataEngine shareEngine].actionInfo = actionInfo;
    if (completionHandler) {
        completionHandler(YES);
    }
}

@end
