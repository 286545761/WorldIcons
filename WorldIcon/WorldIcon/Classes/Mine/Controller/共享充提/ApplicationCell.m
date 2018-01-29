//
//  ApplicationCell.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/6.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ApplicationCell.h"

@interface ApplicationCell ()<UITextFieldDelegate>

@end

@implementation ApplicationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
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
    field.delegate = self;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
   field.placeholder = @"请输入";
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
        make.bottom.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
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
