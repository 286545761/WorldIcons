//
//  UIView+adaptive.h
//  ymm
//
//  Created by 白亚策 on 15/12/20.
//  Copyright © 2015年 ymm. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface UIView (adaptive)

// 把一个Iphone5的长度 转换成适配以后的长度
+ (CGFloat)countBeforeWithIphone5Length:(CGFloat)iphone5Length;
// 把一个当前的长度 转换成iPhone的长度
+ (CGFloat)countIphone5LengthWithBeforeLength:(CGFloat)beforeLength;
// 使用Iphone5的Frame来适配各个手机
- (instancetype)initWithAdaptiveIphone5Frame:(CGRect)frame;

// 使用Iphone5的Frame来适配各个手机
- (void)setAdaptiveIphone5Frame:(CGRect)adaptiveadaIphone5Frame;

// 获取当前frame转换成iPhone的frame
- (CGRect)adaptiveIphone5Frame;

// 获取当前屏幕高度转换成iPhone5的到高度
+ (CGFloat)getCurrentScreenHeightAdaptiveIphone5;

@end
