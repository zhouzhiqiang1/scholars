//
//  ORBaseHttpTask.m
//  yxtk
//
//  Created by r_zhou on 15/5/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ORBaseHttpTask.h"
#import "GSDataEngine.h"
#import "DataUtil.h"
#import "SecurityUtil.h"
#import "YXHttpClient.h"

@interface ORBaseHttpTask()
@property (nonatomic, assign) YDHttpType httpType;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *fakeJsonFileName;
@end

@implementation ORBaseHttpTask
-(instancetype)initWithUrl:(NSString *)aUrl httpType:(YDHttpType)aHttpType params:(NSDictionary *)aParams
{
    if ((self = [super init]) != nil )
    {
        _httpType = aHttpType;
//        NSString *host = [GSDataEngine shareEngine].currentConfigHost;
//        if ([host rangeOfString:GSHttpServer].location == NSNotFound) {//不包含
//            NSString *url = [aUrl substringFromIndex:GSHttpServer.length];
//            _url = [NSString stringWithFormat:@"%@%@",[GSDataEngine shareEngine].currentConfigHost,url];
//        } else {//包含
            _url = aUrl;
//        }
        _params = aParams;
    }
    return self;
}

- (void)run
{
    if (self.useFakeData) {
        [self doRunFake];
    } else {
        [self doRun];
    }
}

- (void)doRunFake
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kFakeFetchDataDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *fakeDict = (NSDictionary *)[DataUtil loadFakeDataFromJsonFileName:self.fakeJsonName];
        GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:fakeDict];
        GSErrorCode errorCode = (GSErrorCode)response.errorCode;
        
        if(errorCode == GSErrorCMSuccess)
        {
        }
        
        [self completeWithResponse:response];
    });
}

- (void)doRun
{
    NSAssert(self.url!=nil, @"url must be non-nil! syntax.");
    if (self.httpType == YDHttpTypeGet) {
        [[YXHttpClient sharedClient] performRequestWithUrl:self.url httpMethod:YXHttpTypeGet param:self.params success:^(NSURLSessionDataTask *task, id responseObject) {
            GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:responseObject];
            response.url = self.url;
            GSErrorCode errorCode = (GSErrorCode)response.errorCode;
            if(errorCode == GSErrorCMSuccess)
            {
                
            }
            [self completeWithResponse:response];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self completeWithError:error];
        }];
    } else if (self.httpType == YDHttpTypePost){
        NSMutableDictionary *postParam = [[NSMutableDictionary alloc] init];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSString *dictKey in self.params) {
            id value = [self.params objectForKey:dictKey];
            if ([value isKindOfClass:[UIImage class]]) {
                [dataArray addObject:value];
            }else if([value isKindOfClass:[NSData class]]){
                //                [mulitData setObject:value forKey:dictKey];
                [dataArray addObject:value];
            }else{
                [postParam setObject:value forKey:dictKey];
            }
        }
        
        if (dataArray.count>0) {
            [[YXHttpClient sharedClient] performUploadRequestWithUrl:self.url files:dataArray parameters:postParam
                                                            progress:^(NSProgress *uploadProgress) {
                                                                
                                                            } success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                
                                                                if (!self.readFromCache) {
                                                                }
                                                                GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:responseObject];
                                                                response.url = self.url;
                                                                GSErrorCode errorCode = (GSErrorCode)response.errorCode;
                                                                
                                                                if(errorCode == GSErrorCMSuccess)
                                                                {
                                                                    
                                                                }
                                                                [self completeWithResponse:response];
                                                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                [self completeWithError:error];
                                                            }];
        } else {
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
            [request setValue:[NSString stringWithFormat:@"%d", self.readFromCache] forHTTPHeaderField:kURLRequestHeaderIdReadFromCache];
            if (self.readFromCache) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSCachedURLResponse *urlResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (urlResponse) {
                            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:urlResponse.data options:kNilOptions error:nil];
                            GSHTTPTaskResponse *taskResponse = [GSHTTPTaskResponse responseWithObject:jsonObject];
                            taskResponse.url = self.url;
                            [self completeWithResponse:taskResponse];
                        } else {
                            GSHTTPTaskResponse *taskResponse = [[GSHTTPTaskResponse alloc] init];
                            taskResponse.url = self.url;
                            taskResponse.errorCode = 500;
                            taskResponse.message = @"数据加载失败";
                            [self completeWithResponse:taskResponse];
                        }
                    });
                });
            } else {
                
                [[YXHttpClient sharedClient] performRequestWithUrl:self.url httpMethod:YXHttpTypePost param:postParam success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    NSLog(@"~~~~~~%@",responseObject);
                    
                    if (!self.readFromCache) {
                    }
                    GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:responseObject];
                    response.url = self.url;
                    GSErrorCode errorCode = (GSErrorCode)response.errorCode;
                    
                    if(errorCode == GSErrorCMSuccess)
                    {
                        
                    }
                    
                    [self completeWithResponse:response];
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                    [self completeWithError:error];
                }];
            }
        }
    }
}

@end
