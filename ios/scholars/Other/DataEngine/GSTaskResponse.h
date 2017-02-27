//
//  ORTaskResponse.h
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  task状态
 */
typedef enum {
    GSTaskStatusSuccess,
    GSTaskStatusFailed,
    GSTaskStatusProcessing
}GSTaskStatus;

@interface GSTaskResponse : NSObject
@property (assign, nonatomic) GSTaskStatus status;
@property (assign, nonatomic) NSInteger errorCode;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) id object;
@property (copy, nonatomic) NSString *url;

+ (GSTaskResponse *)responseWithObject:(id)aObject;
@end




