//
//  UITextField+textField.h
//  TheBull
//
//  Created by 韩铭文 on 17/3/21.
//  Copyright © 2017年 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (textField)
/**
 * 返回一个 textField
 * bgColor  背景色
 * textString   文本
 * textFont      文本的字体大小
 * textaligment  文本对齐方式
 * textColor     文本的颜色
 * placeholderString  占位符
 * delegate      谁代理
 * clearButtonMode  清除按钮的模式
 * isSecure  是否密文
 * keyboardtype  键盘type
 * returnkeytype  返回键type
 * parentView    父视图
 */

+(UITextField *)textFieldWithBackGroundColor:(UIColor*)bgColor withText:(NSString*)textString  withTextAlignment:(NSTextAlignment)textaligment withTextFont:(CGFloat)textFont withTextColor:(UIColor*)textColor withPlaceholderString:(NSString*) placeholderString withTextFieldDelegate:(id)delegate    withClearButtonMode:(UITextFieldViewMode)clearButtonMode  withSecurtTextEntry:(BOOL)isSecure  withKeyboardTtype:(UIKeyboardType)keyboardtype withReturnKeyType:(UIReturnKeyType)returnkeytype  withParentView:(UIView*)parentView;

/**
 * 返回一个 textField
 * bgColor  背景色
 * textString   文本
 * textFont      文本的字体大小
 * textaligment  文本对齐方式
 * textColor     文本的颜色
 * placeholderString  占位符
 * delegate      谁代理
 * clearButtonMode  清除按钮的模式
 * isSecure  是否密文
 * keyboardtype  键盘type
 * returnkeytype  返回键type
 * parentView    父视图
 * leftview      左视图
 * leftViewModel 左视图model
 */

+(UITextField *)textFieldWithBackGroundColor:(UIColor*)bgColor withText:(NSString*)textString  withTextAlignment:(NSTextAlignment)textaligment withTextFont:(CGFloat)textFont withTextColor:(UIColor*)textColor withPlaceholderString:(NSString*) placeholderString withTextFieldDelegate:(id)delegate    withClearButtonMode:(UITextFieldViewMode)clearButtonMode  withSecurtTextEntry:(BOOL)isSecure  withKeyboardTtype:(UIKeyboardType)keyboardtype withReturnKeyType:(UIReturnKeyType)returnkeytype  withParentView:(UIView*)parentView withLeftView:(UIView*)leftview withLeftViewModel:(UITextFieldViewMode)leftViewModel;
/**
 * 返回一个 textField
 * bgColor  背景色
 * textString   文本
 * textFont      文本的字体大小
 * textaligment  文本对齐方式
 * textColor     文本的颜色
 * placeholderString  占位符
 * delegate      谁代理
 * clearButtonMode  清除按钮的模式
 * isSecure  是否密文
 * keyboardtype  键盘type
 * returnkeytype  返回键type
 * parentView    父视图
 * leftview      左视图
 * leftViewModel 左视图model
 * rightView     右视图
 * rightViewModel 右视图model
 */

+(UITextField *)textFieldWithBackGroundColor:(UIColor*)bgColor withText:(NSString*)textString  withTextAlignment:(NSTextAlignment)textaligment withTextFont:(CGFloat)textFont withTextColor:(UIColor*)textColor withPlaceholderString:(NSString*) placeholderString withTextFieldDelegate:(id)delegate    withClearButtonMode:(UITextFieldViewMode)clearButtonMode  withSecurtTextEntry:(BOOL)isSecure  withKeyboardTtype:(UIKeyboardType)keyboardtype withReturnKeyType:(UIReturnKeyType)returnkeytype  withParentView:(UIView*)parentView withLeftView:(UIView*)leftview withLeftViewModel:(UITextFieldViewMode)leftViewModel withRightView:(UIView*)rightView withRightViewModel:(UITextFieldViewMode)rightViewModel;
@end
