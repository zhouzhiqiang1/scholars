//
//  SCNewsTableViewCell.m
//  scholars
//
//  Created by r_zhou on 16/3/13.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCNewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface SCNewsTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation SCNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)newsData:(SCNewsInfo *)newsInfo
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:newsInfo.photos] placeholderImage:[UIImage imageNamed:@"imageOne.png"]];
    self.titleLabel.text = newsInfo.title;
    self.contentLabel.text = newsInfo.source;
}

@end
