//
//  YDNetworkStatusMonitor.h
//  yxtk
//
//  Created by Aren on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDNetworkStatusMonitor : NSObject
@property (readonly, nonatomic) NSString *currentNetworkStatus;
+ (instancetype)sharedInstance;

@end
