//
//  DataUtil.h
//  GlassStore
//
//  Created by noname on 15/4/11.
//  Copyright (c) 2015年 ORead. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat kFakeFetchDataDuration = 0.25;

@interface DataUtil : NSObject
/**
 *  从bundle读取假数据
 *
 *  @param aFileName json文件名
 *
 *  @return 返回解析后的object
 */
+ (NSObject *)loadFakeDataFromJsonFileName:(NSString *)aFileName;
@end
