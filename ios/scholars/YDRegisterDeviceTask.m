//
//  YDRegisterDeviceTask.m
//  yxtk
//
//  Created by Aren on 15/6/4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "YDRegisterDeviceTask.h"
#import "ORAppUtil.h"
#import "UIDevice+IdentifierAddition.h"
#import "GSDataEngine.h"
#import "GSUserSetting.h"
#import "SecurityUtil.h"
#import "DataUtil.h"
#import "YDUrlUtil.h"
#import "YXHttpClient.h"

@implementation YDRegisterDeviceTask

- (void)run
{
    if (self.useFakeData) {
        [self doFakeRegisterDevice];
    } else {
        [self doRegisterDevice];
    }
}

- (void)doFakeRegisterDevice
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kFakeFetchDataDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *fakeDict = (NSDictionary *)[DataUtil loadFakeDataFromJsonFileName:@"registerDevice"];
        GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:fakeDict];
        GSErrorCode errorCode = (GSErrorCode)response.errorCode;
        
        if(errorCode == GSErrorCMSuccess)
        {
            NSDictionary *data = response.data;
            NSString *deviceId = [data objectForKey:@"deviceid"];
            NSString *encodedAeskey = [data objectForKey:@"aeskey"];
//            NSString *aeskey = [SecurityUtil aesDecryptUrs:encodedAeskey key:kPublicAESKey];
            
            [GSUserSetting setString:deviceId forKey:ORSettingsStrDeviceId];
            [GSUserSetting setString:encodedAeskey forKey:ORSettingsStrUrsAESKey];
            [GSUserSetting setBool:NO forKey:ORSettingsBoolNeedUrsRegister];
            [GSUserSetting synchronize];
        }
        
        [self completeWithResponse:response];
    });
}

- (void)doRegisterDevice
{
    NSString *bundeId = [ORAppUtil bundleId];
    NSString *shortVersion = [ORAppUtil appShortVersion];
    NSString *uuid = [UIDevice uniqueDeviceIdentifier];
    NSString *deviceType = [ORAppUtil deviceType];
    NSString *systemName = [ORAppUtil systemName];
    NSString *systemVersion = [ORAppUtil systemVersion];
    NSString *resolution = [ORAppUtil resolution];
    NSString *language = [ORAppUtil currentLanguage];
    NSDictionary *param =  [NSDictionary dictionaryWithObjectsAndKeys:
                            bundeId, @"bundleId",
                            shortVersion, @"sysVersion",
                            uuid, @"deviceId",
                            deviceType, @"deviceType",
                            systemName, @"sysName",
                            systemVersion, @"sysVersion",
                            resolution, @"resolution",
                            language, @"language",
                            @"znxy",@"appName",
                            nil];
    
    NSMutableString *fullParamString = [[NSMutableString alloc] init];
    
    for (NSString *key in param) {
        NSString *value = [param objectForKey:key];
        NSString *itemString = [NSString stringWithFormat:@"%@=%@", key, value];
        if (fullParamString.length == 0) {
            [fullParamString appendString:itemString];
        } else {
            [fullParamString appendFormat:@"&%@", itemString];
        }
    }
    
    NSString *encodedFullParamString = [SecurityUtil aesEncryptUrs:fullParamString key:kPublicAESKey];
    NSDictionary *encodeParam = @{@"deviceKey":encodedFullParamString};
    
    NSString *url = [YDUrlUtil directUrlForUrlString:GSUrlRegisterDevice];
    [[YXHttpClient sharedClient] performRequestWithUrl:url httpMethod:YXHttpTypePost param:encodeParam success:^(NSURLSessionDataTask *task, id responseObject) {
        GSHTTPTaskResponse *response = [GSHTTPTaskResponse responseWithObject:responseObject];
        GSErrorCode errorCode = (GSErrorCode)response.errorCode;
        
        if(errorCode == GSErrorCMSuccess)
        {
            NSDictionary *data = response.data;
            NSString *deviceId = [data objectForKey:@"deviceKey"];
            NSString *encodedAeskey = [data objectForKey:@"aesKey"];
            NSString *publicAeskey = [GSDataEngine shareEngine].config.aesMD5Key;
            if (publicAeskey.length == 0) {
                publicAeskey = kPublicAESKey;
            }
            NSString *aeskey = [SecurityUtil aesDecryptUrs:encodedAeskey key:publicAeskey];
            
            [GSUserSetting setString:deviceId forKey:ORSettingsStrDeviceId];
            [GSUserSetting setString:aeskey forKey:ORSettingsStrUrsAESKey];
            [GSUserSetting setBool:NO forKey:ORSettingsBoolNeedUrsRegister];
            [GSUserSetting synchronize];
        }
        
        [self completeWithResponse:response];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self completeWithError:error];
    }];
}

@end
