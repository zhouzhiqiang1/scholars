//
//  YDHotTableViewCell.m
//  scholars
//
//  Created by r_zhou on 16/3/10.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "YDHotTableViewCell.h"

@interface YDHotTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation YDHotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)loadTheData:(NSString *)imgeView title:(NSString *)title content:(NSString *)content
{
    [self.headImageView setImage:[UIImage imageNamed:imgeView]];
    self.titleLabel.text = title;
    self.contentLabel.text = content;
}

@end
