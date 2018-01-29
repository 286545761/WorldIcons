//
//  GCAlertView.m
//  CustomAlertView
//
//  Created by 陈潇 on 17/6/30.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCAlertView.h"
/** 二进制码转RGB */
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation GCAlertView
/** 单例 */
+ (GCAlertView *)singleClass{
    static GCAlertView *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GCAlertView alloc] init];
    });
    return manager;
}
/** 提示view */
- (UIView *)quickAlertViewWithArray:(NSArray *)array{
    
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight+60)];
    mainView.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
    
    CGFloat buttonH = 50;
    CGFloat buttonW = 245;
    
    // 通过数组长度创建view的高
    UIView *alert = [[UIView alloc] initWithFrame:CGRectMake(0, 0,buttonW, array.count * buttonH)];
    alert.center = mainView.center;
    alert.layer.cornerRadius = 3;
    for (int i = 0; i < array.count;i++) {
        // 因为有一条分割线 所以最下面是一层view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i*buttonH, buttonW, buttonH)];
        view.backgroundColor = [UIColor whiteColor];
        // 创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        button.frame = CGRectMake(15, 0, buttonW, buttonH);
        [button setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle: array[i] forState:(UIControlStateNormal)];
        // 所有button都关联一个点击方法,通过按钮上的title做区分
        [button addTarget:self action:@selector(alertAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        
        // 这里可以根据传值改变状态
        if ([array[i] isEqualToString:@" 取消"]) {
           
        }else{
            // 分割线
            // 如果不是最后一行
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, buttonH-1, buttonW-30, 1)];
            lineView.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
            [view addSubview:lineView];
        }
        if ([array[i] isEqualToString:@" 修改头像"]) {
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, buttonH-1, buttonW, 1)];
            lineView.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
            [view addSubview:lineView];
            
            [button setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            
        }
        [alert addSubview:view];
    }
    [mainView addSubview:alert];
    
    return mainView;
}
/** button点击事件,通知代理执行代理方法 */
- (void)alertAction:(UIButton *)button{
    [_delegate didSelectAlertButton:button.titleLabel.text];
}

@end
