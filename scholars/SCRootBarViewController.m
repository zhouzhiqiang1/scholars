//
//  SCRootBarViewController.m
//  scholars
//
//  Created by mgc1105 on 16/3/9.
//  Copyright © 2016年 Mac Xiong. All rights reserved.
//

#import "SCRootBarViewController.h"

@interface SCRootBarViewController ()

@end

@implementation SCRootBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     试图控制器中添加  storyboard 视图
     */
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, 0.5f)];
    [self.tabBar addSubview:lineView];
    
    NSMutableArray *viewControlles = [NSMutableArray arrayWithArray:self.viewControllers];
    
    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UINavigationController *homeNavController = [homeStoryboard instantiateInitialViewController];
    [viewControlles replaceObjectAtIndex:0 withObject:homeNavController];
    
    
    [self setViewControllers:viewControlles];
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

@end
