//
//  EntrustHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "EntrustHeaderView.h"

@interface EntrustHeaderView ()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *numberPriceLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *statusLabel;


@end

@implementation EntrustHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    self.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    
    //委托时间
    UILabel *timeLabel = [UILabel gc_labelWithTitle:@"委托时间" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: timeLabel];
    self.timeLabel = timeLabel;
    //数量/价格
    UILabel *numberPriceLabel =  [UILabel gc_labelWithTitle:@"数量/价格" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: numberPriceLabel];
    self.numberPriceLabel = numberPriceLabel;
 
    //委托类型
    UILabel *typeLabel =  [UILabel gc_labelWithTitle:@"委托类型" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: typeLabel];
    self.typeLabel = typeLabel;
    //状态
    UILabel *statusLabel =  [UILabel gc_labelWithTitle:@"状态" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: statusLabel];
    self.statusLabel = statusLabel;
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, kRatioY6(35)));
    }];
    
    [self.numberPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, kRatioY6(35)));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberPriceLabel.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, kRatioY6(35)));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, kRatioY6(35)));
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
