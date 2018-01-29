//
//  PriceSectionHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/21.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "PriceSectionHeaderView.h"

@interface PriceSectionHeaderView ()

@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *countLabel;

@end
@implementation PriceSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    self.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    
    //价格/元
    UILabel *priceLabel = [UILabel gc_labelWithTitle:@"价格/元" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: priceLabel];
    self.priceLabel = priceLabel;
    //数量
    UILabel *countLabel =  [UILabel gc_labelWithTitle:@"数量/手" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: countLabel];
    self.countLabel = countLabel;
    
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(70);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(70), kRatioY6(35)));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-70);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(70), kRatioY6(35)));
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
