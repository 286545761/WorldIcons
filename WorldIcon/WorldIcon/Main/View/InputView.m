//
//  InputView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "InputView.h"

@interface InputView ()<UITextFieldDelegate>

@end

@implementation InputView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withPlaceholder:(NSString *)placeholder{
    if ([super initWithFrame:frame]) {
        
        [self setUpView];
        
        self.titleLabel.text = title;
        self.field.placeholder = placeholder;
    }
    return self;
}
-(void)setUpView{

    //文字提示
    UILabel *titleLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:14 withTextAlignment:(NSTextAlignmentRight)];
//        titleLabel.backgroundColor = arc4randomColor;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    //文本框
    UITextField *field = [UITextField gc_textFieldWithPlacHolder:@"" withTextColor:[UIColor gc_colorWithHexString:@"#999999"] withTextFont:16];
//        field.backgroundColor = arc4randomColor;
    field.layer.cornerRadius = 2;
    field.layer.borderWidth = 0.5;
    field.delegate = self;
    field.layer.borderColor = [UIColor gc_colorWithHexString:@"#dbdbdb"].CGColor;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, field.frame.size.height)];
    field.leftViewMode=UITextFieldViewModeAlways;
    [self addSubview:field];
    self.field = field;

}

/**
 添加约束/更新约束
 */
-(void)updateConstraints{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(kRatioX6(70));
    }];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [super updateConstraints];
}
/**
 自动布局
 */
+(BOOL)requiresConstraintBasedLayout{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}


@end
