//
//  BaseModel.h
//  SeasonsConstellation
//
//  Created by noname on 15/4/6.
//  Copyright (c) 2015年 ORead. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString * const kKeyPathDataFetchResult = @"dataFetchResult";

@interface BaseModel : NSObject
@property (nonatomic, strong) id dataFetchResult;

/**
 *  从服务器获取数据
 */
-(void)fetchData;
@end
