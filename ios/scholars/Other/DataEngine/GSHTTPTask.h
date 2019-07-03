//
//  ORHTTPTask.h
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSTask.h"
#import "GSTaskResponse.h"
#import "GSUrlDef.h"

@interface GSHTTPTask : GSTask
- (void)run;
- (BOOL)initRun;

@property (nonatomic, assign) BOOL readFromCache;
@end

/**
 *  HTTP response 结构
 */
@interface GSHTTPTaskResponse : GSTaskResponse

+ (GSHTTPTaskResponse *)responseWithObject:(id)aDictionaryObject;
- (instancetype)initWithWithObject:(id)aDictionaryObject;
+ (NSDictionary *)dictionaryOfResultString:(NSString *)aResultString;
@end


@interface GSHTTPShareSinaTaskResponse : GSHTTPTaskResponse

- (instancetype)initWithWithObject:(id)aDictionaryObject;

@end
