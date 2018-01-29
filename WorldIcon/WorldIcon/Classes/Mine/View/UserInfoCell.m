//
//  UserInfoCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCell ()
@property (nonatomic,strong)UIView *backView;
@end

@implementation UserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
    
}
-(void)setUpView{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    //属性
    UILabel *leftLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.backView addSubview:leftLabel];
    self.leftLabel = leftLabel;
    
    //值
    UILabel *rightLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:(NSTextAlignmentRight)];
    [self.backView addSubview:rightLabel];
    self.rightLabel.text = @"请设置";
    self.rightLabel = rightLabel;
    //右侧箭头
    UIImageView *arrow = [[UIImageView alloc]init];//WithFrame:CGRectMake(75, 48, 150, 20)
    arrow.image = [UIImage imageNamed:@"钱包箭头"];
    [self.backView addSubview:arrow];
    self.arrow = arrow;
    
    self.headerImage = [[UIImageView alloc] init];
    self.headerImage.hidden = YES;
    self.headerImage.layer.cornerRadius = 55.0f/2;
    self.headerImage.layer.masksToBounds = YES;
    [self.backView addSubview:self.headerImage];
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView).offset(-5);
        make.top.mas_equalTo(self.contentView).offset(0);
    }];
    
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
        make.centerY.mas_equalTo(self.backView.mas_centerY);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.centerY.mas_equalTo(self.backView.mas_centerY);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrow.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(250, 20));
        make.centerY.mas_equalTo(self.backView.mas_centerY);
    }];
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrow.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(55, 55));
        make.centerY.mas_equalTo(self.backView.mas_centerY);
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
