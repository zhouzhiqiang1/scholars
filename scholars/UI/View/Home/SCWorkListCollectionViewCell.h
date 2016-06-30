//
//  SCWorkListCollectionViewCell.h
//  scholars
//
//  Created by r_zhou on 16/5/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSDataDef.h"

@interface SCWorkListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playerBtn;

- (void)upData:(SCVideoDataInfo *)videoDataInfo;
@end
