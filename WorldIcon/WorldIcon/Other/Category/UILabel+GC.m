//
//  UILabel+GC.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UILabel+GC.h"

@implementation UILabel (GC)
+(UILabel *)gc_labelWithTitle:(NSString *)title withTextColor:(UIColor *)color withTextFont:(CGFloat)fontSize withTextAlignment:(NSTextAlignment)textAlignment{

    UILabel *label = [UILabel new];
    label.opaque = YES;
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
    label.adjustsFontSizeToFitWidth = YES;
    
    return label;
    
}
+(UILabel *)gc_labelWithTitle:(NSString *)title withFontName:(NSString *)fontName withTextColor:(UIColor *)color withTextFont:(CGFloat)fontSize withTextAlignment:(NSTextAlignment)textAlignment{

    UILabel *label = [UILabel new];
    label.opaque = YES;
    label.text = title;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:fontName size:fontSize];
    return label;
    
}
@end
