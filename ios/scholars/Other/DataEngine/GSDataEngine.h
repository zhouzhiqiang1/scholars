//
//  GSDataEngine.h
//  dataModel
//
//  Created by r_zhou on 15/11/27.
//  Copyright © 2015年 r_zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSDataDef.h"
#import "GSHTTPTask.h"

#pragma mark - HTTPHeader Key
static NSString * const kKeyHttpHeaderPlatform = @"platform";
static NSString * const kKeyHttpHeaderAppversion = @"appversion";
static NSString * const kKeyHttpHeaderDeviceId = @"deviceid";
static NSString * const kKeyHttpHeaderToken = @"token";

// 3D Touch
static NSString * const kKeyPathActionInfo = @"actionInfo";

@interface GSDataEngine : NSObject

@property (strong, nonatomic) YDRedirectActionInfo *actionInfo;

+ (instancetype)shareEngine;

/**
 *  当前网络状态是否可达
 *
 *  @return 网络可达返回YES，否则返回NO
 */
- (BOOL)isReachable;

/**
 *  本地 NSString 信息获取
 */
-(GSHTTPTask *)addGetLocalDataActionTaskWithResponse:(GSTaskBlock())aResponseBlock userid:(long long)userid;

/**
 *  网络 rews 信息获取
 */
-(GSHTTPTask *)addGetNetworkDataActionTaskWithResponse:(GSTaskBlock())aResponseBlock userid:(long long)userid;




#pragma mark -- 首页
/**
 *   首页热门数据
 *  @param aResponseBlock 回调block
 *  @return task
 **/
-(GSHTTPTask *)addGetHomePageTaskWithResponse:(GSTaskBlock())aResponseBlock;

/**
 *   首页新闻数据
 *  @param aResponseBlock 回调block
 *  @return task
 **/
-(GSHTTPTask *)addGetNewsTaskWithResponse:(GSTaskBlock())aResponseBlock;

/**
 *   首页视频数据
 *  @param aResponseBlock 回调block
 *  @return task
 **/
-(GSHTTPTask *)addGetVideoTaskWithResponse:(GSTaskBlock())aResponseBlock;

/**
 *   趣味图片
 *  @param aResponseBlock 回调block
 *  @return task
 **/
-(GSHTTPTask *)addGetFunPhotoDataTaskWithResponse:(GSTaskBlock())aResponseBlock;

/**
 *   趣味图片
 *  @param aResponseBlock 回调block
 *  @param loveStatus     1喜欢/0不喜欢
 *  @param photoID        id
 *  @return task
 **/
-(GSHTTPTask *)addPhotoLoveStatusTaskWithResponse:(GSTaskBlock())aResponseBlock loveStatus:(NSInteger)loveStatus photoID:(NSInteger)photoID;

@end
