//
//  HomeSectionHeaderView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@interface HomeSectionHeaderView ()

@end

@implementation HomeSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    _topview = [[UIView alloc]initWithFrame:CGRectMake(0, [UIView countBeforeWithIphone5Length:30], kScreenWidth, [UIView countBeforeWithIphone5Length:15])];
    _topview.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topview];
    
    //image1
    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"biaotitiao"]];
    img1.frame = CGRectMake(0, [UIView countBeforeWithIphone5Length:15], 130, [UIView countBeforeWithIphone5Length:30]);
    [self addSubview:img1];
    self.img1 = img1;
    
    //image2
    UILabel *img2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 130, [UIView countBeforeWithIphone5Length:30])];
    img2.textColor = [UIColor whiteColor];
    img2.font = [UIFont boldSystemFontOfSize:15];
    [img1 addSubview:img2];
    self.img2 = img2;
}

@end

