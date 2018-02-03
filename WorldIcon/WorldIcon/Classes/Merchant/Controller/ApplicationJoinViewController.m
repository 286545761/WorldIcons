//
//  ApplicationJoinViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ApplicationJoinViewController.h"
#import "InputView.h"
#import "OSAddressPickerView.h"
#import "AgentRequest.h"

@interface ApplicationJoinViewController ()
{
    NSString *_province;
    NSString *_city;
    NSString *_district;
}
@property (nonatomic,strong)OSAddressPickerView *addressPickerView;
@property (nonatomic,strong)InputView *sjdzLabel;

@property (nonatomic,strong)InputView *sjmcLabel;
@property (nonatomic,strong)InputView *hyflLabel;
@property (nonatomic,strong)InputView *dzxmLabel;
@property (nonatomic,strong)InputView *lxdhLabel;
@property (nonatomic,strong)InputView *szdLabel;
@property (nonatomic,strong)InputView *sjjsLabel;
@property (nonatomic,strong)UIScrollView *mainScrolView;
@end

@implementation ApplicationJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLabel.text = @"申请入驻";
    
    UIScrollView *mainScrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mainScrolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainScrolView];

    //商家名称
    InputView *sjmcLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 31, kScreenWidth-60, 35) withTitle:@"商家名称" withPlaceholder:@"请输入商家名称"];
    [mainScrolView addSubview:sjmcLabel];
    self.sjmcLabel = sjmcLabel;
    //行业分类
    InputView *hyflLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"行业分类" withPlaceholder:@"请输入行业分类"];
    [mainScrolView addSubview:hyflLabel];
    self.hyflLabel = hyflLabel;
    //店主姓名
    InputView *dzxmLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 121, kScreenWidth-60, 35) withTitle:@"店主姓名" withPlaceholder:@"请输入店主姓名"];
    [mainScrolView addSubview:dzxmLabel];
    self.dzxmLabel = dzxmLabel;
    
    //联系电话
    InputView *lxdhLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 166, kScreenWidth-60, 35) withTitle:@"联系电话" withPlaceholder:@"请输入联系电话"];
    [mainScrolView addSubview:lxdhLabel];
    self.lxdhLabel = lxdhLabel;
    
    //商家地址
    self.sjdzLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 211, kScreenWidth-60, 35) withTitle:@"商家地址" withPlaceholder:@"请选择商家地址"];
    [mainScrolView addSubview:self.sjdzLabel];
    
    //选择所在地
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(selectAddress) forControlEvents:(UIControlEventTouchUpInside)];
    [rView addSubview:chooseBtn];
    
    self.sjdzLabel.field.rightViewMode = UITextFieldViewModeAlways;
    self.sjdzLabel.field.rightView = rView;

    //所在地
    InputView *szdLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 256, kScreenWidth-60, 35) withTitle:@"详细地址" withPlaceholder:@"请输入详细地址"];
    [mainScrolView addSubview:szdLabel];
    self.szdLabel = szdLabel;
    //商家介绍
    InputView *sjjsLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 301, kScreenWidth-60, 35) withTitle:@"商家介绍" withPlaceholder:@"请输入商家介绍"];
    [mainScrolView addSubview:sjjsLabel];
    self.sjjsLabel = sjjsLabel;
    //提交按钮
    UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交" withRadius:(35.5*0.5)];
    submitBtn.frame = CGRectMake(30, 362, kScreenWidth-60, 35);
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
    [mainScrolView addSubview:submitBtn];

    self.mainScrolView = mainScrolView;
    
}
//选择地区按钮
-(void)selectAddress{

    [self.view endEditing:YES];
    
    _addressPickerView = [OSAddressPickerView shareInstance];
    [_addressPickerView showBottomView];
    [self.view addSubview:_addressPickerView];
    
    __weak typeof(self) weakSelf = self;
    
    _addressPickerView.block = ^(NSString *province,NSString *city,NSString *district)
    {
        weakSelf.sjdzLabel.field.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
        
        _province = province;
        _city = city;
        _district = district;
        
    };
    
}
#pragma mark -- 提交按钮
-(void)submitBtn{
    [MBProgressHUD gc_showActivityMessageInWindow:@"提交中..."];

    AgentRequest *agentReq = [AgentRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            @weakify(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
            @strongify(self);
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
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
    
    agentReq.ub_id          = [UserManager getUID];
    if (self.sjmcLabel.field.text.length == 0) {
        
        [MBProgressHUD gc_showErrorMessage:@"商家名称不能为空"];
        return;
    }else{
        agentReq.vm_agent_name  = self.sjmcLabel.field.text; //商家名称
    }
    if (self.hyflLabel.field.text.length == 0) {
        [MBProgressHUD gc_showErrorMessage:@"行业分类不能为空"];

        return;
    }else{
        agentReq.vm_type        = self.hyflLabel.field.text; //行业分类
    }
    if (self.dzxmLabel.field.text.length == 0) {
        [MBProgressHUD gc_showErrorMessage:@"店主姓名不能为空"];

        return;
    }else{
        agentReq.vm_name        = self.dzxmLabel.field.text; //店主姓名
    }
    if (self.lxdhLabel.field.text.length == 0) {
        [MBProgressHUD gc_showErrorMessage:@"联系方式不能为空"];

        return;
    }else{
        if (![NSString gc_judgePhoneNumber:self.lxdhLabel.field.text]) {
            [MBProgressHUD gc_showErrorMessage:@"手机号输入有误"];

            return;
        }else{
            agentReq.vm_phone       = self.lxdhLabel.field.text; //联系电话
        }
    }
    if (_province.length == 0) {
        [MBProgressHUD gc_showErrorMessage:@"商家地址不能为空"];

        return;
    }else{
        agentReq.vm_province    = _province; //商家地址
        agentReq.vm_city        = _city;
        agentReq.vm_district    = _district;
    }

    agentReq.vm_address     = self.szdLabel.field.text; //详细地址
    agentReq.vm_introduce   = self.sjjsLabel.field.text;//商家介绍
    
    [agentReq startRequest];
}

@end
