//
//  SCWorkListViewController.h
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/5/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORBaseViewController.h"

@interface SCWorkListViewController : ORBaseViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (assign, nonatomic) BOOL isVideoLayout;//yes大 no小
@end
