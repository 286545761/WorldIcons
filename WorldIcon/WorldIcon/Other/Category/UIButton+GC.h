//
//  UIButton+GC.h
//  Bage
//
//  Created by 陈潇 on 17/3/7.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (GC)

+(UIButton *)gc_initButtonWithBackgroundColor:(UIColor *)bgColor withTitle:(NSString *)title withRadius:(NSInteger )radius;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
-(void)gc_layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                          imageTitleSpace:(CGFloat)space;

@end
