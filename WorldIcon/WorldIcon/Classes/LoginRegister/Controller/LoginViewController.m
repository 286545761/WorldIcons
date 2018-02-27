//
//  LoginViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "MainTabbarController.h"
#import "LoginRequest.h"
#import "ForgetPasswordViewController.h"
#import "UserInfoRequest.h"
#import "UserInfoModel.h"
//#import "GCInputView.h"
@interface LoginViewController ()
{
    AppDelegate *appdelegate;

}
//@property (nonatomic,strong)LoginInputView *password;
//@property (nonatomic,strong)LoginInputView *phone;
@property (nonatomic,strong)UserInfoModel *m;
@property (nonatomic, strong)UITextField   *userName;
@property (nonatomic, strong)UITextField   *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"登录";
    [self setUpMainUI];
}

#pragma mark -- 主要UI
-(void)setUpMainUI{

    UIImageView *bgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"loginback"];
    [self.view addSubview:bgView];
    
    UIImageView *logoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginlogo"]];
    logoImage.adaptiveIphone5Frame = CGRectMake(320/2-40, 40, 80, 70);
    [self.view addSubview:logoImage];
    
    self.userName = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(35,logoImage.adaptiveIphone5Frame.origin.y+logoImage.adaptiveIphone5Frame.size.height+35 , 320-70, 35)];
    self.userName.placeholder = @"请输入手机号/邮箱/用户名";
    self.userName.font = [UIFont fontWithAdaptiveIphone5Size:16];
//    UIImageView *iconimage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phoneicon"]];
//    iconimage1.adaptiveIphone5Frame = CGRectMake(5, 10, 15, 15);
//    self.userName.leftView = iconimage1;
    self.userName.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"phoneicon"]];
    [self.userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.userName.leftView.adaptiveIphone5Frame = CGRectMake(0, 7.5f, 30, 20);
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    self.userName.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
    self.userName.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [self.userName setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
    self.userName.leftView.contentMode = UIViewContentModeCenter;
    self.userName.layer.masksToBounds = YES;
    self.userName.layer.cornerRadius = self.userName.frame.size.height/2.0;
    self.userName.clearButtonMode = UITextFieldViewModeAlways;
    self.userName.textColor = [UIColor whiteColor];
    self.userName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.userName];
    
    
    self.password = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(self.userName.adaptiveIphone5Frame.origin.x,self.userName.adaptiveIphone5Frame.origin.y+self.userName.adaptiveIphone5Frame.size.height+15 , self.userName.adaptiveIphone5Frame.size.width, self.userName.adaptiveIphone5Frame.size.height)];
    self.password.secureTextEntry = YES;
    self.password.textAlignment = NSTextAlignmentLeft;
    self.password.font = [UIFont fontWithAdaptiveIphone5Size:15];
    self.password.placeholder = @"请输入密码";
    self.password.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"passwordicon"]];
    [self.password setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
    self.password.leftView.adaptiveIphone5Frame = CGRectMake(0, 7.5f, 30, 20);
    self.password.leftView.contentMode = UIViewContentModeCenter;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    self.password.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
    self.password.layer.masksToBounds = YES;
    self.password.layer.cornerRadius = self.password.frame.size.height/2.0;
    self.password.clearButtonMode = UITextFieldViewModeAlways;
    self.password.textColor = [UIColor whiteColor];
    [self.password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:self.password];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.adaptiveIphone5Frame = CGRectMake(320-35-100, self.password.adaptiveIphone5Frame.size.height+self.password.adaptiveIphone5Frame.origin.y+15, 100, 20);
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnAction) forControlEvents:UIControlEventTouchDown];
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:14];
    [self.view addSubview:forgetBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.adaptiveIphone5Frame = CGRectMake(40, forgetBtn.adaptiveIphone5Frame.size.height+forgetBtn.adaptiveIphone5Frame.origin.y+15, 320-80, 50);
    [loginBtn setImage:[UIImage imageNamed:@"loginbtn"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginBtn];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake([UIView countBeforeWithIphone5Length:35], self.view.frame.size.height-49-64-[UIView countBeforeWithIphone5Length:20], [UIView countBeforeWithIphone5Length:320-70], [UIView countBeforeWithIphone5Length:20]);
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn setTitle:@"还没有账户？立即注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:14];
    [registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registBtn];
    
    UIView *line = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(35, registBtn.adaptiveIphone5Frame.origin.y-20-1, 320-70, 1)];
    line.backgroundColor = [UIColor whiteColor];
    line.alpha = 0.3f;
    [self.view addSubview:line];
}


#pragma mark -- 注册
-(void)registBtnAction{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)forgetBtnAction{
    ForgetPasswordViewController *forget = [ForgetPasswordViewController new];
    [self.navigationController pushViewController:forget animated:YES];
}

-(void)loginBtnAction{
    [self login];
}

#pragma mark -- 登录按钮
-(void)login{
    [self.view endEditing:YES];
    [MBProgressHUD gc_showActivityMessageInWindow:@"登录中..."];
    LoginRequest *loginReq = [LoginRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            NSString *ub_id = [NSString stringWithFormat:@"%@",responseDict[@"ub_id"]];
            [UserManager setUID:ub_id];
//            [UserManager setPhone:self.phone.field.text];
            MainTabbarController *tabbarVC = [[MainTabbarController alloc]init];
            kAppDelegate.window.rootViewController = tabbarVC;
//            [self loadUserInfoWithUid:ub_id];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    if (self.userName.text.length == 0) {
        [MBProgressHUD gc_showErrorMessage:@"手机号不能为空"];
        return;
    }else{
        if (![NSString gc_judgePhoneNumber:self.userName.text]) {
            [MBProgressHUD gc_showErrorMessage:@"手机号输入有误"];
            return;
        }else{
            loginReq.ub_phone = self.userName.text;
        }
    }
    
    if (self.password.text.length < 6) {
        [MBProgressHUD gc_showErrorMessage:@"密码不少于6位"];
        return;
    }else{
        loginReq.ud_pwd = [NSString md5:self.password.text];
    }
    [loginReq startRequest];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
