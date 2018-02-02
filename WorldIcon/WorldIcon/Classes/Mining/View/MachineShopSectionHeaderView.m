//
//  MachineShopSectionHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MachineShopSectionHeaderView.h"

@implementation MachineShopSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    
    self.backgroundColor = [UIColor clearColor];
    
    NSArray *titles = @[@"矿机名称",@"介绍",@"OC",@"操作"];
    
    CGFloat w = kScreenWidth/titles.count;
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [UILabel gc_labelWithTitle:titles[i] withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
        label.frame = CGRectMake(i*w, 0, w, 35);
        label.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:label];
    }
}

@end
