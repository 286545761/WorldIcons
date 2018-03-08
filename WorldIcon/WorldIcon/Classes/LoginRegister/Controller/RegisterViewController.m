//
//  RegisterViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterInputView.h"
#import "GCVerificationCodeView.h"
#import "AuthcodeView.h"

#import "GetCodeRequest.h"
#import "ValidCodeRequest.h"
#import "RegisterRequest.h"
#import "ValidCodeRequest.h"

@interface RegisterViewController ()
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)UITextField *userName;
@property (nonatomic,strong)UITextField *password;
@property (nonatomic,strong)UITextField *resetpassword;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"注册";
    [self setUpBackgroundView];
    [self setUpMainUI];
    [self setUpBottomView];
}
-(void)setUpBackgroundView{
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"loginback"];
    [self.view addSubview:bgView];
    
}
#pragma mark -- 配置主要UI
-(void)setUpMainUI{
    _userName = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(35,35,320-70,35)];
    _userName.placeholder = @"请输入手机号／邮箱／用户名";
    _userName.font = [UIFont fontWithAdaptiveIphone5Size:16];
    _userName.leftView = [[UIView alloc]init];
    _userName.leftView.adaptiveIphone5Frame = CGRectMake(0, 0, 10, 35);
    _userName.leftViewMode = UITextFieldViewModeAlways;
    [_userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _userName.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
    _userName.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [_userName setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
    _userName.layer.masksToBounds = YES;
    _userName.layer.cornerRadius = _userName.frame.size.height/2.0;
    _userName.clearButtonMode = UITextFieldViewModeAlways;
    _userName.textColor = [UIColor whiteColor];
    _userName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_userName];
    
    
    _password = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(_userName.adaptiveIphone5Frame.origin.x,_userName.adaptiveIphone5Frame.origin.y+_userName.adaptiveIphone5Frame.size.height+15 , _userName.adaptiveIphone5Frame.size.width, _userName.adaptiveIphone5Frame.size.height)];
    _password.textAlignment = NSTextAlignmentLeft;
    _password.leftView = [[UIView alloc]init];
    _password.leftView.adaptiveIphone5Frame = CGRectMake(0, 0, 10, 35);
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.font = [UIFont fontWithAdaptiveIphone5Size:15];
    _password.placeholder = @"请输入密码";
    [_password setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
    _password.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
    _password.layer.masksToBounds = YES;
    _password.layer.cornerRadius = _password.frame.size.height/2.0;
    _password.clearButtonMode = UITextFieldViewModeAlways;
    _password.textColor = [UIColor whiteColor];
    [_password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_password];
    
    
    _resetpassword = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(_password.adaptiveIphone5Frame.origin.x,_password.adaptiveIphone5Frame.origin.y+_password.adaptiveIphone5Frame.size.height+15 , _password.adaptiveIphone5Frame.size.width, _userName.adaptiveIphone5Frame.size.height)];
    _resetpassword.textAlignment = NSTextAlignmentLeft;
    _resetpassword.leftView = [[UIView alloc]init];
    _resetpassword.leftView.adaptiveIphone5Frame = CGRectMake(0, 0, 10, 35);
    _resetpassword.leftViewMode = UITextFieldViewModeAlways;
    _resetpassword.font = [UIFont fontWithAdaptiveIphone5Size:15];
    _resetpassword.placeholder = @"请确认密码";
    [_resetpassword setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
    _resetpassword.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
    _resetpassword.layer.masksToBounds = YES;
    _resetpassword.layer.cornerRadius = _resetpassword.frame.size.height/2.0;
    _resetpassword.clearButtonMode = UITextFieldViewModeAlways;
    _resetpassword.textColor = [UIColor whiteColor];
    [_resetpassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_resetpassword];

    
    UIButton *confirmBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor clearColor] withTitle:@"提交" withRadius:5];
    confirmBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:16];
    confirmBtn.adaptiveIphone5Frame = CGRectMake(40, _resetpassword.adaptiveIphone5Frame.origin.y+_resetpassword.adaptiveIphone5Frame.size.height+30, 320-80, 40);
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [confirmBtn setTitleColor:RGBA(150, 65, 0, 1) forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

-(void)setUpBottomView{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.adaptiveIphone5Frame = CGRectMake(20, self.view.adaptiveIphone5Frame.size.height-30-18-64, 320-40, 18);
    [_button setTitle:@"我已同意《欧力币用户协议》确认注册" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:14];
    [_button setImage:[UIImage imageNamed:@"argry"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [_button setImage:[UIImage imageNamed:@"unargry"] forState:UIControlStateSelected];
    [_button gc_layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
    [self.view addSubview:_button];
    
    //线条
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3f];
    line.adaptiveIphone5Frame = CGRectMake(20, _button.adaptiveIphone5Frame.origin.y-20, 320-40, 1);
    [self.view addSubview:line];
}

-(void)confirmClick:(UIButton *)sender{
    [self.view endEditing:YES];
    RegisterRequest *registerReq = [RegisterRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            [UserManager setUID:responseDict[@"ub_id"]];
            [UserManager setPhone:self.userName.text];
            [UserManager setSID:responseDict[@"result"][@"sid"]];
            [MBProgressHUD gc_showErrorMessage:@"注册成功"];
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
    /*
     ub_phone ud_pwd vc_code ud_ol_status ub_id ud_nickname
     */
    if (self.button.selected == YES) {
        [MBProgressHUD gc_showErrorMessage:@"您未同意注册协议"];
        return;
    }
    if (self.password.text.length < 6) {
        [MBProgressHUD gc_showErrorMessage:@"密码不能少于6位"];
        return;
    }else{
        if (![self.password.text isEqualToString:self.resetpassword.text]) {
            [MBProgressHUD gc_showErrorMessage:@"两次输入的密码不一致"];
            return;
        }
        registerReq.ud_pwd = [NSString md5:self.password.text];
    }
    registerReq.ub_phone = self.userName.text;
    registerReq.ud_ol_status = @"1";//虚拟币协议
    registerReq.ub_id = @"";
    [registerReq startRequest];
}


-(void)buttonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

/**
 限制验证码的长度
 */
- (void)textFieldDidChange:(UITextField *)textField{
    if(textField == self.userName){
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
            [MBProgressHUD gc_showErrorMessage:@"手机号超出界限"];
        }
    }
}

@end
