//
//  VideoPlayerCell+Configure.m
//  scholars
//
//  Created by R_zhou on 2018/4/19.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "VideoPlayerCell+Configure.h"
#import "GSDataDef.h"
#import <UIImageView+WebCache.h>

@implementation RSVideoPlayerTableViewCell (Configure)

- (void)configureCellWithModel:(id)model
{
    SCVideoDataInfo *videoDataInfo = (SCVideoDataInfo *)model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:videoDataInfo.photos] placeholderImage:[UIImage imageNamed:@"loading_bgView"]];
    self.contentL.text = videoDataInfo.title;
    self.durationL.text = videoDataInfo.duration;
}
@end
