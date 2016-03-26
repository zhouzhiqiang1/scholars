//
//  ORTask.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSTask.h"

@implementation GSTask
+ (GSTask *)task
{
//    DDLogVerbose(@"alloc %@",NSStringFromClass([self class]));
    return [[[self class] alloc] init];
}

- (void)run
{
    
}

- (void)cancel
{
    [self.operation cancel];
}

- (void)completeWithError:(NSError *)aError
{
    if (aError == nil)
    {
        aError = [NSError errorWithDomain:GSHTTPErrorDomain code:0 userInfo:nil];
    }
    
    GSTaskResponse *response = [GSTaskResponse responseWithObject:aError];
    [self completeWithResponse:response];
}

- (void)completeWithResponse:(GSTaskResponse *)aTaskResponse
{
    [aTaskResponse setObject:self.object];
    if (self.responseBlock)
    {
        self.responseBlock(aTaskResponse);
    }
    [self setOperation:nil];
}

- (void)dealloc
{
//    DDLogVerbose(@"dealloc %@",NSStringFromClass([self class]));
}

- (void)setOperation:(NSOperation *)operation
{
    _operation = operation;
    if (self.parentTask) {
        [self.parentTask setOperation:operation];
    }
}

- (void)setParentTask:(GSTask *)parentTask
{
    _parentTask = parentTask;
    [parentTask setOperation:self.operation];
}

@end
