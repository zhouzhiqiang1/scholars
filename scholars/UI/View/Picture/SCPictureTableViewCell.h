//
//  SCPictureTableViewCell.h
//  scholars
//
//  Created by r_zhou on 16/3/15.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCPictureTableViewCell;

@protocol SCPictureTableViewCellDelegate <NSObject>
- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onLoveButtonAction:(UIButton *)sender;
- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onMessageButtonAction:(id)sender;
- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onShareButtonAction:(id)sender;
- (void)pictureTableViewCell:(SCPictureTableViewCell *)aCell onCollectButtonAction:(id)sender;
@end



@interface SCPictureTableViewCell : UITableViewCell

@property (weak, nonatomic) id<SCPictureTableViewCellDelegate> delegate;
- (void)upData:(NSString *)image;
@end
