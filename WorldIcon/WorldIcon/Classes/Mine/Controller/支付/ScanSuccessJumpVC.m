//
//  ScanSuccessJumpVC.m
//  SGQRCodeExample
//
//  Created by Sorgle on 16/8/29.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import "ScanSuccessJumpVC.h"
#import "SGWebView.h"
#import "SGQRCodeConst.h"
#import "RegisterInputView.h"
#import "PaymentView.h"
#import "TransferRequest.h"

@interface ScanSuccessJumpVC () <SGWebViewDelegate>

@property (nonatomic , strong) SGWebView *webView;
@property (nonatomic,strong)RegisterInputView *phone;
@property (nonatomic,strong)RegisterInputView *NewPwd;
@property (nonatomic,strong)RegisterInputView *reNewPwd;
@property (nonatomic,strong)PaymentView *payMentView;
@end

@implementation ScanSuccessJumpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navLabel.text = @"支付";
    
    if (self.jump_bar_code) {
        [self setupView];
    } else {
        [self setupWebView];
    }
}

- (void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)right_BarButtonItemAction {
    [self.webView reloadData];
}

// 添加Label，加载扫描过来的内容
- (void)setupView {
   
    RegisterInputView *phone = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"手机号" withPlaceholder:@"请输入手机号"];
    phone.field.text = [UserManager getPhone];
    phone.userInteractionEnabled = NO;
    [self.view addSubview:phone];
    self.phone = phone;
    
    
    RegisterInputView *NewPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"昵称" withPlaceholder:@"请输入昵称"];
    NewPwd.field.text = [UserManager getNickName];
    NewPwd.userInteractionEnabled = NO;
    [self.view addSubview:NewPwd];
    self.NewPwd = NewPwd;
    
    RegisterInputView *reNewPwd = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"币量" withPlaceholder:@"请输入支付欧力币的数量"];
    [self.view addSubview:reNewPwd];
    self.reNewPwd = reNewPwd;
    
    //提交按钮
    UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"支付" withRadius:(35.5*0.5)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    [self.phone mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.view).offset(45);
    }];
   
    [self.NewPwd mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(48));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(48));
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.phone.mas_bottom).offset(15);
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
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.reNewPwd.mas_bottom).offset(40);
    }];
    
}
#pragma mark -- 支付按钮
-(void)payAction{

    PaymentView *view = [[PaymentView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    view.redbag_moneyLabel1.text = [NSString stringWithFormat:@"$%@",self.reNewPwd.field.text];
    view.redbag_InfoLabel.text = @"扫码支付";
    
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
    
    transferReq.ub_phone1 = self.phone.field.text;
    transferReq.fee = self.reNewPwd.field.text;
    
    [transferReq startRequest];
    
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    CGFloat webViewX = 0;
    CGFloat webViewY = 0;
    CGFloat webViewW = SGQRCodeScreenWidth;
    CGFloat webViewH = SGQRCodeScreenHeight;
    self.webView = [SGWebView webViewWithFrame:CGRectMake(webViewX, webViewY, webViewW, webViewH-64)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.jump_URL]]];
    _webView.progressViewColor = [UIColor redColor];
    [_webView sizeToFit];
    _webView.SGQRCodeDelegate = self;
    [self.view addSubview:_webView];
}

- (void)webView:(SGWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    self.navLabel.text = webView.navigationItemTitle;
}

@end


