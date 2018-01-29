//
//  RegisterInputView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "RegisterInputView.h"

@interface RegisterInputView ()

@property (nonatomic,strong)UILabel *titleLabel;

@end

@implementation RegisterInputView
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withPlaceholder:(NSString *)placeholder{
    if ([super initWithFrame:frame]) {
        
        [self setUpView];
        self.titleLabel.text = title;
        self.field.placeholder = placeholder;
        [self.field setValue:[UIColor gc_colorWithHexString:@"#dbdbdb"] forKeyPath:@"_placeholderLabel.textColor"];
        [self.field setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        
    }
    return self;
}
-(void)setUpView{
    
    self.layer.borderColor = [UIColor gc_colorWithHexString:@"#dbdbdb"].CGColor;
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 35.0/2;
    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 1.5;
    
    //文字提示
    UILabel *titleLabel = [UILabel gc_labelWithTitle:@"" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:14 withTextAlignment:(NSTextAlignmentLeft)];
//    titleLabel.backgroundColor = arc4randomColor;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    //文本框
    UITextField *field = [UITextField gc_textFieldWithPlacHolder:@"" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:16];
//    field.backgroundColor = arc4randomColor;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
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
        make.left.equalTo(self.titleLabel.mas_right);
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


@end
