//
//  MineToolView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineToolView.h"
#import "MineToolButton.h"

@implementation MineToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpView:frame];
    }
    return self;
}

-(void)setUpView:(CGRect)frame{

    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, frame.size.height)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = [UIView countBeforeWithIphone5Length:30.0/2];
    [self addSubview:back];
    
    //存放列表图片和标题
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MineTool" ofType:@"plist"];
    NSArray *imageAndtiltleArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    for (int i = 0; i < imageAndtiltleArray.count; i++) {
        
        //自定义button
        MineToolButton *btn = [MineToolButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(back.frame.size.width / 3 * (i % 3), back.frame.size.width / 3 * (i / 3), back.frame.size.width / 3, back.frame.size.width / 3);
        [btn setBackgroundImage:[UIImage imageNamed:[imageAndtiltleArray objectAtIndex:i][@"image"]] forState:UIControlStateNormal];
        [btn setTitle:[imageAndtiltleArray objectAtIndex:i][@"title"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn.tag = 2000+i;
        [btn addTarget:self action:@selector(toolAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置边界的宽度
//        [btn.layer setBorderWidth:0.3];
        //设置按钮的边界颜色
//        [btn.layer setBorderColor:[UIColor colorWithWhite:0.925 alpha:1.000].CGColor];
        [back addSubview:btn];
    }
}
#pragma mark -- 获取对应按钮的响应事件
-(void)toolAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(mineToolView:didSelectedButton:)]) {
        [self.delegate mineToolView:self didSelectedButton:sender.tag];
    }
    
}

@end
