//
//  YDMessageListViewController.m
//  scholars
//  github 下载地址  https://github.com/zhouzhiqiang1/scholars
//
//  Created by r_zhou on 16/9/12.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SCMessageListViewController.h"
#import "KxMenu.h"
#import "SCChatViewController.h"
#import "GSUserSetting.h"

@interface SCMessageListViewController ()

@end

@implementation SCMessageListViewController

- (id)init {
    self = [super init];
    if (self) {
        //设置需要显示哪些类型的会话
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        /*!
         设置在会话列表中显示的头像形状，矩形或者圆形（全局有效）
         */
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    }
    return self;
}

/*
 *  视图加载前执行方法
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //导航栏显示
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通讯";
    
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_btn_MoreMore.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onMoreMoreAction:)];
    [rightButton setTintColor:[UIColor whiteColor]];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 6, 67, 23);
    //    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigator_btn_back"]];
    //    backImg.frame = CGRectMake(-10, 0, 22, 22);
    //    [backBtn addSubview:backImg];
    
    UILabel *backText = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 65, 22)];
    backText.text = @"退出";
    backText.font = [UIFont systemFontOfSize:15];
    [backText setBackgroundColor:[UIColor clearColor]];
    [backText setTextColor:[UIColor whiteColor]];
    [backBtn addSubview:backText];
    
    [backBtn addTarget:self action:@selector(leftBarButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    self.conversationListTableView.tableFooterView = [UIView new];
}



-(void)onMoreMoreAction:(id)sender
{
//    NSArray *menuItems =
//    @[
//      
//      [KxMenuItem menuItem:@"发起聊天"
//                     image:nil//[UIImage imageNamed:@"icon_chat"]
//                    target:self
//                    action:@selector(pushChat:)],
//      
//      [KxMenuItem menuItem:@"添加好友"
//                     image:nil//[UIImage imageNamed:@"icon_addfriend"]
//                    target:self
//                    action:@selector(pushAddFriend:)],
//      
//      [KxMenuItem menuItem:@"通讯录"
//                     image:nil//[UIImage imageNamed:@"icon_contact"]
//                    target:self
//                    action:@selector(pushAddressBook:)],
//      [KxMenuItem menuItem:@"讨论组"
//                     image:nil//[UIImage imageNamed:@"icon_contact"]
//                    target:self
//                    action:@selector(rightBarButtonItemPressed:)]
//      ];
//    
//    
//    CGRect targetFrame = self.navigationItem.leftBarButtonItem.customView.frame;
//    targetFrame.origin.y = targetFrame.origin.y ;//离上面的位置
//    targetFrame.origin.x = targetFrame.origin.x + self.view.frame.size.width;//离左面的位置
//    [KxMenu setTintColor:[UIColor blackColor]];
//    [KxMenu showMenuInView:self.navigationController.navigationBar.superview fromRect:targetFrame menuItems:menuItems];
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"发起聊天"
                     image:nil//[UIImage imageNamed:@"icon_chat"]
                    target:self
                    action:@selector(pushChat:)],

      [KxMenuItem menuItem:@"添加好友"
                     image:nil//[UIImage imageNamed:@"icon_addfriend"]
                    target:self
                    action:@selector(pushAddFriend:)],

      [KxMenuItem menuItem:@"通讯录"
                     image:nil//[UIImage imageNamed:@"icon_contact"]
                    target:self
                    action:@selector(pushAddressBook:)],
      [KxMenuItem menuItem:@"讨论组"
                     image:nil//[UIImage imageNamed:@"icon_contact"]
                    target:self
                    action:@selector(rightBarButtonItemPressed:)]
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(self.view.frame.size.width - 73, 0, 100, 50)
                 menuItems:menuItems];

}

-(void)pushChat:(id)sender
{
    NSLog(@"发起聊天");
}

-(void)pushAddFriend:(id)sender
{
    NSLog(@"添加好友");
}

-(void)pushAddressBook:(id)sender
{
    NSLog(@"通讯录");
}

/**
 *  退出登录
 *
 *  @param sender <#sender description#>
 */
- (void)leftBarButtonItemPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //断开与融云服务器的连接
        [[RCIM sharedRCIM] disconnect];
        //删除toKen
        [GSUserSetting deleteData:ORSettingsStrRYToken];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightBarButtonItemPressed:(id)sender {
    /*!
     创建讨论组
     
     @param name            讨论组名称
     @param userIdList      用户ID的列表
     @param successBlock    创建讨论组成功的回调 [discussion:创建成功返回的讨论组对象]
     @param errorBlock      创建讨论组失败的回调 [status:创建失败的错误码]
     */
    NSArray *userIDArray = @[@"user1",@"user2"];
    [[RCIMClient sharedRCIMClient] createDiscussion:@"讨论组" userIdList:userIDArray success:^(RCDiscussion *discussion) {
        NSLog(@"讨论组  创建成功  %@", discussion);
    } error:^(RCErrorCode status) {
        NSLog(@"讨论组  创建失败  %ld", (long)status);
    }];
}

/*!
 点击会话列表中Cell的回调
 
 @param conversationModelType   当前点击的会话的Model类型
 @param model                   当前点击的会话的Model
 @param indexPath               当前会话在列表数据源中的索引值
 
 @discussion 您需要重写此点击事件，跳转到指定会话的聊天界面。
 如果点击聚合Cell进入具体的子会话列表，在跳转时，需要将isEnteredToCollectionViewController设置为YES。
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    //    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]initWithConversationType:model.conversationType targetId:model.targetId];
    //    conversationVC.title = model.conversationTitle;
    //    [self.navigationController pushViewController:conversationVC animated:YES];
    SCChatViewController *conversationVC = [[SCChatViewController alloc]initWithConversationType:model.conversationType targetId:model.targetId];
    conversationVC.title = model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

/*!
 即将显示Cell的回调
 
 @param cell        即将显示的Cell
 @param indexPath   该Cell对应的会话Cell数据模型在数据源中的索引值
 
 @discussion 您可以在此回调中修改Cell的一些显示属性。
 */
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell
                             atIndexPath:(NSIndexPath *)indexPath
{
    /*!
     会话Cell数据模型的显示类型
     */
    cell.model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_COLLECTION;
}

/*!
 点击Cell头像的回调
 
 @param model   会话Cell的数据模型
 */
- (void)didTapCellPortrait:(RCConversationModel *)model
{
    NSLog(@"点击Cell头像的回调  %lu",(unsigned long)model.conversationModelType);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
