//
//  MerchantAllCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MerchantAllCell.h"

@interface MerchantAllCell ()

@property (nonatomic,strong)UIImageView *merchantImage;
@property (nonatomic,strong)UILabel *sjName;
@property (nonatomic,strong)UILabel *merchantCateg;
@property (nonatomic,strong)UILabel *merchantLocation;
@property (nonatomic,strong)UILabel *merchantAddress;
@property (nonatomic,strong) UILabel *line;
@end
@implementation MerchantAllCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    //商家图片
    UIImageView *merchantImage = [UIImageView new];
    merchantImage.image = [UIImage imageNamed:@"商家图片"];
    [self.contentView addSubview:merchantImage];
    self.merchantImage = merchantImage;
    
    //商家名字
    UILabel *sjName = [UILabel gc_labelWithTitle:@"龙创时代" withTextColor:[UIColor whiteColor] withTextFont:13 withTextAlignment:(NSTextAlignmentCenter)];
    sjName.backgroundColor = [UIColor gc_colorWithHexString:@"#757575" alpha:0.7];
    sjName.adjustsFontSizeToFitWidth = NO;
    [self.merchantImage addSubview:sjName];
    self.sjName = sjName;
    //商家分类
    UILabel *merchantCateg = [UILabel gc_labelWithTitle:@"IT互联网" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:merchantCateg];
    self.merchantCateg = merchantCateg;
    //商家位置
    UILabel *merchantLocation = [UILabel gc_labelWithTitle:@"北京朝阳" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:merchantLocation];
    self.merchantLocation = merchantLocation;
    //商家详细地址
    UILabel *merchantAddress = [UILabel gc_labelWithTitle:@"北京市朝阳区东三环甲19号" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
    merchantAddress.numberOfLines = 0;
    [self.contentView addSubview:merchantAddress];
    self.merchantAddress = merchantAddress;
    
    //分割线
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [self.contentView addSubview:line];
    self.line = line;
}
-(void)setModel:(AgentModel *)model{

    //商家图片 self.merchantImage
    //商家名字 self.sjName
    //商家分类 self.merchantCateg
    //商家位置 self.merchantLocation
    //商家详细地址 self.merchantAddress
    if (model.vm_img_logo) {
        [self.merchantImage sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:model.vm_img_url]] placeholderImage:[UIImage imageNamed:kDefaultImg]];
    }
    if (model.vm_agent_name) {
        self.sjName.text = [NSString stringWithFormat:@"%@",model.vm_agent_name];
    }
    if (model.vm_type) {
        self.merchantCateg.text = [NSString stringWithFormat:@"%@",model.vm_type];
    }
    if (model.vm_province) {
        self.merchantLocation.text = [NSString stringWithFormat:@"%@%@",model.vm_province,model.vm_city];
    }
    if (model.vm_address) {
        self.merchantAddress.text = [NSString stringWithFormat:@"%@",model.vm_address];
    }
    
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    CGFloat W = kScreenWidth-20;
    
    [self.merchantImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(70), kRatioY6(65)));
    }];
    
    [self.sjName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantImage.mas_left);
        make.bottom.equalTo(self.merchantImage.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(70), kRatioY6(23)));
    }];
    [self.merchantCateg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantImage.mas_right).offset(kRatioX6(5));
        make.top.equalTo(self.merchantImage);
        make.width.mas_equalTo(W/4);
        make.bottom.mas_equalTo(self.contentView).offset(0);
    }];
    
    [self.merchantLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantCateg.mas_right);
        make.top.equalTo(self.merchantImage);
        make.width.mas_equalTo(W/4);
        make.bottom.mas_equalTo(self.contentView).offset(0);
    }];
    
    [self.merchantAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantLocation.mas_right);
        make.top.equalTo(self.merchantImage);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
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
