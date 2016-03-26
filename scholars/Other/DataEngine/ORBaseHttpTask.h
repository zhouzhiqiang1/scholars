//
//  ORBaseHttpTask.h
//  yxtk
//
//  Created by Aren on 15/5/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSHTTPTask.h"
#import "GSDataDef.h"
@interface ORBaseHttpTask : GSHTTPTask
@property (readonly, nonatomic) YDHttpType httpType;
@property (readonly, nonatomic) NSString *url;
@property (readonly, nonatomic) NSDictionary *params;
@property (assign, nonatomic) BOOL useFakeData;
@property (assign, nonatomic) NSString *fakeJsonName;
-(instancetype)initWithUrl:(NSString *)aUrl httpType:(YDHttpType)aHttpType params:(NSDictionary *)aParams;


@end
