//
//  CurrentProgressCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/31.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CurrentProgressCell.h"

@interface CurrentProgressCell ()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIView *middleView;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UILabel *circle;

@end

@implementation CurrentProgressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    //左侧时间
    UILabel *leftLabel = [UILabel gc_labelWithTitle:@"2017-10-23 12：33：23" withTextColor:[UIColor gc_colorWithHexString:@"#e1ad34"] withTextFont:13 withTextAlignment:(NSTextAlignmentRight)];
    [self.contentView addSubview:leftLabel];
    self.leftLabel = leftLabel;
    
    //中间圆点 下划线
    UIView *middleView = [[UIView alloc]init];
    [self.contentView addSubview:middleView];
    self.middleView = middleView;
    
    UILabel *circle = [[UILabel alloc]init];
    circle.backgroundColor = [UIColor gc_colorWithHexString:@"#e1ad34"];
    circle.layer.masksToBounds = YES;
    circle.layer.cornerRadius = 5;
    [self.middleView addSubview:circle];
    self.circle = circle;
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#e1ad34"];
    [self.middleView addSubview:line];
    self.line = line;
    //右侧信息
    UILabel *rightLabel = [UILabel gc_labelWithTitle:@"oc_1125 已接单" withTextColor:[UIColor gc_colorWithHexString:@"#e1ad34"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:rightLabel];
    self.rightLabel = rightLabel;
   
    UIButton *confirmBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#e1ad34"] withTitle:@"确认" withRadius:2];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
    self.confirmBtn.hidden = YES;
    
    //右侧信息
    UILabel *rightBottomLabel = [UILabel gc_labelWithTitle:@"共享者确认收钱" withTextColor:[UIColor gc_colorWithHexString:@"#e1ad34"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:rightBottomLabel];
    self.rightBottomLabel = rightBottomLabel;
    self.rightBottomLabel.hidden = YES;
    
}
-(void)confirmAction{

    if (self.confirmBlock) {
        self.confirmBlock();
    }
}
-(void)setModel:(ReAppStatus *)model{

    self.leftLabel.text = [NSString stringWithFormat:@"%@ %@",model.vrs_date,model.vrs_time];
    
    self.rightLabel.text = [NSString stringWithFormat:@"%@",model.vrs_info];

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRatioX6(20));
        make.width.mas_equalTo(kScreenWidth*0.4);
        make.top.equalTo(self).offset(kRatioY6(0));
        make.height.equalTo(@30);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.top.equalTo(self).offset(kRatioY6(0));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    [self.circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@10);
        make.height.equalTo(@10);
        make.top.equalTo(self).offset(kRatioY6(10));
        make.centerX.equalTo(self.middleView.mas_centerX);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(kRatioY6(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(10);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kRatioX6(-20));
        make.width.mas_equalTo(kScreenWidth*0.4);
        make.top.equalTo(self).offset(kRatioY6(0));
        make.height.equalTo(@30);
    }];
    [self.rightBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line).offset(kRatioX6(10));
        make.width.mas_equalTo(kScreenWidth*0.3);
        make.bottom.equalTo(self).offset(kRatioY6(0));
        make.height.equalTo(@30);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kRatioX6(-10));
        make.width.mas_equalTo(kScreenWidth*0.15);
        make.bottom.equalTo(self).offset(kRatioY6(-5));
        make.height.equalTo(@24);
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
