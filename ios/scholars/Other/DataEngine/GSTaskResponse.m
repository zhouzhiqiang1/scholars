//
//  ORTaskResponse.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "GSTaskResponse.h"
#import "GSErrorDef.h"
@implementation GSTaskResponse
+ (GSTaskResponse *)responseWithObject:(id)aObject
{
    GSTaskResponse *response = [[GSTaskResponse alloc] init];
    
    if ([aObject isKindOfClass:[NSError class]])
    {
        NSError *error = (NSError *)aObject;
        [response setErrorCode:error.code];
        
        NSString *message = GSErrorSystemGetDescription(error.code);
        [response setMessage:message];
        if (message.length <=0)
        {
            [response setMessage:error.description];
        }
        
        [response setStatus:GSTaskStatusFailed];
    }
    else if ([aObject isKindOfClass:[NSOperation class]])
    {
        [response setErrorCode:0];
        [response setStatus:GSTaskStatusSuccess];
    }
    return response;
}
@end
