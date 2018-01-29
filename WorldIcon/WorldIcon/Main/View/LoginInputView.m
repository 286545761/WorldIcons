//
//  LoginInputView.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "LoginInputView.h"

@interface LoginInputView ()
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *line;
@end

@implementation LoginInputView

-(instancetype)initWithFrame:(CGRect)frame withIcon:(UIImage *)image withInputLabel:(NSString *)inputLabelPlaceholder{
    
    if ([super initWithFrame:frame]) {
        
        [self setUpView];
        
        self.icon.image = image;
        self.field.placeholder = inputLabelPlaceholder;
        [self.field setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self.field setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        
    }
    return self;

}

-(void)setUpView{
    
//    self.backgroundColor = [UIColor redColor];
    
    self.icon = [UIImageView new];
    [self addSubview:self.icon];
    
    self.field = [UITextField new];
    self.field.textColor = [UIColor whiteColor];
    self.field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.field];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    self.line = line;
}
/**
 添加约束/更新约束
 */
-(void)updateConstraints{

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-kRatioY6(9));
        make.top.equalTo(self).offset(kRatioY6(17));
        make.width.mas_equalTo(kRatioX6(13));
    }];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(kRatioX6(10));
        make.bottom.equalTo(self).offset(-12);
        make.right.equalTo(self);
        make.centerY.equalTo(self.icon.mas_centerY);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-1);
        make.right.equalTo(self);
        make.height.equalTo(@1);
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
