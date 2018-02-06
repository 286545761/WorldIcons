//
//  CTRecordHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CTRecordHeaderView.h"

@interface CTRecordHeaderView ()

@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *meiyuanLabel;
@property (nonatomic,strong) UILabel *operateLabel;

@end

@implementation CTRecordHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
   
    self.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    
    //时间
    UILabel *dateLabel = [UILabel gc_labelWithTitle:@"时间" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(15) withTextAlignment:(NSTextAlignmentCenter)];
    dateLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview: dateLabel];
    self.dateLabel = dateLabel;
    //美元
    UILabel *meiyuanLabel =  [UILabel gc_labelWithTitle:@"美元" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(16) withTextAlignment:(NSTextAlignmentCenter)];
    meiyuanLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview: meiyuanLabel];
    self.meiyuanLabel = meiyuanLabel;    
    //操作
    UILabel *operateLabel =  [UILabel gc_labelWithTitle:@"操作" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(16) withTextAlignment:(NSTextAlignmentCenter)];
    operateLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview: operateLabel];
    self.operateLabel = operateLabel;

}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, kRatioY6(35)));
    }];
    
    [self.meiyuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, kRatioY6(35)));
    }];
    
    [self.operateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.meiyuanLabel.mas_right).offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, kRatioY6(35)));
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
