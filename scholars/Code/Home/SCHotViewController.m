//
//  SCHotViewController.m
//  scholars
//
//  Created by r_zhou on 16/3/10.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import "SCHotViewController.h"
#import "YDHotTableViewCell.h"
#import "WMLoopView.h"
#import "WMPageConst.h"

@interface SCHotViewController ()<WMLoopViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSNumber *age;
@end

@implementation SCHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.showsVerticalScrollIndicator = NO;
    
    NSArray *images = @[@"zoro.jpg",@"three.jpg",@"onepiece.jpg"];
    WMLoopView *loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:images autoPlay:YES delay:2.0];
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
