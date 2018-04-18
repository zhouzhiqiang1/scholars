//
//  ORBaseHttpTask.m
//  yxtk
//
//  Created by Aren on 15/5/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ORBaseHttpTask.h"
#import "GSDataEngine.h"
#import "DataUtil.h"
#import "SecurityUtil.h"
#import "AFHTTPSessionManager.h"

@interface ORBaseHttpTask()
@property (nonatomic, assign) YDHttpType httpType;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *fakeJsonFileName;
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@end

@implementation ORBaseHttpTask
-(instancetype)initWithUrl:(NSString *)aUrl httpType:(YDHttpType)aHttpType params:(NSDictionary *)aParams
{
    if( (self = [super init]) != nil )
    {
        _httpType = aHttpType;
        _url = aUrl;
        _params = aParams;
        _sessionManager = [AFHTTPSessionManager manager];
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
     [self.sessionManager.requestSerializer setTimeoutInterval:5];
    NSLog(@"%@",self.url);
    GSHTTPRequestOperationManager *manager = [GSHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    AFHTTPRequestOperation *operation = nil;
    if (self.httpType == YDHttpTypeGet) {
        NSLog(@"%@",self.url);
        operation = [manager GET:self.url parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:operation.responseObject];
            response.url = self.url;
            GSErrorCode errorCode = (GSErrorCode)response.errorCode;
            
            if(errorCode == GSErrorCMSuccess)
            {
                
            }
            
            [self completeWithResponse:response];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self completeWithError:error];
        }];
    }else if(self.httpType == YDHttpTypePost){
        
        //        BOOL hasBinary = NO;
        //        for (NSString *dictKey in self.params) {
        //            id value = [self.params objectForKey:dictKey];
        //            if ([value isKindOfClass:[UIImage class]]) {
        //                hasBinary = YES;
        //
        //                break;
        //            }
        //        }
        
        NSMutableDictionary *postParam = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *mulitData = [[NSMutableDictionary alloc] init];
        
        for (NSString *dictKey in self.params) {
            id value = [self.params objectForKey:dictKey];
            if ([value isKindOfClass:[UIImage class]]) {
                [mulitData setObject:value forKey:dictKey];
            }else if([value isKindOfClass:[NSData class]]){
                [mulitData setObject:value forKey:dictKey];
            }else{
                [postParam setObject:value forKey:dictKey];
            }
        }
        
        if (mulitData.count>0) {
            NSMutableURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:self.url relativeToURL:manager.baseURL] absoluteString] parameters:postParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *dictKey in mulitData) {
                    id value = [self.params objectForKey:dictKey];
                    if ([value isKindOfClass:[UIImage class]]) {
                        
                        NSData *imageData = UIImagePNGRepresentation(value);
                        [formData appendPartWithFileData:imageData
                                                    name:dictKey
                                                fileName:[NSString stringWithFormat:@"%@.png", dictKey]
                                                mimeType:@"image/png"];
                    }else if([value isKindOfClass:[NSData class]]){
                        
                    }
                }
                
            } error:nil];
            operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
                GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:operation.responseObject];
                [self completeWithResponse:response];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self completeWithError:error];
            }];
            [manager.operationQueue addOperation:operation];
            
        }else{
            NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:self.url parameters:postParam error:nil];
            [request setValue:[NSString stringWithFormat:@"%d", self.readFromCache] forHTTPHeaderField:kURLRequestHeaderIdReadFromCache];
//            DDLogDebug(@"readFromCache: %d", self.readFromCache);
            if (self.readFromCache) {
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     NSCachedURLResponse *urlResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if (urlResponse) {
                             NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:urlResponse.data options:kNilOptions error:nil];
                             GSHTTPTaskResponse *taskResponse = [GSHTTPTaskResponse responseWithObject:jsonObject];
                             [self completeWithResponse:taskResponse];
                         } else {
                             GSHTTPTaskResponse *taskResponse = [[GSHTTPTaskResponse alloc] init];
                             taskResponse.errorCode = 500;
                             taskResponse.message = @"数据加载失败";
                             [self completeWithResponse:taskResponse];
                         }
                     });
                 });
            } else {
                operation = [manager POST:self.url parameters:postParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    if (!self.readFromCache) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:operation.response data:operation.responseData];
                            [[NSURLCache sharedURLCache] storeCachedResponse:cachedResponse forRequest:operation.request];
                        });
                    }
                    
                    GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:operation.responseObject];
                    GSErrorCode errorCode = (GSErrorCode)response.errorCode;
                    
                    if(errorCode == GSErrorCMSuccess)
                    {
                    }
                    
                    [self completeWithResponse:response];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self completeWithError:error];
                }];
            }
        }
    }
    
    [self setOperation:operation];
}

@end
