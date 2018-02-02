//
//  OnlineTransferViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "OnlineTransferViewController.h"
#import "RegisterInputView.h"
#import "UserInfoRequest.h"
#import "UserInfoModel.h"
#import "TransferRequest.h"
#import "PaymentView.h"

@interface OnlineTransferViewController ()
@property (nonatomic,strong)UserInfoModel *userInfoModel;
@property (nonatomic,strong) RegisterInputView *oldPwd;
@property (nonatomic,strong) RegisterInputView *anewPwd;
@property (nonatomic,strong) RegisterInputView *reNewPwd;
@property (nonatomic,strong)PaymentView *payMentView;
@end

@implementation OnlineTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"在线转账";
    
    [self loadUserInfoToNet];
    
}
-(void)setUpUI{

    RegisterInputView *oldPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"手机号" withPlaceholder:@"请输入手机号"];
    oldPwd.field.text = [NSString stringWithFormat:@"%@",_userInfoModel.user_base.ub_phone];
    oldPwd.userInteractionEnabled = NO;
    [self.view addSubview:oldPwd];
    self.oldPwd = oldPwd;
    
    RegisterInputView *newPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"昵称" withPlaceholder:@"请输入昵称"];
    newPwd.field.text = [NSString stringWithFormat:@"%@",_userInfoModel.user_detail.ud_nickname];
    newPwd.userInteractionEnabled = NO;
    [self.view addSubview:newPwd];
    self.anewPwd = newPwd;
    
    RegisterInputView *reNewPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"币量" withPlaceholder:@"请输入欧力币数量"];
    [self.view addSubview:reNewPwd];
    self.reNewPwd = reNewPwd;
    
    //提交按钮
    UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"确认" withRadius:(35.5*0.5)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    [oldPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.view).offset(45);
    }];
    [newPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(oldPwd.mas_bottom).offset(15);
    }];
    [reNewPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(newPwd.mas_bottom).offset(15);
    }];
    [submitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(reNewPwd.mas_bottom).offset(40);
    }];

}
#pragma mark -- 提交按钮
-(void)confirmAction{
    
    PaymentView *view = [[PaymentView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    view.redbag_moneyLabel1.text = [NSString stringWithFormat:@"$%@",self.reNewPwd.field.text];
    view.redbag_InfoLabel.text = @"在线转账";
    
    [kAppWindow addSubview:view];
    
    self.payMentView = view;
    
    @weakify(self);
    view.password.passwordBlock = ^(NSString *password) {
        @strongify(self);
        if (password.length==6) {
            [self enterCode:[NSString md5:password]];
        }
    };
}
#pragma mark --- 余额支付
-(void)enterCode:(NSString *)code{
    
    [self onlineTransferOnNet];
    
    [self.payMentView removeFromSuperview];
}
-(void)onlineTransferOnNet{

    TransferRequest *transferReq = [TransferRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
                        
            @weakify(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
            
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
    
    transferReq.ub_id = [UserManager getUID];
    transferReq.ub_id1 = [UserManager getUID];
    
    transferReq.ub_phone1 = self.oldPwd.field.text;
    transferReq.fee = self.reNewPwd.field.text;
    
    [transferReq startRequest];

}
-(void)loadUserInfoToNet{
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    UserInfoRequest *userInfoReq = [UserInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"10"]) {
            
            UserInfoModel *m = [[UserInfoModel alloc]initWithDictionary:responseDict error:nil];
            
            _userInfoModel = m;
            
            [self setUpUI];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

    }];
    
    userInfoReq.ub_id = [UserManager getUID];
    userInfoReq.ub_phone = self.phone;
    userInfoReq.type = @"1";
    [userInfoReq startRequest];
}
@end
