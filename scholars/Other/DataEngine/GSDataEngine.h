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


@interface GSDataEngine : NSObject

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



/**
 *   趣味图片
 *  @param aResponseBlock 回调block
 *  @return task
 **/
-(GSHTTPTask *)addGetPictureFunActionTaskWithResponse:(GSTaskBlock())aResponseBlock;

/**
 *   新闻数据
 *  @param aResponseBlock 回调block
 *  @return task
 **/
-(GSHTTPTask *)addGetNewsActionTaskWithResponse:(GSTaskBlock())aResponseBlock;


/**
 *   视频数据
 *  @param aResponseBlock 回调block
 *  @return task
 **/
-(GSHTTPTask *)addGetVideoDataTaskWithResponse:(GSTaskBlock())aResponseBlock;


@end
