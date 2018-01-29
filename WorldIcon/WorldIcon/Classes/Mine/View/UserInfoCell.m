//
//  UserInfoCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCell ()
@property (nonatomic,strong)UIImageView *arrow;
@end

@implementation UserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
    
}
-(void)setUpView{

    //属性
    UILabel *leftLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
//    leftLabel.backgroundColor = arc4randomColor;
    [self.contentView addSubview:leftLabel];
    self.leftLabel = leftLabel;
    //值
    UILabel *rightLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:(NSTextAlignmentRight)];
//    rightLabel.backgroundColor = arc4randomColor;
    [self.contentView addSubview:rightLabel];
    self.rightLabel = rightLabel;
    //右侧箭头
    UIImageView *arrow = [[UIImageView alloc]init];//WithFrame:CGRectMake(75, 48, 150, 20)
    arrow.image = [UIImage imageNamed:@"钱包箭头"];
    [self.contentView addSubview:arrow];
    self.arrow = arrow;
    //分割线
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [self.contentView addSubview:line];
    self.line = line;
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrow.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(250, 20));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.mas_equalTo(self.contentView).offset(-1);
        make.height.equalTo(@1);
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
