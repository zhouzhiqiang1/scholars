//
//  SMPUserCenterTableViewCell.m
//  SmartMedicalPaient
//
//  Created by r_zhou on 15/12/8.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import "YDUserCenterTableViewCell.h"



@interface YDUserCenterTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@end

@implementation YDUserCenterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tabelCellImageView:(NSString *)imageView cellTitle:(NSString *)title
{
    [self.image setImage:[UIImage imageNamed:imageView]];
    self.labelTitle.text = title;
}

@end
