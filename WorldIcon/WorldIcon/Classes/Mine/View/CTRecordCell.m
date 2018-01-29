//
//  CTRecordCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CTRecordCell.h"

@interface CTRecordCell ()

@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *meiyuanLabel;
@property (nonatomic,strong) UILabel *operateLabel;


@end

@implementation CTRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    self.contentView.backgroundColor = [UIColor whiteColor];
    //时间
    UILabel *dateLabel = [UILabel gc_labelWithTitle:@"2017-10-21 12:11:34" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview: dateLabel];
    self.dateLabel = dateLabel;
    //美元
    UILabel *meiyuanLabel =  [UILabel gc_labelWithTitle:@"$100" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview: meiyuanLabel];
    self.meiyuanLabel = meiyuanLabel;
    
    self.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    
    //操作
    UILabel *operateLabel =  [UILabel gc_labelWithTitle:@"充值" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview: operateLabel];
    self.operateLabel = operateLabel;
    
}
-(void)setModel:(VMGongxModel *)model{

    /*
     @property (nonatomic,strong) UILabel *dateLabel;
     @property (nonatomic,strong) UILabel *meiyuanLabel;
     @property (nonatomic,strong) UILabel *operateLabel;
     */
    self.dateLabel.text = [NSString stringWithFormat:@"%@",model.vra_date];

    self.meiyuanLabel.text = [NSString stringWithFormat:@"%@",model.vra_fee];
    NSString *str;
    switch ([model.vra_type intValue]) {
        case 0:
            str = @"充值";
            break;
        case 1:
            str = @"提现";
        default:
            break;
    }
    self.operateLabel.text = [NSString stringWithFormat:@"%@",str];

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, kRatioY6(35)));
    }];
    
    [self.meiyuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, kRatioY6(35)));
    }];
    
    [self.operateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.meiyuanLabel.mas_right).offset(0);
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
