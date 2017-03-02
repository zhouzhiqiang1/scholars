//
//  YDQRCodeReaderViewController.m
//  SmartMedicalPaient
//
//  Created by r_zhou on 16/3/2.
//  Copyright © 2016年 Aren. All rights reserved.
//

#import "YDQRCodeReaderViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ORIndicatorView.h"
#import "ORCommonWebViewController.h"

#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y
#define SHeight 20

#define SWidth (XCenter+30)

@interface YDQRCodeReaderViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) IBOutlet UIView *viewPreview;
@property (nonatomic) BOOL isReading;
@property (strong, nonatomic) CALayer *scanLayer;
@property (strong, nonatomic) UIImageView * imageView;
@property (strong, nonatomic) UIImageView *line;

-(BOOL)startReading;
-(void)stopReading;
@end

@implementation YDQRCodeReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _captureSession = nil;
    _isReading = NO;
    [self startReading];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)startReading {
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    //    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    captureMetadataOutput.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    //9.将图层添加到预览view的图层上
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.05f, 0.05f, 0.8f, 0.8f);
    //    captureMetadataOutput.rectOfInterest = [self rectOfInterestByScanViewRect:self.imageView.frame];
    
    //10.1.扫描框
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((Width-SWidth)/2,(Height-SWidth)/2,SWidth,SWidth)];
    self.imageView.image = [UIImage imageNamed:@"image_qrcode_scan.png"];
    [_viewPreview addSubview:self.imageView];
    
    //10.2.扫描线
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imageView.frame)+5, CGRectGetMinY(self.imageView.frame)+5, SWidth-10,1)];
    _line.image = [UIImage imageNamed:@"scanLine.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
    
    [self setOverView];
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    //    [bringSubviewToFront
    [self.view addSubview:vi];
    [self.view bringSubviewToFront:vi];
    vi.alpha = 0.5;
    
    UIButton *butImage = [[UIButton alloc] initWithFrame:CGRectMake(10 , 25, 22, 22)];
    [butImage setBackgroundImage:[UIImage imageNamed:@"btn_nav_return.png"] forState:UIControlStateNormal];
    
    [butImage addTarget:self action:@selector(onReturnButtonAvtion:) forControlEvents:UIControlEventTouchUpInside];
    
    [vi addSubview:butImage];
    
    //文字添加
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 20, 150, 44)];
    label.text = @"二维码/条形码";
    label.textColor = [UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:15];
    [vi addSubview:label];
    
    //10.开始扫描
    [_captureSession startRunning];
    return YES;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        // 停止扫描
        [self stopReading];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            DDLogDebug(@"二维码扫描完成✅");
//            NSURL *url = [NSURL URLWithString:metadataObj.stringValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ORCommonWebViewController *webViewController = [[ORCommonWebViewController alloc] initWithNibName:@"ORCommonWebViewController" bundle:nil];
                webViewController.title = @"扫描结果";
                webViewController.url = metadataObj.stringValue;
                [self.navigationController pushViewController:webViewController animated:YES];
            });
            _isReading = NO;
        } else if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code]) {
            DDLogDebug(@"条形码扫描成功✅");
        }
    }
}

- (void)moveScanLayer:(NSTimer *)timer
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(self.imageView.frame)+5, CGRectGetMinY(self.imageView.frame)+5+2*num, SWidth-10,1);
        
        if (num ==(int)(( SWidth-10)/2)) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame =CGRectMake(CGRectGetMinX(self.imageView.frame)+5, CGRectGetMinY(self.imageView.frame)+5+2*num, SWidth-10,1);
        
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
}

#pragma mark --  扫描范围计算
- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.imageView.frame);
    CGFloat height = CGRectGetHeight(self.imageView.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
    return CGRectMake(x, y, w, h);
}

#pragma mark - 添加模糊效果
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(self.imageView.frame);
    CGFloat y = CGRectGetMinY(self.imageView.frame);
    CGFloat w = CGRectGetWidth(self.imageView.frame);
    CGFloat h = CGRectGetHeight(self.imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.5;
    UIColor *backColor = [UIColor grayColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
}

- (IBAction)onReturnButtonAvtion:(id)sender
{
    if (self.navigationController)
    {
        if (self.navigationController.viewControllers.count == 1)
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
