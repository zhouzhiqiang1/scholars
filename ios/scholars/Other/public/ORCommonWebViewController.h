//
//  ORCommonWebViewController.h
//  ORead
//
//  Created by noname on 14-10-4.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORBaseViewController.h"

@interface ORCommonWebViewController : ORBaseViewController
@property (nonatomic, strong) NSString *url;
@property (assign, nonatomic) BOOL showBack;
@property (assign, nonatomic) BOOL showClose;
@property (assign, nonatomic) BOOL hideNavBarAfterBack;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) NSString *trustHost;
+(instancetype)initWithUrl:(NSString *)aUrl showClose:(BOOL)aShow;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
@end
