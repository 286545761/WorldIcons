//
//  LoginInputView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInputView : UIView

@property (nonatomic,strong)UITextField *field;

-(instancetype)initWithFrame:(CGRect)frame withIcon:(UIImage *)image withInputLabel:(NSString *)inputLabelPlaceholder;

@end
