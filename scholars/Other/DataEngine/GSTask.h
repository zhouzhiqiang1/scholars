//
//  ORTask.h
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSErrorDef.h"
#import "GSTaskResponse.h"
/**
 *  block define
 */
#define GSTaskBlock(blockName) void(^blockName)(GSTaskResponse *aTaskResponse)

@interface GSTask : NSObject
+ (__kindof GSTask *)task;

@property (nonatomic, strong) NSOperation *operation;
@property (nonatomic, copy) GSTaskBlock(responseBlock);
@property (nonatomic, strong) id object;
@property (nonatomic, assign) GSTask *parentTask;

- (void)run;
- (void)cancel;
- (void)completeWithError:(NSError *)aError;
- (void)completeWithResponse:(GSTaskResponse *)aTaskResponse;
@end
