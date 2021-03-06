//
//  InputView.h
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

@property (nonatomic,strong)UITextField *field;

@property (nonatomic,strong)UILabel *titleLabel;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withPlaceholder:(NSString *)placeholder;
@end
