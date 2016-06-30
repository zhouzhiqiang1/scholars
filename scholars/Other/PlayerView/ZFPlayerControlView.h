//
//  ZFPlayerControlView.h
//
// Copyright (c) 2016年 任子丰

#import <UIKit/UIKit.h>

@interface ZFPlayerControlView : UIView

/** 开始播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton       *startBtn;
/** 当前播放时长label */
@property (weak, nonatomic) IBOutlet UILabel        *currentTimeLabel;
/** 视频总时长label */
@property (weak, nonatomic) IBOutlet UILabel        *totalTimeLabel;
/** 缓冲进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 滑杆 */
@property (weak, nonatomic) IBOutlet UISlider       *videoSlider;
/** 全屏按钮 */
@property (weak, nonatomic) IBOutlet UIButton       *fullScreenBtn;
/** 锁定屏幕方向按钮 */
@property (weak, nonatomic) IBOutlet UIButton       *lockBtn;

/** 类方法创建 */
+ (instancetype)setupPlayerControlView;
/** 重置ControlView */
- (void)resetControlView;
@end
