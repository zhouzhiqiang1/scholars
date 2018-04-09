//
//  SCHomePageViewModel.m
//  scholars
//
//  Created by R_zhou on 2018/2/28.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "SCHomePageViewModel.h"
#import "GSDataEngine.h"

@implementation SCHomePageViewModel
- (void)fetchList
{
    [[GSDataEngine shareEngine] addGetHomePageTaskWithResponse:^(GSTaskResponse *aTaskResponse) {
        if (aTaskResponse.errorCode == GSErrorCMSuccess) {
            NSError *error = nil;
            RSHomePageList *homePageList = [[RSHomePageList alloc] initWithDictionary:aTaskResponse.data error:&error];
          
            NSMutableArray *headUrlArray = [[NSMutableArray alloc] init];
            for (int i = 0 ; i < homePageList.headUrlList.count; i++) {
                SCHomePageInfo *headUrlList = homePageList.headUrlList[i];
                [headUrlArray addObject:headUrlList.imageUrl];
            }
            self.headUrlList = headUrlArray;
            
            [self setArray:homePageList.homePageList];
        } else {
            
        }
        self.dataFetchResult = aTaskResponse;
    }];
}
@end
