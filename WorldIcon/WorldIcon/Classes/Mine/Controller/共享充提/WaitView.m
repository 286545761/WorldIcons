//
//  WaitView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WaitView.h"

@interface WaitView ()

@property (nonatomic,strong)UIImageView *bgView;
@property (nonatomic,strong)UILabel *textLabel;

@end

@implementation WaitView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    //背景图片
    UIImageView *bgView = [UIImageView new];
    bgView.image = [UIImage imageNamed:@"loading"];
    [self addSubview:bgView];
    self.bgView = bgView;
    //文字提示
    UILabel *textLabel = [UILabel gc_labelWithTitle:@"您的申请已提交，正在处理中..." withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:17 withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:textLabel];
    self.textLabel = textLabel;
    
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRatioY6(240));
        make.width.mas_equalTo(kRatioX6(125));
        make.top.mas_equalTo(self).offset(105);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(25));
        make.right.mas_equalTo(self).offset(-kRatioX6(25));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(45);
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
