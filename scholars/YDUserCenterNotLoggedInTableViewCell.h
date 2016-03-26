//
//  SMPUserCenterNotLoggedInTableViewCell.h
//  SmartMedicalPaient
//
//  Created by r_zhou on 15/12/9.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDUserCenterNotLoggedInTableViewCell;
@protocol YDUserCenterNotLoggedInTableViewCellDelegate <NSObject>
- (void)cell:(YDUserCenterNotLoggedInTableViewCell *)aCell onLoginImmediatelyButton:(id)aSender;
- (void)cell:(YDUserCenterNotLoggedInTableViewCell *)aCell onSetUpButton:(id)aSender;
@end

@interface YDUserCenterNotLoggedInTableViewCell : UITableViewCell
@property (weak, nonatomic) id <YDUserCenterNotLoggedInTableViewCellDelegate> delegate;
@end
