//
//  GSDataEngine.m
//  dataModel
//
//  Created by r_zhou on 15/11/27.
//  Copyright © 2015年 r_zhou. All rights reserved.
//

#import "GSDataEngine.h"
#import "Observer.h"
//#import "AppUtil.h"
#import "GSUserSetting.h"
#import "ORBaseHttpTask.h"
#import "GSUrlDef.h"
@implementation GSDataEngine

+ (instancetype)shareEngine
{
    static GSDataEngine *_sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedEngine = [[[self class] alloc] init];
        
        // 监听网络变化
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [Observer postNotificationOnMainThreadName:kORNetworkStatusChanged object:nil userInfo:nil];
        }];
    });
    return _sharedEngine;
}


- (BOOL)isReachable
{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable;
}


#pragma mark -- 本地数据(网络数据简单获取)
-(GSHTTPTask *)addGetLocalDataActionTaskWithResponse:(GSTaskBlock())aResponseBlock userid:(long long)userid
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlOtherUserInfo
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    task.useFakeData = YES;
    task.fakeJsonName = @"SimpleData";
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}

#pragma mark -- 本地数据(网络数据简单获取)
-(GSHTTPTask *)addGetNetworkDataActionTaskWithResponse:(GSTaskBlock())aResponseBlock userid:(long long)userid
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlOtherUserInfo
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    //    task.useFakeData = YES;
    //    task.fakeJsonName = @"SimpleData";
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}


-(GSHTTPTask *)addGetPictureFunActionTaskWithResponse:(GSTaskBlock())aResponseBlock
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlFalseDataInfo
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    task.useFakeData = YES;
    task.fakeJsonName = @"Photo";
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}


-(GSHTTPTask *)addGetNewsActionTaskWithResponse:(GSTaskBlock())aResponseBlock
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlFalseDataInfo
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    task.useFakeData = YES;
    task.fakeJsonName = @"News";
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}
@end
