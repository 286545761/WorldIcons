//
//  SendMsgView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "SendMsgView.h"

@interface SendMsgView ()



@end

@implementation SendMsgView

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic{
    if ([super initWithFrame:frame]) {
        [self setUpView:dic];
    }
    return self;
}
-(void)setUpView:(NSDictionary *)dic{

    NSDictionary *userInfo = dic[@"vm_rere"];
    
    //账户名字
    InputView *username = [[InputView alloc] initWithFrame:CGRectZero withTitle:@"账户名字" withPlaceholder:@"请输入持有人"];
    username.field.text = userInfo[@"vr_name"];
    [self addSubview:username];
    self.username = username;
    //开发行
    InputView *khhAddress = [[InputView alloc] initWithFrame:CGRectZero withTitle:@"开户行地址" withPlaceholder:@"请输入开户行"];
    khhAddress.field.text = userInfo[@"vr_khh"];
    [self addSubview:khhAddress];
    self.khhAddress = khhAddress;
    //银行账户
    InputView *cardNumber = [[InputView alloc] initWithFrame:CGRectZero withTitle:@"银行账户" withPlaceholder:@"请输入卡号"];
    cardNumber.field.text = userInfo[@"vr_yhzh"];
    [self addSubview:cardNumber];
    self.cardNumber = cardNumber;
    //地址
    InputView *userAddress = [[InputView alloc] initWithFrame:CGRectZero withTitle:@"地址" withPlaceholder:@""];
    if (dic) {
        userAddress.field.text = [NSString stringWithFormat:@"%@%@",userInfo[@"vr_sf"],userInfo[@"vr_cs"]];
    }else{
        userAddress.field.text = @"";
    }
    
    [self addSubview:userAddress];
    self.userAddress = userAddress;
    
    //选择所在地
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(selectAddress) forControlEvents:(UIControlEventTouchUpInside)];
    [rView addSubview:chooseBtn];
    self.userAddress.field.rightViewMode = UITextFieldViewModeAlways;
    self.userAddress.field.rightView = rView;
    //提交按钮
    UIButton *sendBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交" withRadius:(35.5*0.5)];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendBtn];
    self.sendBtn = sendBtn;

}
-(void)sendAction{
    
    if (self.block) {
        self.block();
    }
}
//选择地区按钮
-(void)selectAddress{
    
    [self endEditing:YES];
    
    _addressPickerView = [OSAddressPickerView shareInstance];
    [_addressPickerView showBottomView];
    [self addSubview:_addressPickerView];
    
    @weakify(self);
    _addressPickerView.block = ^(NSString *province,NSString *city,NSString *district)
    {
        @strongify(self);
        self.userAddress.field.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
        
        _province = province;
        _city = city;
        _district = district;
    };
    
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{

    [self.username mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self).offset(45);
    }];
    
    [self.khhAddress mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.username.mas_bottom).offset(15);
    }];
    
    [self.cardNumber mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.khhAddress.mas_bottom).offset(15);
    }];
    
    [self.userAddress mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.cardNumber.mas_bottom).offset(15);
    }];

    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRatioX6(20));
        make.right.equalTo(self).offset(kRatioX6(-20));
        make.top.equalTo(self.userAddress.mas_bottom).offset(kRatioY6(25));
        make.height.equalTo(@40);
    }];
    
    [super updateConstraints];
    
}

/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}

@end
