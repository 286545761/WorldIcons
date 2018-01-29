//
//  MemberHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MemberHeaderView.h"

@interface MemberHeaderView ()

@property (nonatomic,strong)UILabel *hyCountLabel;

@end

@implementation MemberHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    UILabel *hyCountLabel = [UILabel gc_labelWithTitle:@"邀请会员：10人" withTextColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTextFont:17 withTextAlignment:(NSTextAlignmentLeft)];
    [self addSubview:hyCountLabel];
    self.hyCountLabel = hyCountLabel;
    
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.hyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
        make.centerY.mas_equalTo(self.mas_centerY);
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
