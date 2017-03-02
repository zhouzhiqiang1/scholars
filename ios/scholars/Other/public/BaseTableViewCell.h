//
//  BaseTableViewCell.h
//  GlassStore
//
//  Created by noname on 15/4/14.
//  Copyright (c) 2015年 ORead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

- (void)bindWithData:(id)aData;
/**
 *  返回cell的高度, 子类实现
 *
 *  @return CGFloat
 */
+(CGFloat)heightForCell;

/**
 *  setSelected 不好用，自己写
 *
 *  @param isChecked 是否选中
 */
-(void)setChecked:(BOOL)isChecked;
@end
