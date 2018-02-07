//
//  ConfirmTransferMoneyView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/2.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ConfirmTransferMoneyView.h"

@interface ConfirmTransferMoneyView ()


@property (nonatomic,strong) InputView *hkPhotoLabel;
@property (nonatomic,strong)UIImageView *photo;
@property (nonatomic,strong)UIButton *submitBtn;
@end

@implementation ConfirmTransferMoneyView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    //汇款金额
    InputView *hkjeLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款金额" withPlaceholder:@"请选择汇款金额"];
    [self addSubview:hkjeLabel];
    self.hkjeLabel = hkjeLabel;
    
    //汇款时间
    InputView *hktimeLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款时间" withPlaceholder:@"请输入汇款时间"];
    [self addSubview:hktimeLabel];
    self.hktimeLabel = hktimeLabel;
    
    //汇款截图
    InputView *hkPhotoLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 76, kScreenWidth-60, 35) withTitle:@"汇款截图" withPlaceholder:@""];
    [self addSubview:hkPhotoLabel];
    self.hkPhotoLabel = hkPhotoLabel;
    self.hkPhotoLabel.field.hidden = YES;
    
    self.photo = [UIImageView new];
    self.photo.backgroundColor = [UIColor gc_colorWithHexString:@"#cc3333"];
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
-(void)submitAction{

    if (self.submitBlock) {
        self.submitBlock();
    }

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.hkjeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self).offset(15);
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
