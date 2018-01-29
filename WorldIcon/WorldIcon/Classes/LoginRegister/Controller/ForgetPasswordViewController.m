//
//  ForgetPasswordViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "YMMChooseBar.h"
#import "ForgotpwdRequest.h"
#import "CheckQustionRequest.h"
#import "XLAlertView.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)YMMChooseBar *chooseBar;
@property (nonatomic,strong)UIView *emailView;
@property (nonatomic,strong)UIView *questionView;
@property (nonatomic,strong)UIView *questionDetailView;
@property (nonatomic,strong)UILabel *question1L;
@property (nonatomic,strong)UILabel *question2L;
@property (nonatomic,strong)UILabel *question3L;
@property (nonatomic,strong)NSMutableArray *answerArr;
@property (nonatomic,strong)NSMutableArray *questionsListArr;
@property (nonatomic,strong)NSArray *questionsArr;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionsArr = @[@"你第一所小学校名",@"你在设置预留信息",@"你第一个男／女朋友名字",@"你的出生地方",@"你最要好的朋友名字",@"你母亲名字",@"你父亲名字"];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginback"]];
    image.frame = self.view.bounds;
    [self.view addSubview:image];
    self.answerArr = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    self.navLabel.text = @"忘记密码";
    __weak __typeof (&*self)weakSelf = self;
    _chooseBar = [[YMMChooseBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIView countBeforeWithIphone5Length:40])];
    _chooseBar.titleArray = @[@"邮箱找回",@"问题找回"];
    [_chooseBar setIndexChangeBlock:^(NSUInteger index) {
        if (index == 0) {
            weakSelf.emailView.hidden = NO;
            weakSelf.questionDetailView.hidden = YES;
            weakSelf.questionView.hidden = YES;
        }else{
            weakSelf.emailView.hidden = YES;
            weakSelf.questionView.hidden = NO;
        }
    }];
    [self.view addSubview:_chooseBar];
    [self.view addSubview:self.emailView];
    [self.view addSubview:self.questionView];
    [self.view addSubview:self.questionDetailView];
}

-(UIView *)emailView{
    if (!_emailView) {
        _emailView = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, self.chooseBar.adaptiveIphone5Frame.size.height, 320, 568-self.chooseBar.adaptiveIphone5Frame.size.height-44-64)];
        UITextField *userName = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(35,35,320-70,35)];
        userName.placeholder = @"请输入账户名";
        userName.tag = 1000;
        userName.font = [UIFont fontWithAdaptiveIphone5Size:16];
        userName.leftView = [[UIView alloc]init];
        userName.leftView.adaptiveIphone5Frame = CGRectMake(0, 0, 10, 35);
        userName.leftViewMode = UITextFieldViewModeAlways;
        [userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        userName.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
        userName.font = [UIFont fontWithAdaptiveIphone5Size:15];
        [userName setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
        userName.layer.masksToBounds = YES;
        userName.layer.cornerRadius = userName.frame.size.height/2.0;
        userName.clearButtonMode = UITextFieldViewModeAlways;
        userName.textColor = [UIColor whiteColor];
        userName.textAlignment = NSTextAlignmentLeft;
        [_emailView addSubview:userName];
        
        
        UITextField *password = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(userName.adaptiveIphone5Frame.origin.x,userName.adaptiveIphone5Frame.origin.y+userName.adaptiveIphone5Frame.size.height+15 , userName.adaptiveIphone5Frame.size.width, userName.adaptiveIphone5Frame.size.height)];
        password.tag = 1001;
        password.textAlignment = NSTextAlignmentLeft;
        password.leftView = [[UIView alloc]init];
        password.leftView.adaptiveIphone5Frame = CGRectMake(0, 0, 10, 35);
        password.leftViewMode = UITextFieldViewModeAlways;
        password.font = [UIFont fontWithAdaptiveIphone5Size:15];
        password.placeholder = @"请输入邮箱";
        [password setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
        password.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
        password.layer.masksToBounds = YES;
        password.layer.cornerRadius = password.frame.size.height/2.0;
        password.clearButtonMode = UITextFieldViewModeAlways;
        password.textColor = [UIColor whiteColor];
        [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_emailView addSubview:password];

        UIButton *confirmBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor clearColor] withTitle:@"提交" withRadius:5];
        confirmBtn.tag = 100;
        confirmBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:16];
        confirmBtn.adaptiveIphone5Frame = CGRectMake(40, password.adaptiveIphone5Frame.origin.y+password.adaptiveIphone5Frame.size.height+30, 320-80, 40);
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [confirmBtn setTitleColor:RGBA(150, 65, 0, 1) forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [_emailView addSubview:confirmBtn];
        UILabel *show = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(40, confirmBtn.adaptiveIphone5Frame.origin.y+confirmBtn.adaptiveIphone5Frame.size.height+10, confirmBtn.adaptiveIphone5Frame.size.width, 50)];
        show.numberOfLines = 0;
        show.font = [UIFont fontWithAdaptiveIphone5Size:13];
        show.text = @"为了您的账号安全，避免再次忘记密码，建议您登录后先修改登录密码";
        show.textColor = [UIColor colorWithWhite:1 alpha:0.5];
        [_emailView addSubview:show];
    }
    return _emailView;
}

