//
//  ORBaseTableViewController.h
//  ORead
//
//  Created by noname on 14-8-2.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORBaseListModel.h"
@class ORIndicatorView;
@interface ORBaseTableViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) ORBaseListModel *listModel;
#pragma mark - 下拉刷新
@property (nonatomic, assign) BOOL needPullRefesh;
@property (nonatomic, assign) BOOL needLoadMore;
@property (assign, nonatomic) BOOL isNavBarHide;
@property (assign, nonatomic) BOOL needCloseButtonWhenPresent;
@property (assign, nonatomic) BOOL showLoadingWhenLoadList;

#pragma mark - 子类需要重写的类
- (void)commonInit;
// 加载数据模型
- (void)loadModel;
// 卸载数据模型
- (void)unloadModel;
// 加载数据
- (void)startLoadList;
- (void)startRefresh;
- (void)startLoadMore;
- (ORIndicatorView *)showLoadingView;
- (void)hideLoadindView;
- (void)stopLoadingWithSuccess:(BOOL)aSuccess;

#pragma mark - 按钮事件
- (IBAction)onBackButtonPressed:(id)sender;

@end
