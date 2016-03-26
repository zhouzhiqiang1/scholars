//
//  SMPUserCenterHeaderUITableViewCell.m
//  SmartMedicalPaient
//
//  Created by r_zhou on 15/12/9.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import "YDUserCenterHeaderUITableViewCell.h"
#import "ViewUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GSDataDef.h"
@interface YDUserCenterHeaderUITableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation YDUserCenterHeaderUITableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.image.layer.cornerRadius = self.image.frame.size.height/2;
    self.image.layer.masksToBounds = YES;
    
    self.sexImageView.layer.cornerRadius = self.sexImageView.frame.size.height/2;
    self.sexImageView.layer.masksToBounds = YES;


}

- (void)bindWithData:(id)aData
{
//    YDBaseUserInfo *userInfo = aData;
//    
//    [self.image sd_setImageWithURL:[NSURL URLWithString:userInfo.headImgUrl] placeholderImage:[UIImage imageNamed:@"img_paient_default.jpg"]];
//    
//    self.nameLabel.text = userInfo.realName;
//    [self.sexImageView setImage:[UIImage imageNamed:(userInfo.sex == 0)?@"icon_public_sex_male":@"icon_public_sex_female"]];
//    self.ageLabel.text = [NSString stringWithFormat:@"%lld岁",userInfo.age];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -- Action
- (IBAction)onInformationButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:onInformationButtonAction:)])  {
        [self.delegate cell:self onInformationButtonAction:sender];
    }
}

- (IBAction)onSetUpButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:onSetUpButtonAction:)])  {
        [self.delegate cell:self onSetUpButtonAction:sender];
    }
}


@end
