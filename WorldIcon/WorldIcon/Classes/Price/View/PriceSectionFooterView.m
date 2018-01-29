//
//  PriceSectionFooterView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/21.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "PriceSectionFooterView.h"

@interface PriceSectionFooterView ()

@property (nonatomic,strong)UIButton *buyBtn;
@property (nonatomic,strong)UIButton *saleBtn;

@end

@implementation PriceSectionFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    UIButton *buyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"买入" withRadius:16];
    [buyBtn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    buyBtn.tag = 2003;
    [self addSubview:buyBtn];
    self.buyBtn = buyBtn;
    
    UIButton *saleBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#cc9900"] withTitle:@"卖出" withRadius:16];
    saleBtn.tag = 2004;
    [saleBtn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:saleBtn];
    self.saleBtn = saleBtn;
    
}
-(void)buttonAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(priceSectionViewFooterView:didClickButton:)]) {
        [self.delegate priceSectionViewFooterView:self didClickButton:sender.tag];
    }

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{

    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(35)));
    }];

    [self.saleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(35)));
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
