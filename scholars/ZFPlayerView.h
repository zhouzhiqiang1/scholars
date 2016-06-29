//
//  ZFPlayerView.h
//
// Copyright (c) 2016年 任子丰


#import <UIKit/UIKit.h>

typedef void(^ZFPlayerGoBackBlock)(void);

@interface ZFPlayerView : UIView

/** 视频URL */
@property (nonatomic, strong) NSURL               *videoURL;
/** 返回按钮Block */
@property (nonatomic, copy  ) ZFPlayerGoBackBlock goBackBlock;
/** palyer加到tableView */
@property (nonatomic, strong) UITableView         *tableView;
/** player所在cell的indexPath */
@property (nonatomic, strong) NSIndexPath         *indexPath;
/** ViewController中页面是否消失 */
@property (nonatomic, assign) BOOL                viewDisappear;
/** 是否在cell上播放video */
@property (nonatomic, assign) BOOL                isCellVideo;

/**
 *  取消延时隐藏controlView的方法,在ViewController的delloc方法中调用
 *  用于解决：刚打开视频播放器，就关闭该页面，maskView的延时隐藏还未执行。
 */
- (void)cancelAutoFadeOutControlBar;

/**
 *  类方法创建，该方法适用于代码创建View
 *
 *  @return ZFPlayer
 */
+ (instancetype)setupZFPlayer;
/**
 *  单例，用于列表cell上多个视频
 *
 *  @return ZFPlayer
 */
+ (instancetype)playerView;

/**
 *  player添加到cell上
 *
 *  @param cell 添加player的cell
 */
- (void)addPlayerToCell:(UITableViewCell *)cell;

/**
 *  重置player
 */
- (void)resetPlayer;
/** 
 *  播放
 */
- (void)play;
/** 
  * 暂停 
 */
- (void)pause;

/**
 *  用于cell上播放player
 *
 *  @param videoURL  视频的URL
 *  @param tableView tableView
 *  @param indexPath indexPath 
 */
- (void)setVideoURL:(NSURL *)videoURL withTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath;

@end
