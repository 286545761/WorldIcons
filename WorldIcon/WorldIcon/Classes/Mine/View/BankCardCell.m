//
//  BankCardCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BankCardCell.h"

@interface BankCardCell()

/** 银行卡背景色 */
@property (nonatomic, strong) UIImageView *cardBgView;

/** 银行图标 */
@property (nonatomic, strong) UIImageView *bankIcon;

/** 银行名字 */
@property (nonatomic, strong) UILabel *bankName;

/** 银行卡类型 */
@property (nonatomic, strong) UILabel *bankCardType;

/** 银行卡 末尾 */
@property (nonatomic, strong) UILabel *bankCardNumber;

@end

@implementation BankCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.cardBgView = [[UIImageView alloc]init];
//        self.cardBgView.backgroundColor = RandomColor;
    self.cardBgView.layer.masksToBounds = YES;
    self.cardBgView.layer.cornerRadius = 4;
    [self.contentView addSubview:self.cardBgView];
    
    self.bankIcon = [[UIImageView alloc]init];
//        self.bankIcon.backgroundColor = RandomColor;
    [self.cardBgView addSubview:self.bankIcon];
    
    self.bankName = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#ffffff"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
//        self.bankName.backgroundColor = RandomColor;
    [self.cardBgView addSubview:self.bankName];
    
    self.bankCardType = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#ffffff"] withTextFont:15 withTextAlignment:(NSTextAlignmentLeft)];
//        self.bankCardType.backgroundColor = RandomColor;
    [self.cardBgView addSubview:self.bankCardType];
    
    self.bankCardNumber = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#ffffff"] withTextFont:16 withTextAlignment:(NSTextAlignmentLeft)];
//        self.bankCardNumber.backgroundColor = RandomColor;
    self.bankCardNumber.textAlignment = NSTextAlignmentRight;
    [self.cardBgView addSubview:self.bankCardNumber];
    
}
-(void)setModel:(CardModel *)model{
//    if ([model.uc_khh isEqualToString:@""]) {
//        self.bankCardNumber.text = model.uc_card;
//        self.cardBgView.image = [UIImage imageNamed:@"zhifubaod"];
//        self.bankIcon.image = [UIImage imageNamed:@"zhifubaox"];
//        self.bankName.text = model.uc_name;
//        return;
//    }
    
    
    self.bankName.text = model.uc_khh;
    
    NSString *cardId = [model.uc_card substringFromIndex:model.uc_card.length - 4];
    
    self.bankCardNumber.text = [NSString stringWithFormat:@"**** **** **** %@",cardId];
    
  
    if ([model.uc_type isEqualToString:@"0"]) {
        if ([model.uc_khh isEqualToString:@"交通银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"交通背景"];
            self.bankIcon.image = [UIImage imageNamed:@"交通图标"];
        }
        if ([model.uc_khh isEqualToString:@"中国银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"中国银行背景@2x (1)"];
            self.bankIcon.image = [UIImage imageNamed:@"中国银行图标 (1)"];
        }
        if ([model.uc_khh isEqualToString:@"民生银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"民生背景"];
            self.bankIcon.image = [UIImage imageNamed:@"民生图标"];
        }
        if ([model.uc_khh isEqualToString:@"招商银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"招商背景"];
            self.bankIcon.image = [UIImage imageNamed:@"招商图标"];
        }
        if ([model.uc_khh isEqualToString:@"中国工商银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"工商背景"];
            self.bankIcon.image = [UIImage imageNamed:@"工商图标"];
        }
        if ([model.uc_khh isEqualToString:@"中国建设银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"建设背景"];
            self.bankIcon.image = [UIImage imageNamed:@"建设图标"];
        }
        if ([model.uc_khh isEqualToString:@"中国农业银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"农行背景"];
            self.bankIcon.image = [UIImage imageNamed:@"农行logo"];
        }
        
        if ([model.uc_khh isEqualToString:@"中国邮政银行"]) {
            self.cardBgView.image = [UIImage imageNamed:@"邮政背景"];
            self.bankIcon.image = [UIImage imageNamed:@"邮政图标"];
        }if ([model.uc_khh isEqualToString:@"其他"]) {
            self.cardBgView.image = [UIImage imageNamed:@"bank_other_bg"];
            self.bankIcon.image = [UIImage imageNamed:@"bank_other_icon"];
            self.bankCardType.text = model.uc_addr;
        }
        
    }else if ([model.uc_type isEqualToString:@"1"]){
        self.cardBgView.image = [UIImage imageNamed:@""];
        self.cardBgView.backgroundColor=RGBA(9, 92, 11, 0.7);
        self.bankIcon.image = [UIImage imageNamed:@"微信"];
               self.bankName.text = model.uc_name;
    }else{// 支付宝
        

                self.cardBgView.image = [UIImage imageNamed:@"zhifubaod"];
                self.bankIcon.image = [UIImage imageNamed:@"zhifubaox"];
//          self.bankCardType.text = model.uc_addr;
                self.bankName.text = model.uc_name;
        
  
        
    }
    

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.cardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.top.mas_equalTo(self.contentView).offset(5);
        make.bottom.mas_equalTo(self.contentView).offset(-5);
        
    }];
    
    [self.bankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardBgView).offset(10);
        make.left.equalTo(self.cardBgView).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardBgView).offset(15);
        make.left.equalTo(self.bankIcon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    [self.bankCardType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankName.mas_bottom).offset(5);
        make.left.equalTo(self.bankIcon.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    [self.bankCardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cardBgView.mas_bottom).offset(-15);
        make.right.equalTo(self.cardBgView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-50, 16));
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
