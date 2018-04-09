//
//  SCUserInfoViewController.m
//  scholars
//
//  Created by R_zhou on 2018/3/12.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "SCUserInfoViewController.h"
#import "SCUserInfoTableViewCell.h"

@interface SCUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation SCUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataArray = @[@{@"title":@"昵称", @"content":@"张三"},
                       @{@"title":@"性别", @"content":@"男"},
                       @{@"title":@"年龄", @"content":@"32"},
                       @{@"title":@"手机号", @"content":@"15857153273"},
                       @{@"title":@"收货地址", @"content":@"积分商城"}];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//显示信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger row = indexPath.row;
    static NSString *cellIdentifier = @"SCUserInfoTableViewCell";
    SCUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSString *title = [dict objectForKey:@"title"];
    NSString *content = [dict objectForKey:@"content"];
    
    cell.titleLabel.text = title;
    cell.textField.text = content;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",(long)indexPath.row);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
