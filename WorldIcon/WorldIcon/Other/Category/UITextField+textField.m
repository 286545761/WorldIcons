//
//  UITextField+textField.m
//  TheBull
//
//  Created by 韩铭文 on 17/3/21.
//  Copyright © 2017年 HMW. All rights reserved.
//

#import "UITextField+textField.h"

@implementation UITextField (textField)
+(UITextField *)textFieldWithBackGroundColor:(UIColor*)bgColor withText:(NSString*)textString  withTextAlignment:(NSTextAlignment)textaligment withTextFont:(CGFloat)textFont withTextColor:(UIColor*)textColor withPlaceholderString:(NSString*) placeholderString withTextFieldDelegate:(id)delegate    withClearButtonMode:(UITextFieldViewMode)clearButtonMode  withSecurtTextEntry:(BOOL)isSecure  withKeyboardTtype:(UIKeyboardType)keyboardtype withReturnKeyType:(UIReturnKeyType)returnkeytype  withParentView:(UIView*)parentView{
    
    UITextField *textField=[[UITextField alloc]init];
    textField.backgroundColor=bgColor;
    textField.placeholder=placeholderString;
    textField.delegate=delegate;
    textField.clearButtonMode=clearButtonMode;
    textField.text=textString;
    textField.textColor=textColor;
    textField.secureTextEntry=isSecure;
    textField.font=[UIFont systemFontOfSize:textFont];
    textField.textAlignment=textaligment;
    textField.attributedPlaceholder = [self  attributedStringWithString:placeholderString color:textColor font:[UIFont systemFontOfSize:textFont]];
    
    textField.keyboardType=keyboardtype;
    textField.returnKeyType=returnkeytype;
    [parentView addSubview:textField];
    return textField;
}
+(UITextField *)textFieldWithBackGroundColor:(UIColor*)bgColor withText:(NSString*)textString  withTextAlignment:(NSTextAlignment)textaligment withTextFont:(CGFloat)textFont withTextColor:(UIColor*)textColor withPlaceholderString:(NSString*) placeholderString withTextFieldDelegate:(id)delegate    withClearButtonMode:(UITextFieldViewMode)clearButtonMode  withSecurtTextEntry:(BOOL)isSecure  withKeyboardTtype:(UIKeyboardType)keyboardtype withReturnKeyType:(UIReturnKeyType)returnkeytype  withParentView:(UIView*)parentView withLeftView:(UIView*)leftview withLeftViewModel:(UITextFieldViewMode)leftViewModel withRightView:(UIView*)rightView withRightViewModel:(UITextFieldViewMode)rightViewModel{

    UITextField *textField=[self textFieldWithBackGroundColor:bgColor withText:textString withTextAlignment:textaligment withTextFont:textFont withTextColor:textColor withPlaceholderString:placeholderString withTextFieldDelegate:delegate withClearButtonMode:clearButtonMode withSecurtTextEntry:isSecure withKeyboardTtype:keyboardtype withReturnKeyType:returnkeytype withParentView:parentView];
    textField.leftView=leftview;
    textField.leftViewMode=leftViewModel;
    textField.rightView=rightView;
    textField.rightViewMode=rightViewModel;
    
    
    return textField;


}
+(UITextField *)textFieldWithBackGroundColor:(UIColor*)bgColor withText:(NSString*)textString  withTextAlignment:(NSTextAlignment)textaligment withTextFont:(CGFloat)textFont withTextColor:(UIColor*)textColor withPlaceholderString:(NSString*) placeholderString withTextFieldDelegate:(id)delegate    withClearButtonMode:(UITextFieldViewMode)clearButtonMode  withSecurtTextEntry:(BOOL)isSecure  withKeyboardTtype:(UIKeyboardType)keyboardtype withReturnKeyType:(UIReturnKeyType)returnkeytype  withParentView:(UIView*)parentView withLeftView:(UIView*)leftview withLeftViewModel:(UITextFieldViewMode)leftViewModel{



    UITextField *textField=[self textFieldWithBackGroundColor:bgColor withText:textString withTextAlignment:textaligment withTextFont:textFont withTextColor:textColor withPlaceholderString:placeholderString withTextFieldDelegate:delegate withClearButtonMode:clearButtonMode withSecurtTextEntry:isSecure withKeyboardTtype:keyboardtype withReturnKeyType:returnkeytype withParentView:parentView];
    textField.leftView=leftview;
    textField.leftViewMode=leftViewModel;
    
    
    return textField;


}
+ (NSAttributedString *)attributedStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    attrs[NSFontAttributeName] = font;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    return attributedStr;
}
@end
