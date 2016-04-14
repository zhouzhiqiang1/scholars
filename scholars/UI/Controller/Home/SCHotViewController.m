//
//  SCHotViewController.m
//  scholars
//
//  Created by r_zhou on 16/3/10.
//  Copyright © 2016年 Mac Zhou. All rights reserved.
//

#import "SCHotViewController.h"
#import "YDHotTableViewCell.h"
#import "WMLoopView.h"
#import "WMPageConst.h"
#import "GSImageCollectionViewController.h"

@interface SCHotViewController ()<WMLoopViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSNumber *age;
@property (strong, nonatomic) NSArray *images;
@end

@implementation SCHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.images = @[@"http://7xk3oj.com2.z0.glb.qiniucdn.com/20151209114206-dc74f317",
                    @"http://7xk3oj.com2.z0.glb.qiniucdn.com/20151209114207-78f389d4",
                    @"http://7xk3oj.com2.z0.glb.qiniucdn.com/20151209114210-ed2c0a1c"];
    WMLoopView *loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:self.images autoPlay:YES delay:2.0];
    loopView.timeInterval = 5;
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.tableView.rowHeight = 80;
    NSLog(@"%@", self.age);
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
#pragma mark -- (WMLoopViewDelegate)
- (void)loopViewDidSelectedImage:(WMLoopView *)loopView index:(int)index
{
    GSImageCollectionViewController *imageVC = [GSImageCollectionViewController viewControllerWithDataSource:self.images];
    imageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageVC animated:YES];
    imageVC.defaultPageIndex = index;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
// UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
     NSString *cell = @"YDHotTableViewCell";
     YDHotTableViewCell *hotTableView = [tableView dequeueReusableCellWithIdentifier:cell forIndexPath:indexPath];
     [hotTableView loadTheData:@"zoro.jpg" title:@"一个人" content:@"有一个人回家果断发坑爹噶疯狂"];
 
 return hotTableView;
 }


@end
