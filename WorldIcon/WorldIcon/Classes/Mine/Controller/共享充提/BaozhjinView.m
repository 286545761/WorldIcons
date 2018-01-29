//
//  BaozhjinView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BaozhjinView.h"

@interface BaozhjinView ()

@property (nonatomic,strong)InputView *hkPhotoLabel;
@property (nonatomic,strong)UIImageView *photo;
@property (nonatomic,strong)UIButton *submitBtn;

@end

@implementation BaozhjinView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    //汇款目标账号
    InputView *hkmbLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款目标账号" withPlaceholder:@"请选择汇款目标账号"];
    [self addSubview:hkmbLabel];
    self.hkmbLabel = hkmbLabel;
    
    //选择所在地
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(selecthkmb) forControlEvents:(UIControlEventTouchUpInside)];
    [rView addSubview:chooseBtn];
    
    self.hkmbLabel.field.rightViewMode = UITextFieldViewModeAlways;
    self.hkmbLabel.field.rightView = rView;

    
    //汇款账号
    InputView *hkLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款账号" withPlaceholder:@"请输入汇款账号"];
    [self addSubview:hkLabel];
    self.hkLabel = hkLabel;
    

    UIView *rView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    UIButton *chooseBtn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn3.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn3 setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn3 setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn3 addTarget:self action:@selector(selecthkzh) forControlEvents:(UIControlEventTouchUpInside)];
    [rView2 addSubview:chooseBtn3];
    
    self.hkLabel.field.rightViewMode = UITextFieldViewModeAlways;
    self.hkLabel.field.rightView = rView2;
    
    //汇款金额
    InputView *hkjeLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款金额" withPlaceholder:@"请输入汇款金额"];
    [self addSubview:hkjeLabel];
    self.hkjeLabel = hkjeLabel;
    //汇款时间
    InputView *hktimeLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款时间" withPlaceholder:@"请选择汇款时间"];
    [self addSubview:hktimeLabel];
    self.hktimeLabel = hktimeLabel;

    //选择所在地
    UIView *rView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    UIButton *chooseBtn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn1.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn1 setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn1 setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn1 addTarget:self action:@selector(selecthktime) forControlEvents:(UIControlEventTouchUpInside)];
    [rView1 addSubview:chooseBtn1];
    
    self.hktimeLabel.field.rightViewMode = UITextFieldViewModeAlways;
    self.hktimeLabel.field.rightView = rView1;
    
    //汇款截图
    InputView *hkPhotoLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款截图" withPlaceholder:@""];
    [self addSubview:hkPhotoLabel];
    self.hkPhotoLabel = hkPhotoLabel;
    self.hkPhotoLabel.field.hidden = YES;
    
    self.photo = [UIImageView new];
    self.photo.backgroundColor = [UIColor redColor];
    [self addSubview:self.photo];
    
    self.photo.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBtn:)];
    [self.photo addGestureRecognizer:tap];

    //提交按钮
    UIButton *submitBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交" withRadius:(35.5*0.5)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 2001;
    [self addSubview:submitBtn];
    self.submitBtn = submitBtn;

}
-(void)selecthkzh{
    if (self.zhBlock) {
        self.zhBlock();
    }
}
-(void)selecthktime{

    if (self.timeBlock) {
        self.timeBlock();
    }
    
}

-(void)selecthkmb{

    if (self.mbzhBlock) {
        self.mbzhBlock();
    }
}
-(void)tapBtn:(UITapGestureRecognizer *)sender{

    if (self.tapBlock) {
        self.tapBlock();
    }
}

-(void)submitAction{
    
    if (self.sumlimtBlock) {
        self.sumlimtBlock();
    }
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
 
    [self.hkmbLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self).offset(15);
    }];
    
    [self.hkLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.hkmbLabel.mas_bottom).offset(15);
    }];
    
    [self.hkjeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.hkLabel.mas_bottom).offset(15);
    }];
    
    [self.hktimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.hkjeLabel.mas_bottom).offset(15);
    }];

    [self.hkPhotoLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.hktimeLabel.mas_bottom).offset(15);
    }];

    [self.photo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hkPhotoLabel.titleLabel.mas_right).offset(kRatioX6(10));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(kRatioY6(200));
        make.top.mas_equalTo(self.hktimeLabel.mas_bottom).offset(15);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRatioX6(25));
        make.right.equalTo(self).offset(kRatioX6(-25));
        make.height.equalTo(@40);
        make.top.equalTo(self.photo.mas_bottom).offset(kRatioY6(25));
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
