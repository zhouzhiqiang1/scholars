//
//  SCPictureTableViewCell.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/3/15.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCPictureTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ViewUtil.h"

@interface SCPictureTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation SCPictureTableViewCell

+ (CGFloat)sizeForCellWithData:(SCPictureInfo *)pictureInfo tableViewWidth:(CGFloat)aWidth
{
    CGFloat height = 0;
    
    if (pictureInfo.content.length > 0) {
        CGFloat width = aWidth - 20;
        CGRect stringRect = [pictureInfo.content boundingRectWithSize:CGSizeMake(width, 300)
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15] }
                                                             context:nil];
        CGSize stringSize = CGRectIntegral(stringRect).size;
        height += 400 + stringSize.height;
    } else {
        height += 400;
    }
    return height;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
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


- (void)dataLoad:(SCPictureInfo *)pictureInfo
{
//    [self.imageview sd_setImageWithURL:[ViewUtil scaledUrlFromOriginalUrl:pictureInfo.photos size:self.imageview.frame.size] placeholderImage:[UIImage imageNamed:@"imageOne.png"]];
    
    self.pictureInfo = pictureInfo;
    
    self.contentLabel.text = pictureInfo.content;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:pictureInfo.photos] placeholderImage:[UIImage imageNamed:@"imageOne.png"]];
    
    [self updateLikeButton];
}


- (void)updateLikeButton
{
    self.loveButton.selected = self.pictureInfo.lovestatus;
    
    [self.loveButton setTitle:[NSString stringWithFormat:@"%ld", (long)self.pictureInfo.lovecount] forState:UIControlStateNormal];
    
    [self.messageButton setTitle:[NSString stringWithFormat:@"%ld", (long)self.pictureInfo.messagenumber] forState:UIControlStateNormal];
    
}

@end
