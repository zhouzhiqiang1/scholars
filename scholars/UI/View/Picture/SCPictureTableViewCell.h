//
//  SCPictureTableViewCell.h
//  scholars
//
//  Created by r_zhou on 16/3/15.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCPictureTableViewCell;

@interface SCPictureTableViewCellDelegate <NSObject>
- (void)cell:(SCPictureTableViewCell *)aCell;
@end



@interface SCPictureTableViewCell : UITableViewCell

@end
