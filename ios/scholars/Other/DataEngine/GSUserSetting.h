//
//  ORUserSetting.h
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString * const ORSettingsStrDeviceId = @"ORSettingsStrDeviceID";   // urs id
static NSString * const ORSettingsStrUserCipher = @"ORSettingsStrUserCipher";  // LDSettingsStrUrsAESKey加密过的token
static NSString * const ORSettingsBoolEverLaunched = @"ORSettingsBoolEverLaunched";    // 以前是否启动过，即“是否非首次登录”

/** 融云token */
static NSString * const ORSettingsStrRYToken = @"ORSettingsStrRYToken";

@interface GSUserSetting : NSObject


//判断是否第一次登陆
+ (BOOL)boolOfKey:(NSString *)aKey;
//第一次登陆后传值   aBool  YES     forKey "字符串" 遍于下一次比较
+ (void)setBool:(BOOL)aBool forKey:(NSString *)aKey;

//同步
+ (void)synchronize;




+ (NSString *)stringOfKey:(NSString *)aKey;
+ (void)setString:(NSString *)aString forKey:(NSString *)aKey;



+ (NSNumber *)numberOfKey:(NSString *)aKey;
+ (void)setNumber:(NSNumber *)aNumber forKey:(NSString *)aKey;

+ (NSDictionary *)dictionaryOfKey:(NSString *)aKey;
+ (void)setDictionary:(NSDictionary *)aDictionary forKey:(NSString *)aKey;

+ (NSData *)dataOfKey:(NSString *)aKey;
+ (void)setData:(NSData *)aData forKey:(NSString *)aKey;

+ (NSDictionary *)dictionaryFromPListFile:(NSString *)aPListFile;


+ (void)removeObjectForKey:(NSString *)aKey;

/*
 * 删除指定的aKey
 */
+ (void)deleteData:(NSString *)aKey;
/*
 * 删除全部
 */
+ (void)deleteData;
@end
