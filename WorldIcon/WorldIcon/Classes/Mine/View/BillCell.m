//
//  BillCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BillCell.h"

@interface BillCell ()

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UIView *back;

@end

@implementation BillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.back = [[UIView alloc]init];
    self.back.backgroundColor = [UIColor whiteColor];
    self.back.layer.cornerRadius = 5;
    self.back.layer.masksToBounds = YES;
    [self.contentView addSubview:self.back];
    
    //购买欧力币
    UILabel *nameLabel = [UILabel gc_labelWithTitle:@"购买欧力币" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.back addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //日期
    UILabel *dateLabel =[UILabel gc_labelWithTitle:@"2017/07/18 15:34:55" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    [self.back addSubview:dateLabel];
    self.dateLabel = dateLabel;
    //支出
    UILabel *countLabel = [UILabel gc_labelWithTitle:@"支出1000元" withTextColor:[UIColor gc_colorWithHexString:@"#cc3333"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
    [self.back addSubview:countLabel];
    self.countLabel = countLabel;
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
        make.top.mas_equalTo(self.contentView).offset(0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(100), kRatioY6(20)));
        make.top.mas_equalTo(self.back).offset(15);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(250), kRatioY6(20)));
        make.bottom.mas_equalTo(self.back.mas_bottom).offset(-15);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.back).offset(0);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth-20)/2, kRatioY6(20)));
        make.centerY.mas_equalTo(self.back.mas_centerY);
    }];
    
    [super updateConstraints];
    
}
- (void)setModel:(BillModel *)model{

    if (model.co_date) {
        self.dateLabel.text = [NSString stringWithFormat:@"%@",model.co_date];
    }
    if (model.co_info) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@",model.co_info];
    }
    if (model.co_num) {
        self.countLabel.text = [NSString stringWithFormat:@"%@",model.co_num];
    }
}
/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}


@end
