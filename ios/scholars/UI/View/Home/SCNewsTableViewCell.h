//
//  SCNewsTableViewCell.h
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/13.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSDataEngine.h"
#import <MGSwipeTableCell.h>

@interface SCNewsTableViewCell : MGSwipeTableCell
- (void)newsData:(SCNewsInfo *)newsInfo;
@end
