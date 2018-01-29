//
//  GCVerificationCodeView.m
//  rrhb
//
//  Created by 陈潇 on 17/2/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCVerificationCodeView.h"

@interface GCVerificationCodeView ()

@property (nonatomic,strong)UILabel  *verticalLine;

@end

@implementation GCVerificationCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    self.verticalLine = [[UILabel alloc]init];
    self.verticalLine.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [self addSubview:self.verticalLine];
    
    self.getverificationCodeBtn = [[UIButton alloc]init];
    [self.getverificationCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    self.getverificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.getverificationCodeBtn setTitleColor:[UIColor gc_colorWithHexString:@"#ff9900"] forState:(UIControlStateNormal)];
    [self addSubview:self.getverificationCodeBtn];

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@1);
    }];
    
    [self.getverificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalLine.mas_right).offset(5);
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(10);
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
