//
//  YDUrlUtil.m
//  yxtk
//
//  Created by Aren on 15/5/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "YDUrlUtil.h"
#import "GSUrlDef.h"
#import "NSURL+PercentEscape.h"
#import "GSDataEngine.h"
#import "SecurityUtil.h"

static NSString * const kYDDomain = @"m.readyidu.com";
static NSString * const kSid = @"sid";
static NSString * const kSign = @"sign";
static NSString * const kDefaultHashSeed = @"readyidu&^2016";
static NSString * const kAESKey = @"yxtk!Hex";

@implementation YDUrlUtil
+(NSURL *)fullUrlFromRelativeUrl:(NSString *)aUrl
{
    NSString *fullUrlString = [NSString stringWithFormat:@"%@/%@", GSHttpServer, aUrl];
    return [NSURL URLWithPercentEscapeString:fullUrlString];
}

+ (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
    return result;
}

+ (NSDictionary *)paramsFromUrl:(NSURL *)anUrl
{
    NSString *paramStr = [anUrl query];
    NSArray *keyValueArray = [paramStr componentsSeparatedByString:@"&"];
    if (keyValueArray.count > 0) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        for (NSString *keyValuePair in keyValueArray) {
            NSArray *array = [keyValuePair componentsSeparatedByString:@"="];
            if (array.count > 1) {
                [dict setObject:[array lastObject] forKey:[array firstObject]];
            }
        }
        return dict;
    } else {
        return nil;
    }
}


+ (NSString *)securityUrlFromUrl:(NSString *)anUrl
{
    NSRange range = [anUrl rangeOfString:kYDDomain];//判断字符串是否包含
    
    if (range.length >0) {
        NSURL *nsUrl = [NSURL URLWithString:anUrl];
        NSDictionary *param = [YDUrlUtil paramsFromUrl:nsUrl];
        NSString *sid = [param objectForKey:kSid];
        NSString *sign = [param objectForKey:kSign];
        if (sid.length > 0 && sign.length == 0) {
            NSString *encodeStr = [NSString stringWithFormat:@"%@%@%@", sid, kDefaultHashSeed, sid];
            NSString *sha1Str = [SecurityUtil sha1:[encodeStr MD5]];
            NSRange range = [anUrl rangeOfString:@"?"];
            NSString *url = nil;
            if(range.location != NSNotFound) {
                url = [anUrl stringByAppendingFormat:@"&sign=%@", sha1Str];
            } else {
                url = [anUrl stringByAppendingFormat:@"?sign=%@", sha1Str];
            }
            return url;
        }
    }
    return anUrl;
}
@end
