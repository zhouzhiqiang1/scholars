//
//  SCPictureTableViewCell.m
//  scholars
//
//  Created by r_zhou on 16/3/15.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import "SCPictureTableViewCell.h"

@interface SCPictureTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

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

- (IBAction)onLoveButtonAction:(id)sender {
}

- (IBAction)onMessageButtonAction:(id)sender {
}

- (IBAction)onCollectButtonAction:(id)sender {
}
@end
