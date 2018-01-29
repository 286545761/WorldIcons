//
//  CurrentProgressHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/31.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CurrentProgressHeaderView.h"

@interface CurrentProgressHeaderView ()

@property (nonatomic,strong)UILabel *CTType;
@property (nonatomic,strong)UILabel *CTName;
@property (nonatomic,strong)UILabel *CTAccount;

@end

@implementation CurrentProgressHeaderView

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary *)dic{
    if ([super initWithFrame:frame]) {
        [self setUpView:dic];
    }
    return self;
}
-(void)setUpView:(NSDictionary *)dic{
    
    self.backgroundColor = [UIColor whiteColor];

    //业务类型
    UILabel *CTType = [UILabel gc_labelWithTitle:[NSString stringWithFormat:@"共享者账户名字:%@",dic[@"vra_gx_name"]] withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self addSubview:CTType];
    self.CTType = CTType;
    //申请者账户名
    UILabel *CTName = [UILabel gc_labelWithTitle:[NSString stringWithFormat:@"共享者银行账户:%@",dic[@"vra_gx_yhzh"]] withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self addSubview:CTName];
    self.CTName = CTName;
    //金额
    UILabel *CTAccount = [UILabel gc_labelWithTitle:[NSString stringWithFormat:@"金额：$%@",dic[@"vra_fee"]] withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self addSubview:CTAccount];
    self.CTAccount = CTAccount;

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    
    [self.CTType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(10));
        make.right.mas_equalTo(self).offset(-kRatioX6(10));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self).offset(10);
    }];
    
    [self.CTName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(10));
        make.right.mas_equalTo(self).offset(-kRatioX6(10));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.CTType.mas_bottom).offset(10);
    }];
    
    [self.CTAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(10));
        make.right.mas_equalTo(self).offset(-kRatioX6(10));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.CTName.mas_bottom).offset(10);
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
