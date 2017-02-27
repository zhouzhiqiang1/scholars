//
//  SCWorkListViewModel.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/6/30.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SCWorkListViewModel.h"
#import "GSDataEngine.h"

@implementation SCWorkListViewModel
- (void)asyncFetchListAtPage:(NSInteger)aPageIndex completion:(void (^)(BOOL isSuccess, NSArray *listArray,int count, int totalCount))completion
{
    [[GSDataEngine shareEngine] addGetVideoDataTaskWithResponse:^(GSTaskResponse *aTaskResponse) {
        if (aTaskResponse.errorCode == GSErrorCMSuccess) {
            NSError *error = nil;
            SCVideoDataList *videoDataList = [[SCVideoDataList alloc] initWithDictionary:aTaskResponse.data error:&error];
            if (completion)
            {
                if (videoDataList.pageSize <= 0) {
                    videoDataList.pageSize = 10;
                }
                completion(YES, videoDataList.rows, videoDataList.pageSize, videoDataList.count);
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
