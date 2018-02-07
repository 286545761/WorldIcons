//
//  MineralCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineralCell.h"

@interface MineralCell ()
@property (nonatomic,strong)UIView *back;
@end

@implementation MineralCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.back = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 75)];
    self.back.backgroundColor = [UIColor whiteColor];
    self.back.layer.masksToBounds = YES;
    self.back.layer.cornerRadius = 5;
    [self.contentView addSubview:self.back];
    
    //矿名
    UILabel *kmLabel = [UILabel gc_labelWithTitle:@"金矿" withFontName:@"" withTextColor:[UIColor gc_colorWithHexString:@"#cc9900"] withTextFont:17 withTextAlignment:(NSTextAlignmentLeft)];
//    kmLabel.backgroundColor = arc4randomColor;
    [self.back addSubview:kmLabel];
    self.kmLabel = kmLabel;
    //总量
    UILabel *zlLabel = [UILabel gc_labelWithTitle:@"总量:26000" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
//    zlLabel.backgroundColor = arc4randomColor;
    [self.back addSubview:zlLabel];
    self.zlLabel = zlLabel;
    
    //昨日产量
//    UILabel *zrclLabel = [UILabel gc_labelWithTitle:@"昨日产量:8000" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:13 withTextAlignment:(NSTextAlignmentLeft)];
//    kmLabel.backgroundColor = arc4randomColor;
//    [self.back addSubview:zrclLabel];
//    self.zrclLabel = zrclLabel;
    //合成
    UIButton *complexBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"合成" withRadius:kRatioY6(35)/2.0f];
    [complexBtn addTarget:self
                   action:@selector(complexBtnAction) forControlEvents:UIControlEventTouchUpInside];
    complexBtn.titleLabel.font = [UIFont fontWithAdaptiveIphone5Size:15];
    [complexBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    [self.back addSubview:complexBtn];
    self.complexBtn = complexBtn;
}

-(void)complexBtnAction{
    if (self.btnBlock) {
        self.btnBlock(self.index);
    }
}

/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.kmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
        make.top.mas_equalTo(self.back).offset(15);
    }];
    
    [self.zlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
        make.top.mas_equalTo(self.kmLabel.mas_bottom).offset(15);
    }];
    
//    [self.zrclLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.back).offset(10);
//        make.size.mas_equalTo(CGSizeMake(kRatioX6(150), kRatioY6(20)));
//        make.top.mas_equalTo(self.zlLabel.mas_bottom).offset(10);
//    }];
    
    [self.complexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.back).offset(-10);
        make.centerY.equalTo(self.back.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(100), kRatioY6(35)));
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
