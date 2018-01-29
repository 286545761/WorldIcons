//
//  PwdLoginResetViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/20.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "PwdLoginResetViewController.h"
#import "RegisterInputView.h"
#import "ResetRequest.h"

@interface PwdLoginResetViewController ()

@property (nonatomic,strong)RegisterInputView *oldPwd;
@property (nonatomic,strong)RegisterInputView *rnewPwd;
@property (nonatomic,strong)RegisterInputView *reNewPwd;
@end

@implementation PwdLoginResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"修改登录密码";
    
    RegisterInputView *oldPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"原密码" withPlaceholder:@"请输入原密码"];
    [self.view addSubview:oldPwd];
    self.oldPwd = oldPwd;
    
    RegisterInputView *newPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"新密码" withPlaceholder:@"请输入新密码"];
    [self.view addSubview:newPwd];
    self.rnewPwd = newPwd;
    
    RegisterInputView *reNewPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"确认密码" withPlaceholder:@"请再次输入密码"];
    [self.view addSubview:reNewPwd];
    self.reNewPwd = reNewPwd;
    //提交按钮
    UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交" withRadius:(35.5*0.5)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    [self.oldPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.view).offset(45);
    }];
    [self.rnewPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.oldPwd.mas_bottom).offset(15);
    }];
    [self.reNewPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.rnewPwd.mas_bottom).offset(15);
    }];
    [submitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.reNewPwd.mas_bottom).offset(40);
    }];
   
}
#pragma mark -- 提交按钮
-(void)submitAction{

    ResetRequest *resetReq = [ResetRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
                        
            @weakify(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
    resetReq.ub_id = [UserManager getUID];
    resetReq.ud_pwd = self.oldPwd.field.text;
    resetReq.anew_pwd = self.reNewPwd.field.text;
    
    [resetReq startRequest];

}

@end
