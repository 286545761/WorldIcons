//
//  EditNickNameViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/14.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "EditNickNameViewController.h"

@interface EditNickNameViewController ()
{
    UITextField *_nickname;
}
@end

@implementation EditNickNameViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navLabel.text = self.title;
    
    [self setUpNickName];
    
    [self setUpRightBarButton];
    
}
#pragma mark -- 昵称文本框
-(void)setUpNickName{

    _nickname = [UITextField gc_textFieldWithPlacHolder:@"" withTextColor:[UIColor blackColor] withTextFont:15];
    _nickname.text = self.nicknameStr;
    _nickname.placeholder = @"请设置";
    _nickname.backgroundColor = [UIColor whiteColor];
    _nickname.frame = CGRectMake(-0.5, 10, kScreenWidth, 40);
    [self.view addSubview:_nickname];
    
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    _nickname.leftViewMode = UITextFieldViewModeAlways;
    _nickname.leftView = lv;
    
}
#pragma mark -- 右侧退出登录
-(void)setUpRightBarButton{
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveNicknameAction)];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn;
    
}

#pragma mark -- 保存昵称
-(void)saveNicknameAction{

    if (_nickname.text) {
        self.block(_nickname.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
