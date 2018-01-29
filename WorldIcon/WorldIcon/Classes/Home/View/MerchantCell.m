//
//  MerchantCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MerchantCell.h"

@interface MerchantCell ()

@property (nonatomic,strong)UIImageView *merchantImage;
@property (nonatomic,strong)UILabel *merchantName;
@property (nonatomic,strong)UILabel *merchantAddress;
@property (nonatomic,strong)UILabel *merchantDistance;
@property (nonatomic,strong)UIImageView *locationIcon;
@property (nonatomic,strong)UILabel *city;
@property (nonatomic,strong)UILabel *line;

@end

@implementation MerchantCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    //图片
    UIImageView *merchantImage = [UIImageView new];
    merchantImage.image = [UIImage imageNamed:@"首页商家入驻图片"];
//    merchantImage.backgroundColor = arc4randomColor;
    [self.contentView addSubview:merchantImage];
    self.merchantImage = merchantImage;
    //店名
    UILabel *merchantName = [UILabel gc_labelWithTitle:@"赛百味" withFontName:@"Helvetica-Bold" withTextColor:[UIColor gc_colorWithHexString:@"#373737"] withTextFont:17 withTextAlignment:(NSTextAlignmentLeft)];
//    merchantName.backgroundColor = arc4randomColor;
    [self.contentView addSubview:merchantName];
    self.merchantName = merchantName;
    //详细地址
    UILabel *merchantAddress = [UILabel gc_labelWithTitle:@"[团结湖/朝阳公园]东三环北路甲19号嘉盛中心 soho" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
    merchantAddress.numberOfLines = 0;
//    merchantAddress.backgroundColor = arc4randomColor;

    [self.contentView addSubview:merchantAddress];
    self.merchantAddress = merchantAddress;
    //距离当前位置
    UILabel *merchantDistance = [UILabel gc_labelWithTitle:@"<500m" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:13 withTextAlignment:(NSTextAlignmentRight)];
//    merchantDistance.backgroundColor = arc4randomColor;

    [self.contentView addSubview:merchantDistance];
    self.merchantDistance = merchantDistance;
    //位置icon
    UIImageView *locationIcon = [UIImageView new];
//    locationIcon.backgroundColor = arc4randomColor;
    locationIcon.image = [UIImage imageNamed:@"首页地理位置图标"];
    [self.contentView addSubview:locationIcon];
    self.locationIcon = locationIcon;
    //地点
    UILabel *city = [UILabel gc_labelWithTitle:@"北京市" withTextColor:[UIColor gc_colorWithHexString:@"#8c8c8c"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
//    city.backgroundColor = arc4randomColor;

    [self.contentView addSubview:city];
    self.city = city;
    //分割线
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
    [self.contentView addSubview:line];
    self.line = line;

}
- (void)setModel:(AgentModel *)model{

    //商机图片
    if (model.vm_img_logo) {
        [self.merchantImage sd_setImageWithURL:[NSURL URLWithString:[AppManager getPhotoUrlFileID:model.vm_img_url]] placeholderImage:[UIImage imageNamed:kDefaultImg]];
    }
    //商家名称
    if (model.vm_agent_name) {
        self.merchantName.text = [NSString stringWithFormat:@"%@",model.vm_agent_name];
    }
    //商家详细地址
    if (model.vm_address) {
        self.merchantAddress.text = [NSString stringWithFormat:@"%@",model.vm_address];
    }
    //商家距离
    if (model.distance) {
     self.merchantDistance.text = [NSString stringWithFormat:@"%@",model.distance];
    }
    //商家所在省
    if (model.vm_province) {
        self.city.text = [NSString stringWithFormat:@"%@",model.vm_province];
    }

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.merchantImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(108), kRatioY6(96)));
    }];
    
    [self.merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantImage.mas_right).offset(14);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
    }];
    
    [self.merchantDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.merchantName.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(60), kRatioY6(20)));
    }];

    [self.merchantAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantName.mas_left);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.merchantName.mas_bottom).offset(13);
        make.height.mas_equalTo(kRatioY6(35));
    }];

    [self.locationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.merchantAddress.mas_left);
        make.top.equalTo(self.merchantAddress.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(11), kRatioY6(14)));
    }];

    [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationIcon.mas_right).offset(5);
        make.centerY.equalTo(self.locationIcon.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(60), kRatioY6(14)));
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
