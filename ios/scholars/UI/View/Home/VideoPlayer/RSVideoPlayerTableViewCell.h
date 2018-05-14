//
//  RSVideoPlayerTableViewCell.h
//  scholars
//
//  Created by R_zhou on 2018/4/19.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface RSVideoPlayerTableViewCell : BaseTableViewCell
/**
 * 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

/**
 * 内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentL;

/**
 * 持续时间
 */
@property (weak, nonatomic) IBOutlet UILabel *durationL;
@end
