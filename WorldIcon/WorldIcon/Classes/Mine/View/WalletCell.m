//
//  WalletCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WalletCell.h"
@interface WalletCell()
@property(nonatomic,strong)UIView *back;
@end
@implementation WalletCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    _back = [[UIView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, self.contentView.size.height)];
    _back.backgroundColor = [UIColor whiteColor];
    _back.layer.masksToBounds = YES;
    _back.layer.cornerRadius = 5;
    [self.contentView addSubview:_back];
    
    UILabel *leftLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.back addSubview:leftLabel];
    self.leftLabel = leftLabel;
    //右侧箭头
    UIImageView *arrow = [[UIImageView alloc]init];//WithFrame:CGRectMake(75, 48, 150, 20)
    arrow.image = [UIImage imageNamed:@"钱包箭头"];
    [self.back addSubview:arrow];
    self.arrow = arrow;
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
        make.centerY.mas_equalTo(self.back.mas_centerY);
    }];
   
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.back).offset(-10);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.centerY.mas_equalTo(self.back.mas_centerY);
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
