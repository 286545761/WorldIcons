//
//  MerchantSectionHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MerchantSectionHeaderView.h"

@implementation MerchantSectionHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{

    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"商家信息",@"分类",@"省/市",@"地址"];
    
    CGFloat w = (kScreenWidth-20)/titles.count;
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [UILabel gc_labelWithTitle:titles[i] withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentCenter)];
        label.frame = CGRectMake(i*w, 0, w, 35);
        label.tag = 100+i;
        [self addSubview:label];
        if (i == 1) {
            
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCategoryAction)];
            [label addGestureRecognizer:tap];
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width-6, label.frame.size.height-6, 6, 6)];
            img.image = [UIImage imageNamed:@"分类下箭头"];
            [label addSubview:img];
            
        }
        if (i == 2) {
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseLocationAction)];
            [label addGestureRecognizer:tap];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width-6, label.frame.size.height-6, 6, 6)];
            img.image = [UIImage imageNamed:@"分类下箭头"];
            [label addSubview:img];
        }
        self.label = label;
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

-(void)chooseLocationAction{
    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:didSelected:)]) {
        [self.delegate sectionHeaderView:self didSelected:@"选择地点"];
    }
}
-(void)chooseCategoryAction{
    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:didSelected:)]) {
        [self.delegate sectionHeaderView:self didSelected:@"选择分类"];
    }
}
@end
