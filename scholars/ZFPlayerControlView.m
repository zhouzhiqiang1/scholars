//
//  ZFPlayerControlView.m
//
// Copyright (c) 2016年 任子丰 

#import "ZFPlayerControlView.h"

@interface ZFPlayerControlView ()
/** bottom渐变层*/
@property (strong, nonatomic) CAGradientLayer *bottomGradientLayer;
/** top渐变层 */
@property (strong, nonatomic) CAGradientLayer *topGradientLayer;
/** bottomView*/
@property (weak, nonatomic  ) IBOutlet UIImageView     *bottomImageView;
/** topView */
@property (weak, nonatomic  ) IBOutlet UIImageView     *topImageView;

@end

@implementation ZFPlayerControlView

-(void)dealloc
{
    //NSLog(@"%@释放了",self.class);
}

-(void)awakeFromNib
{
    // 设置slider
    [self.videoSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    
    [self insertSubview:self.progressView belowSubview:self.videoSlider];
    self.videoSlider.minimumTrackTintColor = [UIColor whiteColor];
    self.videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6];

    self.progressView.progressTintColor    = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    self.progressView.trackTintColor       = [UIColor clearColor];
    
    // 初始化渐变层
    [self initCAGradientLayer];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomGradientLayer.frame = self.bottomImageView.bounds;
    self.topGradientLayer.frame = self.topImageView.bounds;
}

- (void)initCAGradientLayer
{
    //初始化Bottom渐变层
    self.bottomGradientLayer = [CAGradientLayer layer];
    [self.bottomImageView.layer addSublayer:self.bottomGradientLayer];
    //设置渐变颜色方向
    self.bottomGradientLayer.startPoint = CGPointMake(0, 0);
    self.bottomGradientLayer.endPoint   = CGPointMake(0, 1);
    //设定颜色组
    self.bottomGradientLayer.colors     = @[(__bridge id)[UIColor clearColor].CGColor,
                                            (__bridge id)[UIColor blackColor].CGColor];
    //设定颜色分割点
    self.bottomGradientLayer.locations  = @[@(0.0f) ,@(1.0f)];


    //初始Top化渐变层
    self.topGradientLayer               = [CAGradientLayer layer];
    [self.topImageView.layer addSublayer:self.topGradientLayer];
    //设置渐变颜色方向
    self.topGradientLayer.startPoint    = CGPointMake(1, 0);
    self.topGradientLayer.endPoint      = CGPointMake(1, 1);
    //设定颜色组
    self.topGradientLayer.colors        = @[(__bridge id)[UIColor blackColor].CGColor,
                                            (__bridge id)[UIColor clearColor].CGColor];
    //设定颜色分割点
    self.topGradientLayer.locations     = @[@(0.0f) ,@(1.0f)];

}

#pragma mark - Public Method

/** 重置ControlView */
- (void)resetControlView
{
    self.videoSlider.value = 0;
    self.progressView.progress = 0;
    self.currentTimeLabel.text = @"00:00";
    self.totalTimeLabel.text = @"00:00";
}

/** 类方法创建 */
+ (instancetype)setupPlayerControlView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ZFPlayerControlView" owner:nil options:nil].lastObject;
}

@end
