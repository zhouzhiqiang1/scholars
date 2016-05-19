//
//  SCNewsTableViewCell.h
//  scholars
//
//  Created by r_zhou on 16/3/13.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSDataEngine.h"

@interface SCNewsTableViewCell : UITableViewCell
- (void)newsData:(SCNewsInfo *)newsInfo;
@end
