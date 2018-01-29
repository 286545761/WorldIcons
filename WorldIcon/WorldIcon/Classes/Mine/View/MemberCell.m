//
//  MemberCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MemberCell.h"

@interface MemberCell ()

@property (nonatomic,strong)UIImageView *arrow;

@end

@implementation MemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    UIImageView *photo = [UIImageView new];
    photo.layer.masksToBounds = YES;
    photo.layer.cornerRadius = 17.5;
    photo.image = [UIImage imageNamed:@"上传头像图片"];
    [self.contentView addSubview:photo];
    self.photo = photo;
    
    UILabel *name = [UILabel gc_labelWithTitle:@"昭" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:name];
    self.name = name;
    
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
    
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(35), kRatioY6(35)));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photo.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(9, 16));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(10);
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
