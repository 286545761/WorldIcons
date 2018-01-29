//
//  UIView+GC.h
//  Bage
//
//  Created by 陈潇 on 17/3/8.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GC)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, strong, readonly) UIViewController *jkr_viewController;

// 是否能够响应touch事件
@property (nonatomic, assign) BOOL unTouch;
// 不响应touch事件的区域
@property (nonatomic, assign) CGRect unTouchRect;

@end
