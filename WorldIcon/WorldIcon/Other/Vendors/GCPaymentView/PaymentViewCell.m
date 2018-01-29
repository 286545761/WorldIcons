//
//  PaymentViewCell.m
//  bage
//
//  Created by 陈潇 on 17/4/24.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "PaymentViewCell.h"

@interface PaymentViewCell ()

@property (nonatomic,strong)UILabel *line;


@end

@implementation PaymentViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    

    UIImageView *payStyleImage = [UIImageView new];
//    payStyleImage.backgroundColor = arc4randomColor;
    [self.contentView addSubview:payStyleImage];
    self.payStyleImage = payStyleImage;

    UILabel *titleLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
//    UILabel *rightLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor redColor] withTextFont:14 withTextAlignment:(NSTextAlignmentRight)];
//    rightLabel.text = @"去充值";
////        rightLabel.backgroundColor = arc4randomColor;
//    [self.contentView addSubview:rightLabel];
//    self.rightLabel = rightLabel;
    
    //选中按钮
//    UIImageView *selectImage = [[UIImageView alloc]init];
//    selectImage.image = [UIImage imageNamed:@"usercenter_right_arrow"];
//    //    selecBtn.backgroundColor =arc4randomColor;
//    //    selectImage.hidden = YES;
//    [self.contentView addSubview:selectImage];
//    self.selectImage = selectImage;
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#999999" alpha:0.5];
    [self.contentView addSubview:line];
    self.line = line;
}

/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.payStyleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(23, 23));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payStyleImage.mas_right).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentView).offset(-100);
    }];
    
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 21));
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.selectImage.mas_left).offset(-10);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.height.mas_equalTo(0.5);
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
