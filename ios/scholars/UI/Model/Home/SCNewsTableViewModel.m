//
//  SCNewsViewModel.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/5/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SCNewsTableViewModel.h"
#import "GSDataEngine.h"

@implementation SCNewsTableViewModel

- (void)asyncFetchListAtPage:(NSInteger)aPageIndex completion:(void (^)(BOOL isSuccess, NSArray *listArray,int count, int totalCount))completion
{
    [[GSDataEngine shareEngine] addGetNewsActionTaskWithResponse:^(GSTaskResponse *aTaskResponse) {
        if (aTaskResponse.errorCode == GSErrorCMSuccess) {
            NSError *error = nil;
            SCNewsList *newsList = [[SCNewsList alloc] initWithDictionary:aTaskResponse.data error:&error];
            if (completion)
            {
                if (newsList.pageSize <= 0) {
                    newsList.pageSize = 10;
                }
                completion(YES, newsList.rows, newsList.pageSize, newsList.count);
            }

        } else {
            if (completion) {
                completion(NO, nil, 0, 0);
            }
        }
        self.dataFetchResult = aTaskResponse;
    }];
}

@end
