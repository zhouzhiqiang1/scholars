//
//  SCPictureTableViewCell.m
//  scholars
//
//  Created by r_zhou on 16/3/15.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import "SCPictureTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ViewUtil.h"

@interface SCPictureTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@end

@implementation SCPictureTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.view.layer.cornerRadius = 15;
    self.view.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onLoveButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pictureTableViewCell:onLoveButtonAction:)]) {
        [self.delegate pictureTableViewCell:self onLoveButtonAction:sender];
    }
}



- (IBAction)onMessageButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(pictureTableViewCell:onMessageButtonAction:)]) {
        [self.delegate pictureTableViewCell:self onMessageButtonAction:sender];
    }
}


- (IBAction)onShareButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(pictureTableViewCell:onShareButtonAction:)]) {
        [self.delegate pictureTableViewCell:self onShareButtonAction:sender];
    }
}


- (IBAction)onCollectButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(pictureTableViewCell:onCollectButtonAction:)]) {
        [self.delegate pictureTableViewCell:self onCollectButtonAction:sender];
    }
}


- (void)dataLoad:(SCPictureInfo *)pictureInfo;
{
//    [self.imageview sd_setImageWithURL:[ViewUtil scaledUrlFromOriginalUrl:pictureInfo.photos size:self.imageview.frame.size] placeholderImage:[UIImage imageNamed:@"imageOne.png"]];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:pictureInfo.photos] placeholderImage:[UIImage imageNamed:@"imageOne.png"]];
}


@end
