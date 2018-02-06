//
//  HistoryCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "HistoryCell.h"

@interface HistoryCell ()
@property (nonatomic,strong) UIView *back;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *allMoneyLabel;
@property (nonatomic,strong) UILabel *numberPriceLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@end

@implementation HistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.back = [[UIView alloc]init];
    self.back.backgroundColor = [UIColor whiteColor];
    self.back.layer.cornerRadius = 5;
    self.back.layer.masksToBounds = YES;
    [self.contentView addSubview:self.back];
    
    //成交时间
    UILabel *timeLabel = [UILabel gc_labelWithTitle:@"15:03:57" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.back addSubview: timeLabel];
    self.timeLabel = timeLabel;
    //总金额
    UILabel *allMoneyLabel = [UILabel gc_labelWithTitle:@"4.00" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.back addSubview: allMoneyLabel];
    self.allMoneyLabel = allMoneyLabel;
    //数量/价格
    UILabel *numberPriceLabel =  [UILabel gc_labelWithTitle:@"100\n1.4" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.back addSubview: numberPriceLabel];
    numberPriceLabel.numberOfLines = 2;
    self.numberPriceLabel = numberPriceLabel;
    
    //委托类型
    UILabel *typeLabel =  [UILabel gc_labelWithTitle:@"买入" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.back addSubview: typeLabel];
    self.typeLabel = typeLabel;
    //状态
    UILabel *statusLabel =  [UILabel gc_labelWithTitle:@"全部交易" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.back addSubview: statusLabel];
    self.statusLabel = statusLabel;
    
//    UILabel *line = [[UILabel alloc]init];
//    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
//    [self addSubview:line];
//    self.line = line;
    
}
-(void)setModel:(ListModel *)model{

    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.vsb_time];
    
    self.allMoneyLabel.text = [NSString stringWithFormat:@"%@",model.vsb_fee];
    
    self.numberPriceLabel.text = [NSString stringWithFormat:@"%@\n%@",model.vsb_sbc,model.vsb_sb]; ;
   
    NSString *str2;
    if ([model.vsb_type isEqualToString:@"1"]) {
        str2 = @"买入";
        self.typeLabel.textColor = [UIColor gc_colorWithHexString:@"#cc3333"];
    }
    if ([model.vsb_type isEqualToString:@"0"]) {
        str2 = @"卖出";
        self.typeLabel.textColor = [UIColor gc_colorWithHexString:@"#129561"];
    }
    self.typeLabel.text = str2;
   
    
    /*
     0 撤销
     1 等待交易
     2 部分交易成功
     3 全部交易成功
     4 委托失败
     */
    
    NSString *str;
    if ([model.vsb_status isEqualToString:@"0"]) {
        str = @"撤销";
    }
    if ([model.vsb_status isEqualToString:@"1"]) {
        str = @"等待交易";
    }
    if ([model.vsb_status isEqualToString:@"2"]) {
        str = @"部分交易";
    }
    if ([model.vsb_status isEqualToString:@"3"]) {
        str = @"全部交易";
    }
    if ([model.vsb_status isEqualToString:@"4"]) {
        str = @"委托失败";
    }
    self.statusLabel.text = str;
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-20-20)/5, kRatioY6(35)));
    }];
    [self.allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(0);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-20-20)/5, kRatioY6(35)));
    }];
    
    [self.numberPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allMoneyLabel.mas_right).offset(0);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-20-20)/5, kRatioY6(35)));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberPriceLabel.mas_right).offset(0);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-20-20)/5, kRatioY6(35)));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(0);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-20-20)/5, kRatioY6(35)));
    }];
    
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(0);
//        make.right.equalTo(self).offset(0);
//        make.height.equalTo(@1);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom);
//    }];
    [super updateConstraints];
    
}
/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}

@end
