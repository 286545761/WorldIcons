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

    self.navLabel.text = @"修改密码";
    
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 10, 320-20, 568-20)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 5;
    back.layer.masksToBounds = YES;
    [self.view addSubview:back];
    
    RegisterInputView *oldPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"原密码" withPlaceholder:@"请输入原密码"];
    [self.view addSubview:oldPwd];
    oldPwd.field.secureTextEntry = YES;
    oldPwd.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:0.5];
    self.oldPwd = oldPwd;
    
    RegisterInputView *newPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"新密码" withPlaceholder:@"请输入新密码"];
    [self.view addSubview:newPwd];
    newPwd.field.secureTextEntry = YES;
    newPwd.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:0.5];
    self.rnewPwd = newPwd;
    
    RegisterInputView *reNewPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"确认密码" withPlaceholder:@"请再次输入密码"];
    [self.view addSubview:reNewPwd];
    reNewPwd.field.secureTextEntry = YES;
    reNewPwd.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:0.5];
    self.reNewPwd = reNewPwd;
    
    //提交按钮
    UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交" withRadius:(45*0.5)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
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
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.reNewPwd.mas_bottom).offset(40);
    }];
   
}
#pragma mark -- 提交按钮
-(void)submitAction{
    [self.view endEditing:YES];
    if (self.reNewPwd.field.text.length < 6) {
        [MBProgressHUD gc_showErrorMessage:@"密码最少6位！"];
        return;
    }
    if (![self.rnewPwd.field.text isEqualToString:self.reNewPwd.field.text]) {
        [MBProgressHUD gc_showErrorMessage:@"两次输入的密码不一致！"];
        return;
    }
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"修改中..."];
    ResetRequest *resetReq = [ResetRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            [MBProgressHUD gc_showInfoMessage:@"修改成功！"];
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
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    resetReq.ub_id = [UserManager getUID];
    resetReq.ud_pwd = [NSString md5:self.oldPwd.field.text];
    resetReq.anew_pwd = [NSString md5:self.reNewPwd.field.text];
    [resetReq startRequest];
}

@end
