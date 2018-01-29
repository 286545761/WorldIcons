//
//  MyMachineCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MyMachineCell.h"

@interface MyMachineCell ()

@property (nonatomic,strong)UIImageView *kjImage;
@property (nonatomic,strong)UILabel *kjDescrip;
@property (nonatomic,strong)UILabel *jkLabel;
@property (nonatomic,strong)UILabel *ykLabel;
@property (nonatomic,strong)UILabel *tkLabel;
@property (nonatomic,strong)UILabel *yxqLabel;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *line;
@end

@implementation MyMachineCell
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
    //金矿
    UILabel *jkLabel = [UILabel gc_labelWithTitle:@"3" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:jkLabel];
    self.jkLabel = jkLabel;
    //银矿
    UILabel *ykLabel = [UILabel gc_labelWithTitle:@"90" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:ykLabel];
    self.ykLabel = ykLabel;
    //铜矿
    UILabel *tkLabel = [UILabel gc_labelWithTitle:@"100" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:tkLabel];
    self.tkLabel = tkLabel;
    //有效期
//    UILabel *yxqLabel = [UILabel gc_labelWithTitle:@"7天" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentRight)];
//    [self.contentView addSubview:yxqLabel];
//    self.yxqLabel = yxqLabel;
    //挖矿状态
    UILabel *statusLabel = [UILabel gc_labelWithTitle:@"正在挖矿" withTextColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTextFont:14 withTextAlignment:(NSTextAlignmentRight)];
    [self.contentView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    //分割线
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [self.contentView addSubview:line];
    self.line = line;
}
- (void)setModel:(MachineModel *)model{

    if (model.mm_cm_photo_fileid) {
        
        [self.kjImage sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:model.mm_cm_photo_fileid]] placeholderImage:[UIImage imageNamed:@"矿机商店图"]];
    }
    
    if (model.mm_cm_name) {
        self.kjDescrip.text = [NSString stringWithFormat:@"%@",model.mm_cm_name];
    }
    
    if (model.mm_cm_jk) {
        self.jkLabel.text = [NSString stringWithFormat:@"%@",model.mm_cm_jk];
    }
    
    if (model.mm_cm_yk) {
        self.ykLabel.text = [NSString stringWithFormat:@"%@",model.mm_cm_yk];
    }
    
    if (model.mm_cm_tk) {
        self.tkLabel.text = [NSString stringWithFormat:@"%@",model.mm_cm_tk];
    }
    
//    if (model.mm_date) {
//        self.yxqLabel.text = [NSString stringWithFormat:@"%@",model.mm_date];
//    }
    
    if (model.mm_status) {
        
        if ([model.mm_status isEqualToString:@"0"]) {
            self.statusLabel.text = @"已过期";
        }
        if ([model.mm_status isEqualToString:@"1"]) {
            self.statusLabel.text = @"正在挖矿";
        }
    }
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.kjImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(70), kRatioY6(65)));
    }];
    
    [self.kjDescrip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjImage.mas_left);
        make.bottom.equalTo(self.kjImage.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(72), kRatioY6(23)));
    }];
    
    [self.jkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kjDescrip.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/5), kRatioY6(15)));
    }];
    
    [self.ykLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jkLabel.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/5), kRatioY6(15)));
    }];
    
    [self.tkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ykLabel.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/5)-20, kRatioY6(15)));
    }];
    
//    [self.yxqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView.mas_right).offset(-20);
//        make.centerY.equalTo(self.contentView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/5)-40, kRatioY6(15)));
//    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(kScreenWidth/4), kRatioY6(15)));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(1);
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
