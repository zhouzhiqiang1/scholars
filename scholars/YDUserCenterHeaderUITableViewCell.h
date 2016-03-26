//
//  SMPUserCenterHeaderUITableViewCell.h
//  SmartMedicalPaient
//
//  Created by r_zhou on 15/12/9.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseTableViewCell.h"
@class YDUserCenterHeaderUITableViewCell;
@protocol YDUserCenterHeaderUITableViewCellDelegate <NSObject>
- (void)cell:(YDUserCenterHeaderUITableViewCell *)aCell onInformationButtonAction:(id)aSender;
- (void)cell:(YDUserCenterHeaderUITableViewCell *)aCell onSetUpButtonAction:(id)aSender;
@end

@interface YDUserCenterHeaderUITableViewCell : UITableViewCell
@property (weak, nonatomic) id <YDUserCenterHeaderUITableViewCellDelegate> delegate;
@end
