//
//  RSAdvertisingView.h
//  scholars
//
//  Created by R_zhou on 2018/4/9.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"imageThree";
static NSString *const adUrl = @"adUrl";

@interface RSAdvertisingView : UIView

/**
 *  显示广告页面方法
 */
- (void)show;

/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *filePath;

@end
