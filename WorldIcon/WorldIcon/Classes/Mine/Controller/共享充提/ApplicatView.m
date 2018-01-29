//
//  ApplicatView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ApplicatView.h"

@interface ApplicatView ()

@property (nonatomic,strong)UIImageView *bgView;
@property (nonatomic,strong)UILabel     *textLabel;
@property (nonatomic,strong)UIButton    *appliBtn;

@end

@implementation ApplicatView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    //背景图片
    UIImageView *bgView = [UIImageView new];
    bgView.image = [UIImage imageNamed:@"applibg"];
    [self addSubview:bgView];
    self.bgView = bgView;
    //文字展示
    UILabel *textLabel = [UILabel gc_labelWithTitle:@"您暂时不是共享者用户，您可以申请成为共享者。\n您加入共享者，会获得相应的充值和提现的手续费回报。\n并根据充值和提现的数量提高相应的等级，等级从1级到10级。\n每一级都有不同的手续费，等级越高，手续费也越高！\n每一级都有不同的欧力币奖励！" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    textLabel.numberOfLines = 0;

    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 行间距设置为30
    [paragraphStyle  setLineSpacing:15];
    
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:textLabel.text];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textLabel.text length])];
    
    // 设置Label要显示的text
    [textLabel  setAttributedText:setString];
    
    [self.bgView addSubview:textLabel];
    self.textLabel = textLabel;
    
    //申请按钮
    UIButton *appliBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"申请" withRadius:(45*0.5)];
    appliBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [appliBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [appliBtn addTarget:self action:@selector(appliAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:appliBtn];
    self.appliBtn = appliBtn;
}

-(void)appliAction{

    if (self.block) {
        self.block();
    }
    
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRatioX6(20));
        make.right.equalTo(self).offset(kRatioX6(-20));
        make.top.equalTo(self).offset(kRatioY6(25));
        make.bottom.equalTo(self).offset(kRatioY6(-185));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(kRatioX6(30));
        make.right.equalTo(self.bgView.mas_right).offset(kRatioX6(-30));
        make.top.equalTo(self.bgView.mas_top).offset(kRatioY6(10));
        make.bottom.equalTo(self.bgView.mas_bottom).offset(kRatioY6(10));
    }];
    
    [self.appliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRatioX6(20));
        make.right.equalTo(self).offset(kRatioX6(-20));
        make.top.equalTo(self.textLabel.mas_bottom).offset(kRatioY6(25));
        make.height.equalTo(@45);
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
