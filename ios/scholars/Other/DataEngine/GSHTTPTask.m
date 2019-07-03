//
//  ORHTTPTask.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSHTTPTask.h"
#import "GSTask.h"
#import "GSHTTPRequestOperationManager.h"
#import "GSHTTPURLRequestSerializer.h"
#import "GSUrlDef.h"
#import "GSErrorDef.h"
#import "GSTaskEngine.h"
#import "GSDataEngine.h"
#import "GSUserSetting.h"
//#import "Observer.h"
//#import "ORIndicatorView.h"

@implementation GSHTTPTask
- (BOOL)initRun
{
//    // 注册app
//    NSString *secretKey = [ORUserSetting stringOfKey:ORSettingsStrUrsAESKey];
//    NSString *ID = [ORUserSetting stringOfKey:ORSettingsStrUrsId];
//    
//    if (secretKey.length <=0 || ID.length <=0)
//    {
//        GSTask *registerAppTask =[[GSDataEngine shareEngine] addRegisterAppTaskWithResponse:^(GSTaskResponse *aTaskResponse) {
//            [self setOperation:nil];
//            if (aTaskResponse.status == ORTaskStatusSuccess)
//            {
//                [self run];
//            }
//            else
//            {
//                [self completeWithResponse:aTaskResponse];
//            }
//        }];
//        [registerAppTask setParentTask:self];
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
    return YES;
}

- (void)run
{
    [super run];
}

- (void)setReadFromCache:(BOOL)readFromCache
{
    _readFromCache = readFromCache;
}
@end

#pragma mark - task response

@implementation GSHTTPTaskResponse

+ (GSHTTPTaskResponse *)responseWithObject:(id)aDictionaryObject
{
    GSHTTPTaskResponse *response = [[[self class] alloc] initWithWithObject:aDictionaryObject];
    return response;
}

- (instancetype)initWithWithObject:(id)aDictionaryObject
{
    self = [super init];
    if (self)
    {
        if ([aDictionaryObject isKindOfClass:[NSDictionary class]]==NO)
        {
            return nil;
        }
        
        NSNumber *errorNumber = [aDictionaryObject objectForKey:@"errorCode"];
        NSString *message = [aDictionaryObject objectForKey:@"errorMessage"];
        NSDictionary *data = [aDictionaryObject objectForKey:@"data"];
        
        [self setErrorCode:errorNumber.integerValue];
        
        // 返回数据
        if ([data isKindOfClass:[NSNull class]]==NO)
        {
            [self setData:data];
        }
        
        // 错误描述
        [self setMessage:GSErrorGetDescription((GSErrorCode)(self.errorCode))];
        if (self.message == nil && [message isKindOfClass:[NSNull class]]==NO)
        {
            [self setMessage:message];
        }
        
        // 状态
        if (self.errorCode == GSErrorCMSuccess)
        {
            [self setStatus:GSTaskStatusSuccess];
        }
        else
        {
            [self setStatus:GSTaskStatusFailed];
            
            // 未注册， 密码错误，密码不合法，用户被冻结，
            if (self.errorCode == GSErrorCMUnRegister || self.errorCode == GSErrorCMPasswordMistake || self.errorCode == GSErrorCMPasswordIllegal || self.errorCode == GSErrorCMAccountFrozen || self.errorCode == GSErrorCMRegisterNotFinished)
            {
                [[GSTaskEngine sharedEngine].httpRequestOperationQueue cancelAllOperations];
                
//                // 如果已经登陆
//                if ([GSDataEngine shareEngine].isAnonymous == NO)
//                {
////                    [[ORDataEngine shareEngine] schedulesAfterLogoutSuccess];
////                    [LDIndicatorView showString:self.message];
//                }
            }
            // 未登录
            else if (self.errorCode == GSErrorCMUnLogin)
            {
                [[GSTaskEngine sharedEngine].httpRequestOperationQueue cancelAllOperations];
                // 如果已经登陆，自动重新登陆
//                if ([ORDataEngine shareEngine].isAnonymous == NO)
//                {
//                    [[ORDataEngine shareEngine] relogin];
//                }
            }
//            else if(self.errorCode == GSErrorCMInvalidToken){
//                if (![[GSDataEngine shareEngine] isAnonymous]) {
//                    [[GSDataEngine shareEngine] schedulesAfterLogoutSuccess];
//                    [Observer postNotificationOnMainThreadName:kNotificationUserLogout object:nil userInfo:nil];
//                    
//                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Your account login in aother place, please login again!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//                    [view show];
//                }
//            }
        }
    }
    return self;
}

+ (NSDictionary *)dictionaryOfResultString:(NSString *)aResultString
{
    NSArray *resultArray = [aResultString componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    for (NSString *result in resultArray)
    {
        NSArray *keyvalue = [result componentsSeparatedByString:@"="];
        [resultDic setObject:[keyvalue objectAtIndex:1] forKey:[keyvalue objectAtIndex:0]];
    }
    NSDictionary *data = [NSDictionary dictionaryWithDictionary:resultDic];
    
    return data;
}
@end


@implementation GSHTTPShareSinaTaskResponse

- (instancetype)initWithWithObject:(id)aDictionaryObject
{
    self = [super init];
    if (self)
    {
        if ([aDictionaryObject isKindOfClass:[NSDictionary class]]==NO)
        {
            return nil;
        }
        
        @try {
            
            NSNumber *errorNumber = [aDictionaryObject objectForKey:@"error_code"];
            [self setErrorCode:(int)errorNumber.integerValue];
            
            if (errorNumber)
            {
                [self setStatus:GSTaskStatusFailed];
                
                NSString *message = GSErrorGetDescription((GSErrorCode)(errorNumber.integerValue));
                if (message.length <= 0)
                {
                    message = [aDictionaryObject objectForKey:@"error"];
                }
                [self setMessage:message];
            }
            else
            {
                [self setStatus:GSTaskStatusSuccess];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    return self;
}

@end
