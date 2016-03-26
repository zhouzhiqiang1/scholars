//
//  ORTaskEngine.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSTaskEngine.h"

@implementation GSTaskEngine
+ (instancetype)sharedEngine
{
    static GSTaskEngine *_sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedEngine = [[[self class] alloc] init];
        _sharedEngine.httpRequestOperationQueue = [[NSOperationQueue alloc] init];
    });
    
    return _sharedEngine;
}

@end
