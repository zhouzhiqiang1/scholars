//
//  YDHotTableViewCell.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/10.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "YDHotTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface YDHotTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation YDHotTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)loadTheData:(NSString *)imgeView title:(NSString *)title content:(NSString *)content
{
//    [self.headImageView setImage:[UIImage imageNamed:imgeView]];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imgeView] placeholderImage:[UIImage imageNamed:@"imageOne.png"]];
    self.titleLabel.text = title;
    self.contentLabel.text = content;
}

@end
