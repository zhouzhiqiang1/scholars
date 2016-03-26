//
//  ORHTTPRequestSerializer.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSHTTPURLRequestSerializer.h"
#import "AppUtil.h"
#import "GSUserSetting.h"
#import "SecurityUtil.h"
#import "GSHTTPTask.h"
#import "GSDataEngine.h"

@implementation GSHTTPURLRequestSerializer
+ (instancetype)serializer
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setClientInfoToHTTPHeader];
    }
    return self;
}

- (void)setClientInfoToHTTPHeader
{
    // 添加公共http头
    NSString *localVersion = [AppUtil appShortVersion];
    NSString *deviceID = [GSUserSetting stringOfKey:ORSettingsStrDeviceId];
    NSString *cipher = [GSUserSetting stringOfKey:ORSettingsStrUserCipher];
    [self setValue:@"0" forHTTPHeaderField:kKeyHttpHeaderPlatform];
    [self setValue:localVersion forHTTPHeaderField:kKeyHttpHeaderAppversion];
    
    if (deviceID.length > 0) {
        [self setValue:deviceID forHTTPHeaderField:kKeyHttpHeaderDeviceId];
    }
    
    if (cipher.length > 0) {
        [self setValue:cipher forHTTPHeaderField:kKeyHttpHeaderToken];
    }
}
@end
