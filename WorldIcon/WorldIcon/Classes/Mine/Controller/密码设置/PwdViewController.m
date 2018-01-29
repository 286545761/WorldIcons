//
//  PwdViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "PwdViewController.h"
#import "RegisterInputView.h"
#import "GCVerificationCodeView.h"
#import "GetCodeRequest.h"
#import "PayPwdRequest.h"

@interface PwdViewController ()

@property (nonatomic,strong)GCVerificationCodeView *verificationCodeView;
@property (nonatomic,strong)RegisterInputView *phone;
@property (nonatomic,strong)UILabel *yzm;
@property (nonatomic,strong)RegisterInputView *NewPwd;
@property (nonatomic,strong)RegisterInputView *reNewPwd;
@property (nonatomic,strong)NSDictionary *resultDic;

@end

@implementation PwdViewController
- (NSDictionary *)resultDic{
    if (!_resultDic) {
        _resultDic = [NSDictionary dictionary];
    }
    return _resultDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navLabel.text = self.title;
    
    UIView *bakc = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, kScreenHeight-20)];
    bakc.backgroundColor = [UIColor whiteColor];
    bakc.layer.masksToBounds = YES;
    bakc.layer.cornerRadius = 5;
    [self.view addSubview:bakc];
    
    RegisterInputView *phone = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"登录密码" withPlaceholder:@"请输入登录密码"];
    [self.view addSubview:phone];
    phone.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:0.5];
    self.phone = phone;
    
    _yzm = [[UILabel alloc]init];
    _yzm.text = @"以下用于支付密码设置";
    _yzm.textColor = [UIColor redColor];
    _yzm.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_yzm];
    
    RegisterInputView *NewPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"新密码" withPlaceholder:@"请输入6位数字密码"];
    [self.view addSubview:NewPwd];
    NewPwd.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:0.5];
    self.NewPwd = NewPwd;
    
    RegisterInputView *reNewPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"确认密码" withPlaceholder:@"请输入6位数字密码"];
    [self.view addSubview:reNewPwd];
    reNewPwd.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:0.5];
    self.reNewPwd = reNewPwd;
    
    //提交按钮
    UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交" withRadius:(45*0.5)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    [self.phone mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.view).offset(45);
    }];
    [self.yzm mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.phone.mas_bottom).offset(15);
    }];

    [self.NewPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.yzm.mas_bottom).offset(10);
    }];
    [self.reNewPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.NewPwd.mas_bottom).offset(15);
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
    
    if ([_resultDic[@"code"] isEqualToString:@"10"]) {
        if ([self.title isEqualToString:@"支付密码设置"]) {
            [self setPwdOnNetByType:@"1"];
        }
        if ([self.title isEqualToString:@"支付密码修改"]) {
            [self setPwdOnNetByType:@"1"];
        }
        if ([self.title isEqualToString:@"支付密码忘记"]) {
            [self setPwdOnNetByType:@"1"];
        }
    }
}

-(void)setPwdOnNetByType:(NSString *)action{

    PayPwdRequest *payPwdReq = [PayPwdRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
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
    
    payPwdReq.ub_id = [UserManager getUID];
    payPwdReq.action = action;
    payPwdReq.ud_pay = self.reNewPwd.field.text;
    
    [payPwdReq startRequest];
}

@end
