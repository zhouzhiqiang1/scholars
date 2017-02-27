//
//  SCRootBarViewController.h
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/9.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  tabbar第几项
 */
typedef NS_OPTIONS(NSInteger, YDTabType){
    /** 集市 */
    YDTabTypeMarket,
    /** 首页 */
    YDTabTypeHome,
    YDTabTypeCenter,
    /** 消息 */
    YDTabTypeMessage,
    /** 我 */
    YDTabTypeMine,
};

@interface SCRootBarViewController : UITabBarController

@end

SCRootBarViewController* rootTabBarController();
