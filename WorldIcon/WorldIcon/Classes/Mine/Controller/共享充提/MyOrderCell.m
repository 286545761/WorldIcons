//
//  MyOrderCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MyOrderCell.h"

@interface MyOrderCell ()

@property (nonatomic,strong)UILabel *CTTitle;
@property (nonatomic,strong)UILabel *CTType;
@property (nonatomic,strong)UILabel *CTAccount;
@property (nonatomic,strong)UILabel *CTTime;
@property (nonatomic,strong)UILabel *line;

@end

@implementation MyOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    [self.contentView addSubview:line];
    self.line = line;
    
    //标题
    UILabel *CTTitle = [UILabel gc_labelWithTitle:@"极客陈" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:CTTitle];
    self.CTTitle = CTTitle;
    
    //类型
    UILabel *CTType = [UILabel gc_labelWithTitle:@"业务类型：充值" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentRight)];
    [self.contentView addSubview:CTType];
    self.CTType = CTType;
    
    //金额
    UILabel *CTAccount = [UILabel gc_labelWithTitle:@"金额：$1000" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:CTAccount];
    self.CTAccount = CTAccount;
    
    //申请时间
    UILabel *CTTime = [UILabel gc_labelWithTitle:@"提交时间：2017-10-23 17:53:58" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:CTTime];
    self.CTTime = CTTime;

}
- (void)setModel:(GXCTModel *)model{
    /*
     @property (nonatomic,strong)UILabel *CTTitle;
     @property (nonatomic,strong)UILabel *CTType;
     @property (nonatomic,strong)UILabel *CTAccount;
     @property (nonatomic,strong)UILabel *CTTime;
     */
    
    self.CTTitle.text = [NSString stringWithFormat:@"%@",model.vra_sq_name];
    NSString *type;
    switch ([model.vra_type intValue]) {
        case 0:
            type = [NSString stringWithFormat:@"业务类型：充值"];
            break;
        case 1:
            type = [NSString stringWithFormat:@"业务类型：提现"];
            break;
        default:
            break;
    }
    self.CTType.text = [NSString stringWithFormat:@"%@",type];
    
    self.CTAccount.text = [NSString stringWithFormat:@"金额：$%@",model.vra_fee];
    
    self.CTTime.text = [NSString stringWithFormat:@"提交时间：%@",model.vra_date];
    
}

/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(0);
        make.right.mas_equalTo(self).offset(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self).offset(0);
    }];
    
    [self.CTTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(10));
        make.width.mas_equalTo(kRatioX6(100));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.line).offset(10);
    }];
    [self.CTType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRatioX6(180));
        make.right.mas_equalTo(self).offset(-kRatioX6(10));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self).offset(10);
    }];
    [self.CTAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(10));
        make.right.mas_equalTo(self).offset(-kRatioX6(10));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.CTType.mas_bottom).offset(10);
    }];
    
    [self.CTTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kRatioX6(10));
        make.right.mas_equalTo(self).offset(-kRatioX6(10));
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.CTAccount.mas_bottom).offset(10);
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
