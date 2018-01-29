//
//  BaseInfoView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BaseInfoView.h"
#import "RegisterInputView.h"

@interface BaseInfoView ()

@property (nonatomic,strong)RegisterInputView *username;
@property (nonatomic,strong)RegisterInputView *khhAddress;
@property (nonatomic,strong)RegisterInputView *khhAccount;
@property (nonatomic,strong)RegisterInputView *province;
@property (nonatomic,strong)RegisterInputView *city;
@property (nonatomic,strong)RegisterInputView *baozhj;

@property (nonatomic,strong)UIButton *sendBtn;

@property (nonatomic,strong)UIButton *editBtn;
@end

@implementation BaseInfoView

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic{
    if ([super initWithFrame:frame]) {
        [self setUpViewWithDic:dic];
    }
    return self;
}
-(void)setUpViewWithDic:(NSDictionary *)dic{
    
    NSDictionary *userInfo = dic[@"vm_rere"];
    
    NSDictionary *userBaozhj = dic[@"vm_bzj"];
    
    //账户名字
    RegisterInputView *username = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"账户名字" withPlaceholder:@"请输入"];
    username.layer.borderWidth = 0.0;
    username.userInteractionEnabled = NO;
    username.field.text = userInfo[@"vr_name"];
    [self addSubview:username];
    self.username = username;
    
    //开户行地址
    RegisterInputView *khhAddress = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"开户行地址" withPlaceholder:@"请输入"];
    khhAddress.userInteractionEnabled = NO;
    khhAddress.layer.borderWidth = 0.0;
    khhAddress.field.text = userInfo[@"vr_khh"];
    [self addSubview:khhAddress];
    self.khhAddress = khhAddress;
    //银行账户
    RegisterInputView *khhAccount = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"银行账户" withPlaceholder:@"请输入"];
    khhAccount.userInteractionEnabled = NO;
    khhAccount.layer.borderWidth = 0.0;
    khhAccount.field.text = userInfo[@"vr_yhzh"];
    [self addSubview:khhAccount];
    self.khhAccount = khhAccount;
    
    //省份
    RegisterInputView *province = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"省份" withPlaceholder:@"请输入"];
    province.userInteractionEnabled = NO;
    province.layer.borderWidth = 0.0;
    province.field.text = userInfo[@"vr_sf"];
    [self addSubview:province];
    self.province = province;
    //城市
    RegisterInputView *city = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"城市" withPlaceholder:@"请输入"];
    city.userInteractionEnabled = NO;
    city.layer.borderWidth = 0.0;
    city.field.text = userInfo[@"vr_cs"];
    [self addSubview:city];
    self.city = city;
    //保证金
    RegisterInputView *baozhj = [[RegisterInputView alloc] initWithFrame:CGRectZero withTitle:@"保证金" withPlaceholder:@"请输入"];
    baozhj.userInteractionEnabled = NO;
    baozhj.layer.borderWidth = 0.0;
    NSString *str = [NSString stringWithFormat:@"%@",userBaozhj[@"vb_bzj"]];
    baozhj.field.text = str.length == 0 ? @"未交保证金" : str;
    [self addSubview:baozhj];
    self.baozhj = baozhj;
    
    //提交按钮
    UIButton *sendBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交保证金" withRadius:(35.5*0.5)];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sendBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.tag = 2001;
    [self addSubview:sendBtn];
    self.sendBtn = sendBtn;
    
    //编辑按钮
    UIButton *editBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#aa9900"] withTitle:@"编辑个人信息" withRadius:(35.5*0.5)];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [editBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    editBtn.tag = 2002;
    [self addSubview:editBtn];
    self.editBtn = editBtn;
}
-(void)btnAction:(UIButton *)sender{

    if (self.block) {
        self.block(sender.tag);
    }
    
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.username mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self).offset(30);
    }];
    [self.khhAddress mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.username.mas_bottom).offset(15);
    }];
    [self.khhAccount mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.khhAddress.mas_bottom).offset(15);
    }];
    [self.province mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.khhAccount.mas_bottom).offset(15);
    }];
    [self.city mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.province.mas_bottom).offset(15);
    }];
    [self.baozhj mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.city.mas_bottom).offset(15);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRatioX6(25));
        make.right.equalTo(self).offset(kRatioX6(-25));
        make.height.equalTo(@40);
        make.top.equalTo(self.baozhj.mas_bottom).offset(kRatioY6(25));
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRatioX6(25));
        make.right.equalTo(self).offset(kRatioX6(-25));
        make.height.equalTo(@40);
        make.top.equalTo(self.sendBtn.mas_bottom).offset(kRatioY6(25));
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
