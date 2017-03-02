//
//  ORCommonWebViewController.m
//  ORead
//
//  Created by noname on 14-10-4.
//  Copyright (c) 2014年 oread. All rights reserved.
// 

#import "ORCommonWebViewController.h"
#import "ORAppUtil.h"
#import "ORColorUtil.h"
#import "NSURL+PercentEscape.h"
#import "YDUrlUtil.h"
#import "SecurityUtil.h"

static NSString * const kYDDomain = @"m.readyidu.com";
static NSString * const kSid = @"sid";
static NSString * const kDefaultHashSeed = @"readyidu&^2016";
static NSString * const kAESKey = @"yxtk!Hex";

@interface ORCommonWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ORCommonWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

+(instancetype)initWithUrl:(NSString *)aUrl showClose:(BOOL)aShow
{
    ORCommonWebViewController *cwvc = [[ORCommonWebViewController alloc] initWithNibName:@"ORCommonWebViewController" bundle:nil];
    cwvc.url = aUrl;
    cwvc.showClose = aShow;
    return cwvc;
}

BOOL _authenticated;
NSURLRequest *_failedRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addSecurity];
    if (self.showClose) {
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        //    [rightBtn setImage:[UIImage imageNamed:@"icon_set"] forState:UIControlStateNormal];
//        [rightBtn setTitle:NSLocalizedString(@"Close", nil) forState:UIControlStateNormal];
//        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(onCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightBtnItem;
    }

    if (self.showBack) {
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
//        [leftBtn setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
//        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [leftBtn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(onBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftBtnItem;
    }
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scrollView.showsHorizontalScrollIndicator = YES;
//    NSString *newUrl = [YDUrlUtil directUrlForUrlString:self.url];
//    NSURL *oriUrl = [NSURL URLWithString:self.url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithPercentEscapeString:self.url]];
    [self.webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addSecurity
{
    self.url = [YDUrlUtil securityUrlFromUrl:self.url];
}

#pragma mark - Action
- (IBAction)onTestButtonAction:(id)sender {
    DDLogDebug(@"onTestButtonAction");
}

- (IBAction)onBackButtonAction:(id)sender {
    if (self.hideNavBarAfterBack) {
        [self.navigationController setNavigationBarHidden:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onCloseAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Webview Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL result = _authenticated;
    if (!_authenticated) {
        _failedRequest = request;
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [urlConnection start];
    }
    return result;
}

#pragma NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURL* baseURL = [NSURL URLWithString:self.trustHost];
        if ([challenge.protectionSpace.host isEqualToString:baseURL.host]) {
            NSLog(@"trusting connection to host %@", challenge.protectionSpace.host);
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        } else
            NSLog(@"Not trusting connection to host %@", challenge.protectionSpace.host);
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)pResponse {
    _authenticated = YES;
    [connection cancel];
    [self.webView loadRequest:_failedRequest];
}
@end