-(UIView *)questionView{
    if (!_questionView) {
        _questionView = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, self.chooseBar.adaptiveIphone5Frame.size.height, 320, 568-self.chooseBar.adaptiveIphone5Frame.size.height-44-64)];
        
        UITextField *userName = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(35,35,320-70,35)];
        userName.placeholder = @"请输入账户名";
        userName.font = [UIFont fontWithAdaptiveIphone5Size:16];
        userName.leftView = [[UIView alloc]init];
        userName.leftView.adaptiveIphone5Frame = CGRectMake(0, 0, 10, 35);
        userName.leftViewMode = UITextFieldViewModeAlways;
        [userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        userName.backgroundColor = [UIColor gc_colorWithHexString:@"#bf4700" alpha:0.5f];
        userName.font = [UIFont fontWithAdaptiveIphone5Size:15];
        [userName setValue:[UIFont fontWithAdaptiveIphone5Size:15] forKeyPath:@"_placeholderLabel.font"];
        userName.layer.masksToBounds = YES;
        userName.layer.cornerRadius = userName.frame.size.height/2.0;
        userName.clearButtonMode = UITextFieldViewModeAlways;
        userName.textColor = [UIColor whiteColor];
        userName.textAlignment = NSTextAlignmentLeft;
        userName.tag = 100;
        [_questionView addSubview:userName];
        
        UIButton *confirmBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor clearColor] withTitle:@"提交" withRadius:5];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [confirmBtn setTitleColor:RGBA(150, 65, 0, 1) forState:UIControlStateNormal];
        confirmBtn.adaptiveIphone5Frame = CGRectMake(40, userName.adaptiveIphone5Frame.origin.y+userName.adaptiveIphone5Frame.size.height+30, 320-80, 40);
        confirmBtn.tag = 101;
        confirmBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:16];
        [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [_questionView addSubview:confirmBtn];
        _questionView.hidden = YES;
    }
    return _questionView;
}

