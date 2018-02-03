//
//  MyMachineSectionHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MyMachineSectionHeaderView.h"

@implementation MyMachineSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    self.backgroundColor = KBackgroundColor;

    NSArray *titles = @[@"矿机名称",@"金矿",@"银矿",@"铜矿",@"状态"];

    CGFloat w = (kScreenWidth-20)/titles.count;
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [UILabel gc_labelWithTitle:titles[i] withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.frame = CGRectMake(10+i*w, 0, w, 35);

        if ( i == titles.count) {
            label.textAlignment = NSTextAlignmentRight;
        }
        [self addSubview:label];
    }
    //分隔线
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:1];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@0.5);
        make.top.mas_equalTo(self.mas_bottom).offset(0.5);
    }];
    
}
@end
