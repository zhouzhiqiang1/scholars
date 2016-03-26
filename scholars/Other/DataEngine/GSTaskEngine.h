//
//  ORTaskEngine.h
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSTaskEngine : NSObject
+ (instancetype)sharedEngine;

@property (nonatomic, strong) NSOperationQueue *httpRequestOperationQueue;

@end
