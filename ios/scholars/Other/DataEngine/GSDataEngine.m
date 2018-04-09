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
    
    
    NSString *string = GSHttpServer;
    
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
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlCeShi
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    //    task.useFakeData = YES;
    //    task.fakeJsonName = @"SimpleData";
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}


-(GSHTTPTask *)addGetHomePageTaskWithResponse:(GSTaskBlock())aResponseBlock
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlHomePage
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}

-(GSHTTPTask *)addGetNewsTaskWithResponse:(GSTaskBlock())aResponseBlock
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlGetNews
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}

-(GSHTTPTask *)addGetVideoTaskWithResponse:(GSTaskBlock())aResponseBlock
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlGetVideo
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}


-(GSHTTPTask *)addGetFunPhotoDataTaskWithResponse:(GSTaskBlock())aResponseBlock
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlGetFunPhoto
                                                      httpType:YDHttpTypePost
                                                        params:nil];
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}

-(GSHTTPTask *)addPhotoLoveStatusTaskWithResponse:(GSTaskBlock())aResponseBlock loveStatus:(NSInteger)loveStatus photoID:(NSInteger)photoID;
{
    ORBaseHttpTask *task = [[ORBaseHttpTask alloc] initWithUrl:GSUrlUpdatePhotoLoveStatus
                                                      httpType:YDHttpTypePost
                                                        params:@{@"lovestatus":@(loveStatus),
                                                                    @"photoID":@(photoID)}];
    [task setResponseBlock:aResponseBlock];
    [task run];
    return task;
}

@end
