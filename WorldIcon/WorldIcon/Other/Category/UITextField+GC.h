//
//  UITextField+GC.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (GC)

+(UITextField *)gc_textFieldWithPlacHolder:(NSString *)placeholder withTextColor:(UIColor *)color withTextFont:(CGFloat)fontSize;

@end
