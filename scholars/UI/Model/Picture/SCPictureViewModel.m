//
//  SCPictureViewModel.m
//  scholars
//
//  Created by r_zhou on 16/3/26.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCPictureViewModel.h"
#import "GSDataEngine.h"

@implementation SCPictureViewModel
- (void)asyncFetchListAtPage:(NSInteger)aPageIndex completion:(void (^)(BOOL isSuccess, NSArray *listArray,int count, int totalCount))completion
{
    [[GSDataEngine shareEngine] addGetPictureFunActionTaskWithResponse:^(GSTaskResponse *aTaskResponse) {
        
        if (aTaskResponse.errorCode == GSErrorCMSuccess) {
            NSError *error = nil;
            SCPictureList *pictureList = [[SCPictureList alloc] initWithDictionary:aTaskResponse.data error:&error];
            if (completion)
            {
                if (pictureList.pageSize <= 0) {
                    pictureList.pageSize = 10;
                }
                completion(YES, pictureList.rows, pictureList.pageSize, pictureList.count);
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
