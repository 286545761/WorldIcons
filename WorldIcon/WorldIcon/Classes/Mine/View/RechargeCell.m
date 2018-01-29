//
//  RechargeCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/20.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "RechargeCell.h"

@interface RechargeCell ()

@property (nonatomic,strong) UILabel *khhTitle;
@property (nonatomic,strong) UILabel *yhkhTitle;
@property (nonatomic,strong) UILabel *khh;
@property (nonatomic,strong) UILabel *yhkh;

@end

@implementation RechargeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
 
    //开户行
    UILabel *khhTitle = [UILabel gc_labelWithTitle:@"开户行" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentRight)];
    [self.contentView addSubview:khhTitle];
    self.khhTitle = khhTitle;
    //银行卡号
    UILabel *yhkhTitle = [UILabel gc_labelWithTitle:@"银行卡号" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentRight)];
    [self.contentView addSubview:yhkhTitle];
    self.yhkhTitle = yhkhTitle;
    
    UILabel *khh = [UILabel gc_labelWithTitle:@"中国建设银行" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:khh];
    self.khh = khh;
    
    UILabel *yhkh =[UILabel gc_labelWithTitle:@"1234567890908765" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:yhkh];
    yhkh.userInteractionEnabled = YES;
    self.yhkh = yhkh;
    
    UITapGestureRecognizer * tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.yhkh addGestureRecognizer:tapGr];

}
-(void)handleTap{
    
    if (self.block) {
        self.block(self.yhkh.text);
    }
    
}
- (void)setModel:(CardModel *)model{

    if (model.uc_khh) {
        self.khh.text = [NSString stringWithFormat:@"%@",model.uc_khh];
    }
    if (model.uc_card) {
        self.yhkh.text = [NSString stringWithFormat:@"%@",model.uc_card];
    }
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.khhTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(0);
        make.top.mas_equalTo(self.contentView).offset(19);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.28, 20));
    }];
    
    [self.yhkhTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(0);
        make.top.mas_equalTo(self.khhTitle.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.28, 20));
    }];
    
    [self.khh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(0);
        make.left.mas_equalTo(self.khhTitle.mas_right).offset(15);
        make.top.mas_equalTo(self.contentView).offset(19);
        make.height.mas_equalTo(20);
    }];
    
    [self.yhkh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(0);
        make.left.mas_equalTo(self.yhkhTitle.mas_right).offset(15);
        make.top.mas_equalTo(self.khhTitle.mas_bottom).offset(15);
        make.height.mas_equalTo(20);
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