-(UIView *)questionDetailView{
    if (!_questionDetailView) {
        _questionDetailView = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, self.chooseBar.adaptiveIphone5Frame.size.height, 320, 568-self.chooseBar.adaptiveIphone5Frame.size.height-44-64)];
        
        UITextField *userInputTF = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(35, 20, 320-70, 35)];
        userInputTF.leftView = [[UIView alloc] initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 10, 35)];
        userInputTF.leftViewMode = UITextFieldViewModeAlways;
        userInputTF.textColor = [UIColor whiteColor];
        userInputTF.font = [UIFont fontWithAdaptiveIphone5Size:15];
        userInputTF.backgroundColor = [UIColor gc_colorWithHexString:@"#b64700" alpha:0.5f];
        userInputTF.tag = 100;
        userInputTF.layer.masksToBounds = YES;
        userInputTF.userInteractionEnabled = NO;
        userInputTF.layer.cornerRadius = [UIView countBeforeWithIphone5Length:35.0/2];
        [_questionDetailView addSubview:userInputTF];
        
        UILabel *showL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, userInputTF.adaptiveIphone5Frame.origin.y+userInputTF.adaptiveIphone5Frame.size.height+8, userInputTF.adaptiveIphone5Frame.size.width, userInputTF.adaptiveIphone5Frame.size.height)];
        showL.text = @"请回答您密保设置的3个问题";
        showL.backgroundColor = [UIColor clearColor];
        showL.textColor = [UIColor whiteColor];
        showL.font = [UIFont fontWithAdaptiveIphone5Size:16];
        showL.textAlignment = NSTextAlignmentLeft;
        [_questionDetailView addSubview:showL];
        
        _question1L = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, showL.adaptiveIphone5Frame.origin.y+showL.adaptiveIphone5Frame.size.height+8, userInputTF.adaptiveIphone5Frame.size.width, userInputTF.adaptiveIphone5Frame.size.height)];
        _question1L.text = @"问题2";
        _question1L.backgroundColor = [UIColor clearColor];
        _question1L.textColor = [UIColor whiteColor];
        _question1L.font = [UIFont fontWithAdaptiveIphone5Size:16];
        _question1L.textAlignment = NSTextAlignmentLeft;
        [_questionDetailView addSubview:_question1L];
        
        UITextField *question1InputTF = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, _question1L.adaptiveIphone5Frame.origin.y+_question1L.adaptiveIphone5Frame.size.height+8, userInputTF.adaptiveIphone5Frame.size.width, userInputTF.adaptiveIphone5Frame.size.height)];
        UILabel *l1 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 55,userInputTF.adaptiveIphone5Frame.size.height)];
        l1.font = [UIFont fontWithAdaptiveIphone5Size:15];
        l1.text = @"  回答1：";
        l1.textColor = [UIColor whiteColor];
        question1InputTF.tag = 1000;
        question1InputTF.leftView = l1;
        question1InputTF.leftViewMode = UITextFieldViewModeAlways;
        question1InputTF.textColor = [UIColor whiteColor];
        question1InputTF.font = [UIFont fontWithAdaptiveIphone5Size:15];
        question1InputTF.backgroundColor = [UIColor gc_colorWithHexString:@"#b64700" alpha:0.5f];
        question1InputTF.layer.masksToBounds = YES;
        question1InputTF.layer.cornerRadius = [UIView countBeforeWithIphone5Length:35.0/2];
        question1InputTF.delegate = self;
        [_questionDetailView addSubview:question1InputTF];
        
        _question2L = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, question1InputTF.adaptiveIphone5Frame.origin.y+question1InputTF.adaptiveIphone5Frame.size.height+8, userInputTF.adaptiveIphone5Frame.size.width, userInputTF.adaptiveIphone5Frame.size.height)];
        _question2L.text = @"问题2";
        _question2L.backgroundColor = [UIColor clearColor];
        _question2L.textColor = [UIColor whiteColor];
        _question2L.font = [UIFont fontWithAdaptiveIphone5Size:16];
        _question2L.textAlignment = NSTextAlignmentLeft;
        [_questionDetailView addSubview:_question2L];
        
        UITextField *question2InputTF = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, _question2L.adaptiveIphone5Frame.origin.y+_question2L.adaptiveIphone5Frame.size.height+8, userInputTF.adaptiveIphone5Frame.size.width, userInputTF.adaptiveIphone5Frame.size.height)];
        UILabel *l2 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 55,userInputTF.adaptiveIphone5Frame.size.height)];
        l2.text = @"  回答2：";
        l2.textColor = [UIColor whiteColor];
        l2.font = [UIFont fontWithAdaptiveIphone5Size:15];
        question2InputTF.tag = 1001;
        question2InputTF.leftView = l2;
        question2InputTF.leftViewMode = UITextFieldViewModeAlways;
        question2InputTF.textColor = [UIColor whiteColor];
        question2InputTF.font = [UIFont fontWithAdaptiveIphone5Size:15];
        question2InputTF.backgroundColor = [UIColor gc_colorWithHexString:@"#b64700" alpha:0.5f];
        question2InputTF.layer.masksToBounds = YES;
        question2InputTF.layer.cornerRadius = [UIView countBeforeWithIphone5Length:35.0/2];
        question2InputTF.delegate = self;
        [_questionDetailView addSubview:question2InputTF];
        
        _question3L = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, question2InputTF.adaptiveIphone5Frame.origin.y+question2InputTF.adaptiveIphone5Frame.size.height+8, userInputTF.adaptiveIphone5Frame.size.width, userInputTF.adaptiveIphone5Frame.size.height)];
        _question3L.text = @"问题3";
        _question3L.backgroundColor = [UIColor clearColor];
        _question3L.textColor = [UIColor whiteColor];
        _question3L.font = [UIFont fontWithAdaptiveIphone5Size:16];
        _question3L.textAlignment = NSTextAlignmentLeft;
        [_questionDetailView addSubview:_question3L];
        
        UITextField *question3InputTF = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, _question3L.adaptiveIphone5Frame.origin.y+_question3L.adaptiveIphone5Frame.size.height+8, userInputTF.adaptiveIphone5Frame.size.width, userInputTF.adaptiveIphone5Frame.size.height)];
        UILabel *l3 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 55,userInputTF.adaptiveIphone5Frame.size.height)];
        l3.text = @"  回答3:";
        l3.textColor = [UIColor whiteColor];
        l3.font = [UIFont fontWithAdaptiveIphone5Size:15];
        question3InputTF.tag = 1002;
        question3InputTF.leftView = l3;
        question3InputTF.leftViewMode = UITextFieldViewModeAlways;
        question3InputTF.textColor = [UIColor whiteColor];
        question3InputTF.font = [UIFont fontWithAdaptiveIphone5Size:15];
        question3InputTF.backgroundColor = [UIColor gc_colorWithHexString:@"#b64700" alpha:0.5f];
        question3InputTF.layer.masksToBounds = YES;
        question3InputTF.layer.cornerRadius = [UIView countBeforeWithIphone5Length:30.0/2];
        question3InputTF.delegate = self;
        [_questionDetailView addSubview:question3InputTF];
        
        UIButton *confirmBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor clearColor] withTitle:@"提交" withRadius:5];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [confirmBtn setTitleColor:RGBA(150, 65, 0, 1) forState:UIControlStateNormal];
        confirmBtn.adaptiveIphone5Frame = CGRectMake(userInputTF.adaptiveIphone5Frame.origin.x, question3InputTF.adaptiveIphone5Frame.origin.y+question3InputTF.adaptiveIphone5Frame.size.height+15, userInputTF.adaptiveIphone5Frame.size.width, 40);
        confirmBtn.tag = 101;
        [confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [_questionDetailView addSubview:confirmBtn];
        _questionDetailView.hidden = YES;
    }
    return _questionDetailView;
}

