//
//  MachineShopCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MachineShopCell.h"

@interface MachineShopCell ()

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

    //矿机图片
    UIImageView *kjImage = [UIImageView new];
    kjImage.image = [UIImage imageNamed:@"矿机商店图"];
    [self.contentView addSubview:kjImage];
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
    UILabel *kccLabel = [UILabel gc_labelWithTitle:@"可产出金矿50" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:kccLabel];
    self.kccLabel = kccLabel;
    //银矿
    UILabel *ykLabel = [UILabel gc_labelWithTitle:@"银矿100" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:ykLabel];
    self.ykLabel = ykLabel;
    //铜矿
    UILabel *tkLabel = [UILabel gc_labelWithTitle:@"铜矿2000" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:tkLabel];
    self.tkLabel = tkLabel;
    //金额
    UILabel *jeLabel = [UILabel gc_labelWithTitle:@"1120" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    [self.contentView addSubview:jeLabel];
    self.jeLabel = jeLabel;
    //购买
    UIButton *buyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"购买" withRadius:4];
    [buyBtn addTarget:self action:@selector(buyAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:buyBtn];
    self.buyBtn = buyBtn;
    
    //分割线
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [self.contentView addSubview:line];
    self.line = line;
    
}
-(void)buyAction{
    self.block();
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.kjImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(72), kRatioY6(65)));
    }];
    
    [self.kjDescrip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImage.mas_left);
        make.bottom.equalTo(self.kjImage.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(72), kRatioY6(23)));
    }];
//    
//    [self.yxqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.kjImage.mas_right).offset(28);
//        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
//        make.top.mas_equalTo(self.kjImage.mas_top);
//    }];
    
    [self.kccLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImage.mas_right).offset(28);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
        make.top.mas_equalTo(self.kjImage.mas_top).offset(10);
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
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
    }];
 
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(58), kRatioY6(29)));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(1);
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
        self.kccLabel.text = [NSString stringWithFormat:@"可产出金矿%@",model.cm_jk];
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
