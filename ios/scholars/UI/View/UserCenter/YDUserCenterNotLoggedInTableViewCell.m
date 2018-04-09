//
//  SMPUserCenterNotLoggedInTableViewCell.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 15/12/9.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import "YDUserCenterNotLoggedInTableViewCell.h"

@interface YDUserCenterNotLoggedInTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@end

@implementation YDUserCenterNotLoggedInTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.image.layer.cornerRadius = self.image.frame.size.width/2;
    self.image.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma  mark -- Action
- (IBAction)onLoginImmediatelyButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:onLoginImmediatelyButton:)])  {
        [self.delegate cell:self onLoginImmediatelyButton:sender];
    }
}

- (IBAction)onSetUpButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cell:onSetUpButton:)])  {
        [self.delegate cell:self onSetUpButton:sender];
    }
}
@end
