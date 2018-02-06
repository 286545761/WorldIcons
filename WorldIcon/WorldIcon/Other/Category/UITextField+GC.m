//
//  UITextField+GC.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UITextField+GC.h"

@implementation UITextField (GC)
+(UITextField *)gc_textFieldWithPlacHolder:(NSString *)placeholder withTextColor:(UIColor *)color withTextFont:(CGFloat)fontSize{

    UITextField *field = [[UITextField alloc]init];
    field.opaque = YES;
    field.placeholder = placeholder;
    field.textColor = color;
    field.font = [UIFont systemFontOfSize:fontSize];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [field setValue:[UIColor gc_colorWithHexString:@"#cc3333"] forKeyPath:@"_placeholderLabel.textColor"];
    [field setValue:[UIFont boldSystemFontOfSize:fontSize] forKeyPath:@"_placeholderLabel.font"];
    
    return field;
}
@end
