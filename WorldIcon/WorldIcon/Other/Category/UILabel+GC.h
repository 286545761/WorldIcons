//
//  UILabel+GC.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (GC)

+(UILabel *)gc_labelWithTitle:(NSString *)title withTextColor:(UIColor *)color withTextFont:(CGFloat)fontSize withTextAlignment:(NSTextAlignment)textAlignment;

+(UILabel *)gc_labelWithTitle:(NSString *)title withFontName:(NSString *)fontName withTextColor:(UIColor *)color withTextFont:(CGFloat)fontSize withTextAlignment:(NSTextAlignment)textAlignment;

@end
