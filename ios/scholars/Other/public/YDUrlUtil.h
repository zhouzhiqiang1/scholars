//
//  YDUrlUtil.h
//  yxtk
//
//  Created by Aren on 15/5/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDUrlUtil : NSObject
+(NSURL *)fullUrlFromRelativeUrl:(NSString *)aUrl;

+(NSURL *)fullUrlWithArticleID:(NSString *)anArticleID;

/*
 *  过滤特殊字符和空格
 */
+ (NSString *)urlEncodeValue:(NSString *)str;

/**
 *  从url里提取参数并转换成NSDictionary
 *
 *  @param anUrl 目标url
 *
 *  @return 提取出的参数
 */
+ (NSDictionary *)paramsFromUrl:(NSURL *)anUrl;

/**
 *  sha1加密url
 *
 *  @param anUrl 待加密url
 *
 *  @return 加密后的url
 */
+ (NSString *)securityUrlFromUrl:(NSString *)anUrl;
@end
