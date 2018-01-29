//
//  AuthcodeView.h
//  bage
//
//  Created by 陈潇 on 17/9/12.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthcodeView : UIView

@property (strong, nonatomic) NSArray *dataArray;//字符素材数组

@property (strong, nonatomic) NSMutableString *authCodeStr;//验证码字符串

@property (strong, nonatomic) NSMutableString *authCodeId;//验证码字符串

@end
