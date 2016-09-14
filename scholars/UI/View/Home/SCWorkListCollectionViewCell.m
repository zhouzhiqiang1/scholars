//
//  SCWorkListCollectionViewCell.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/5/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SCWorkListCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SCWorkListCollectionViewCell

- (void)upData:(SCVideoDataInfo *)videoDataInfo
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:videoDataInfo.photos] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];
    self.titleLabel.text = videoDataInfo.title;
    
}

@end
