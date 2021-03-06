//
//  BaseNavViewController.m
//  NavSlidePop
//
//  Created by JunpingWon on 15/9/18.
//  Copyright (c) 2015年 JunpingWon. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.interactivePopGestureRecognizer);
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    SEL traistionAction = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:traistionAction];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}
    // 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return  YES;
}

- (BOOL)commitTranslation:(CGPoint)translation
{
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    if (absX > absY ) {
        if (translation.x<0) {
            //向左滑动
            return NO;
        }else{
            //向右滑动
            return YES;
        }
    } else if (absY > absX) {
        if (translation.y<0) {
            //向上滑动
            return NO;
        }else{
            //向下滑动
            return NO;
        }
    }
    return NO;
}

@end