-(void)confirmAction:(UIButton *)sender{
    [self.view endEditing:YES];
    if (sender.tag == 100) {
        ForgotpwdRequest *registerReq = [ForgotpwdRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
            if ([model.code isEqualToString:@"01"]) {
                [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            }else if ([model.code isEqualToString:@"10"]) {
                [MBProgressHUD gc_showErrorMessage:@"密码已发送至您的邮箱，请注意查收"];
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
        UITextField *userName  = [self.emailView viewWithTag:1000];
        registerReq.ub_phone = userName.text;
        UITextField *email  = [self.emailView viewWithTag:1001];
        registerReq.ud_email = email.text;
        registerReq.ud_type = @"2";
        registerReq.ud_a1 = @"";
        registerReq.ud_a2 = @"";
        registerReq.ud_a3 = @"";
        registerReq.ud_p1 = @"";
        registerReq.ud_p2 = @"";
        registerReq.ud_p3 = @"";
        [registerReq startRequest];
    }
    if (sender.tag == 101) {
        CheckQustionRequest *registerReq = [CheckQustionRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
            if ([model.code isEqualToString:@"01"]) {
                [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            }else if ([model.code isEqualToString:@"10"]) {
                self.questionDetailView.hidden = NO;
                self.questionView.hidden = YES;
                self.questionsListArr = responseDict[@"questionsList"];
                self.question1L.text = [NSString stringWithFormat:@"问题1：%@",self.questionsArr[[responseDict[@"questionsList"][0] integerValue]-1]];
                self.question2L.text = [NSString stringWithFormat:@"问题2：%@",self.questionsArr[[responseDict[@"questionsList"][1] integerValue]-1]];
                self.question3L.text = [NSString stringWithFormat:@"问题3：%@",self.questionsArr[[responseDict[@"questionsList"][2] integerValue]-1]];
                UITextField  *userTF = [self.questionView viewWithTag:100];
                UITextField  *userInputTF = [self.questionDetailView viewWithTag:100];
                userInputTF.text = userTF.text;
            }else if([model.code isEqualToString:@"20"]) {
                [MBProgressHUD gc_showErrorMessage:model.info];
            }else{
                [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            }
        } failureBlock:^(NSError *error) {
            
        }];
        UITextField *userName  = [self.questionView viewWithTag:100];
        registerReq.ub_phone = userName.text;
        [registerReq startRequest];
    }
}

-(void)confirmClick{
    [self.view endEditing:YES];
    ForgotpwdRequest *registerReq = [ForgotpwdRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            XLAlertView *xlAlertView = [[XLAlertView alloc] initWithMessage:[NSString stringWithFormat:@"请牢记您的密码：%@",responseDict[@"ud_pwd"]] sureBtn:@"确认" cancleBtn:@"取消"];
            xlAlertView.resultIndex = ^(NSInteger index){
                //回调---处理一系列动作
                if (index == 1) {//取消
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                if (index == 2) {//确定
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            };
            [xlAlertView showXLAlertView];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    UITextField  *userInputTF = [self.questionDetailView viewWithTag:100];
    registerReq.ub_phone = userInputTF.text;
    registerReq.ud_type = @"1";
    registerReq.ud_email = @"";
    registerReq.ud_p1 = self.questionsListArr[0];
    registerReq.ud_p2 = self.questionsListArr[1];
    registerReq.ud_p3 = self.questionsListArr[2];
    if ([self.answerArr[0]isEqualToString:@""]||[self.answerArr[1]isEqualToString:@""]||[self.answerArr[2]isEqualToString:@""]) {
        [MBProgressHUD gc_showErrorMessage:@"请回答所有的问题再提交！"];
        return;
    }
    registerReq.ud_a1 = self.answerArr[0];
    registerReq.ud_a2 = self.answerArr[1];
    registerReq.ud_a3 = self.answerArr[2];
    [registerReq startRequest];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;{
    [self.answerArr replaceObjectAtIndex:textField.tag-1000 withObject:textField.text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
