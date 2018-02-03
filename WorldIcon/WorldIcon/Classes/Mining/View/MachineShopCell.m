//
//  MachineShopCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MachineShopCell.h"

@interface MachineShopCell ()
@property (nonatomic,strong)UIView *back;
@property (nonatomic,strong)UIImageView *kjImage;
@property (nonatomic,strong)UILabel *kjDescrip;
@property (nonatomic,strong)UILabel *yxqLabel;
@property (nonatomic,strong)UILabel *kccLabel;
@property (nonatomic,strong)UILabel *ykLabel;
@property (nonatomic,strong)UILabel *tkLabel;
@property (nonatomic,strong)UILabel *jeLabel;
@property (nonatomic,strong)UIButton *buyBtn;
@property (nonatomic,strong)UILabel *line;

@end

@implementation MachineShopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _back = [[UIView alloc]init];
    _back.backgroundColor = [UIColor whiteColor];
    _back.layer.cornerRadius = 5;
    _back.layer.masksToBounds = YES;
    [self.contentView addSubview:_back];
    
    //矿机图片
    UIImageView *kjImage = [UIImageView new];
    kjImage.image = [UIImage imageNamed:@"矿机商店图"];
    [_back addSubview:kjImage];
    self.kjImage = kjImage;
    
    //矿机说明
    UILabel *kjDescrip = [UILabel gc_labelWithTitle:@"10G云矿机" withTextColor:[UIColor whiteColor] withTextFont:13 withTextAlignment:(NSTextAlignmentCenter)];
    kjDescrip.backgroundColor = [UIColor gc_colorWithHexString:@"#757575"];
    [self.kjImage addSubview:kjDescrip];
    self.kjDescrip = kjDescrip;
    
    //有效期
//    UILabel *yxqLabel = [UILabel gc_labelWithTitle:@"有效期1个月" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
//    [self.contentView addSubview:yxqLabel];
//    self.yxqLabel = yxqLabel;
    
    //可产出
    UILabel *kccLabel = [UILabel gc_labelWithTitle:@"可产出\n金矿50" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    kccLabel.numberOfLines = 2;
    [self.back addSubview:kccLabel];
    self.kccLabel = kccLabel;
    //银矿
    UILabel *ykLabel = [UILabel gc_labelWithTitle:@"银矿100" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    [self.back addSubview:ykLabel];
    self.ykLabel = ykLabel;
    //铜矿
    UILabel *tkLabel = [UILabel gc_labelWithTitle:@"铜矿2000" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    [self.back addSubview:tkLabel];
    self.tkLabel = tkLabel;
    //金额
    UILabel *jeLabel = [UILabel gc_labelWithTitle:@"1120" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    [self.back addSubview:jeLabel];
    self.jeLabel = jeLabel;
    //购买
    UIButton *buyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor clearColor] withTitle:@"购买" withRadius:4];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    buyBtn.layer.cornerRadius = 29.0f/2;
    buyBtn.layer.masksToBounds = YES;
    [buyBtn addTarget:self action:@selector(buyAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.back addSubview:buyBtn];
    self.buyBtn = buyBtn;
}


-(void)buyAction{
    self.block();
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [self.kjImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(20);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(72), kRatioY6(65)));
    }];
    
    [self.kjDescrip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImage.mas_left);
        make.bottom.equalTo(self.kjImage.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(72), kRatioY6(23)));
    }];

//    [self.yxqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.kjImage.mas_right).offset(28);
//        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
//        make.top.mas_equalTo(self.kjImage.mas_top);
//    }];
    
    [self.kccLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImage.mas_right).offset(28);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(30)));
        make.top.mas_equalTo(self.kjImage.mas_top).offset(5);
    }];
    
    [self.ykLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImage.mas_right).offset(28);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
        make.top.equalTo(self.kccLabel.mas_bottom);
    }];
    
    [self.tkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImage.mas_right).offset(28);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
        make.top.equalTo(self.ykLabel.mas_bottom);
    }];
    
    [self.jeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tkLabel.mas_right);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
    }];
 
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.back.mas_right).offset(-20);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(58), kRatioY6(29)));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back);
        make.right.equalTo(self.back);
        make.top.mas_equalTo(self.back.mas_bottom).offset(1);
        make.height.equalTo(@1);
    }];
    
    [super updateConstraints];
    
}
- (void)setModel:(MachinesModel *)model{
    if (model.cm_photo_fileid) {
        [self.kjImage sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:model.cm_photo_fileid]] placeholderImage:[UIImage imageNamed:@"矿机商店图"]];
    }
    
    if (model.cm_name) {
        self.kjDescrip.text = [NSString stringWithFormat:@"%@",model.cm_name];
    }
    
    if (model.cm_jk) {
        self.kccLabel.text = [NSString stringWithFormat:@"可产出\n金矿%@",model.cm_jk];
    }
    
    if (model.cm_yk) {
        self.ykLabel.text = [NSString stringWithFormat:@"银矿%@",model.cm_yk];
    }
    
    if (model.cm_tk) {
        self.tkLabel.text = [NSString stringWithFormat:@"铜矿%@",model.cm_tk];
    }
    
    if (model.cm_life) {
        self.yxqLabel.text = [NSString stringWithFormat:@"有效期%@个月",model.cm_life];
    }
    if (model.cm_value) {
        self.jeLabel.text = [NSString stringWithFormat:@"%@",model.cm_value];
    }
}
/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}

@end
