//
//  EntrustCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "EntrustCell.h"

@interface EntrustCell ()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *numberPriceLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong)UILabel *line;
@end

@implementation EntrustCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    //委托时间
    UILabel *timeLabel = [UILabel gc_labelWithTitle:@"2017-10-21 12:22:45" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: timeLabel];
    self.timeLabel = timeLabel;
    //数量/价格
    UILabel *numberPriceLabel =  [UILabel gc_labelWithTitle:@"100/2.30" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: numberPriceLabel];
    self.numberPriceLabel = numberPriceLabel;
    
    //委托类型
    UILabel *typeLabel =  [UILabel gc_labelWithTitle:@"买入" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: typeLabel];
    self.typeLabel = typeLabel;
    //状态
    UILabel *statusLabel =  [UILabel gc_labelWithTitle:@"全部交易" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview: statusLabel];
    self.statusLabel = statusLabel;
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [self addSubview:line];
    self.line = line;
    
}
-(void)setModel:(BuySellModel *)model{

    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.datetime];
    self.numberPriceLabel.text = [NSString stringWithFormat:@"%@/%@",model.vb_bc,model.vb_b];
    
    NSString *str2;
    if ([model.type isEqualToString:@"1"]) {
        str2 = @"买入";
    }
    if ([model.type isEqualToString:@"2"]) {
        str2 = @"卖出";
    }
    self.typeLabel.text = str2;

    NSString *str;
    if ([model.vb_status isEqualToString:@"0"]) {
        str = @"撤销";
    }
    if ([model.vb_status isEqualToString:@"1"]) {
        str = @"等待交易";
    }
    if ([model.vb_status isEqualToString:@"2"]) {
        str = @"部分交易";
    }
    if ([model.vb_status isEqualToString:@"3"]) {
        str = @"全部交易";
    }
    if ([model.vb_status isEqualToString:@"4"]) {
        str = @"委托失败";
    }
   
    self.statusLabel.text = str;
    
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
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.equalTo(@1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
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
