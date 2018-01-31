//
//  InputBuyAndSellView.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/31.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "InputBuyAndSellView.h"
#define HIDE_KEYBOARD [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
#define KMaxLength     100
@interface InputBuyAndSellView()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *leftInputField;
@property(nonatomic,strong)UITextField *rightInputField;
@property(nonatomic,strong)UILabel *numberL;
@property(nonatomic,strong)NSString *type;
@end
@implementation InputBuyAndSellView

-(instancetype)initWithType:(NSString *)type
                  withCount:(NSString *)countStr{
    self = [super init];
    if (self) {
        self.type = type;
        [self setUpView:type withCount:countStr];
    }
    return self;
}

-(void)setUpView:(NSString *)type
       withCount:(NSString *)countStr{
    self.backgroundColor = RGBA(0, 0, 0, 0.3f);
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.adaptiveIphone5Frame = CGRectMake(320/2-12.5f, 568/3*2-25, 25, 25);
    [deleteBtn setImage:[UIImage imageNamed:@"whitecha"] forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor clearColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    UIView *lineV = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(320/2-0.5f, deleteBtn.adaptiveIphone5Frame.origin.y-25, 1, 25)];
    lineV.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineV];
    
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 568.0f/3, 320-20, 568.0f/3-25-15)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = 20;
    [self addSubview:back];
    
    UILabel *topL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 10, 320-20, 15)];
    topL.text = @"欧力币";
    topL.textAlignment = NSTextAlignmentCenter;
    topL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    topL.font = [UIFont boldSystemFontOfSize:15];
    [back addSubview:topL];
    
    UIButton *leftAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftAddBtn.adaptiveIphone5Frame = CGRectMake(back.adaptiveIphone5Frame.size.width/2.0f-5-30, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, 30, 35);
    [leftAddBtn setTitle:@"   +\n0.01" forState:UIControlStateNormal];
    leftAddBtn.titleLabel.numberOfLines = 2;
    [leftAddBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftAddBtn addTarget:self action:@selector(leftAddBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [leftAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftAddBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:leftAddBtn];
    
    
    UIButton *leftDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftDeleteBtn.adaptiveIphone5Frame = CGRectMake(10, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, 30, 35);
    [leftDeleteBtn setTitle:@"   -\n0.01" forState:UIControlStateNormal];
    leftDeleteBtn.titleLabel.numberOfLines = 2;
    [leftDeleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftDeleteBtn addTarget:self action:@selector(leftDeleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [leftDeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftDeleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:leftDeleteBtn];
    
    self.leftInputField = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(leftDeleteBtn.adaptiveIphone5Frame.size.width+leftDeleteBtn.adaptiveIphone5Frame.origin.x+2,leftDeleteBtn.adaptiveIphone5Frame.origin.y,back.adaptiveIphone5Frame.size.width/2.0f-4-30-30-10-5,leftDeleteBtn.adaptiveIphone5Frame.size.height)];
    _leftInputField.backgroundColor = [UIColor whiteColor];
    _leftInputField.layer.cornerRadius = 2;
    _leftInputField.layer.masksToBounds = YES;
    _leftInputField.layer.borderColor = RGBA(217, 217, 217, 1).CGColor;
    _leftInputField.layer.borderWidth = 1;
    _leftInputField.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    _leftInputField.font = [UIFont fontWithAdaptiveIphone5Size:14];
    _leftInputField.delegate = self;
    _leftInputField.tag = 100;
    [back addSubview:self.leftInputField];
    
    UIButton *rightDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightDeleteBtn.adaptiveIphone5Frame = CGRectMake(back.adaptiveIphone5Frame.size.width/2.0f+5, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, 30, 35);
    [rightDeleteBtn setTitle:@"-" forState:UIControlStateNormal];
    [rightDeleteBtn addTarget:self action:@selector(rightDeleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightDeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightDeleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:rightDeleteBtn];
    
    self.rightInputField = [[UITextField alloc]initWithAdaptiveIphone5Frame:CGRectMake(rightDeleteBtn.adaptiveIphone5Frame.origin.x+rightDeleteBtn.adaptiveIphone5Frame.size.width+5,rightDeleteBtn.adaptiveIphone5Frame.origin.y,self.leftInputField.adaptiveIphone5Frame.size.width, self.leftInputField.adaptiveIphone5Frame.size.height)];
    _rightInputField.backgroundColor = [UIColor whiteColor];
    _rightInputField.layer.cornerRadius = 2;
    _rightInputField.layer.masksToBounds = YES;
    _rightInputField.layer.borderColor = RGBA(217, 217, 217, 1).CGColor;
    _rightInputField.layer.borderWidth = 1;
    _rightInputField.textColor = [UIColor gc_colorWithHexString:@"#333333"];
    _rightInputField.font = [UIFont fontWithAdaptiveIphone5Size:14];
    _rightInputField.delegate = self;
    _rightInputField.tag = 101;
    [back addSubview:self.rightInputField];
    
    UIButton *rightAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightAddBtn.adaptiveIphone5Frame = CGRectMake(_rightInputField.adaptiveIphone5Frame.origin.x+_rightInputField.adaptiveIphone5Frame.size.width+5, topL.adaptiveIphone5Frame.origin.y+topL.adaptiveIphone5Frame.size.height+10, 30, 35);
    [rightAddBtn setTitle:@"+" forState:UIControlStateNormal];
    [rightAddBtn addTarget:self action:@selector(rightAddBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightAddBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:rightAddBtn];
    
    self.numberL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, leftDeleteBtn.adaptiveIphone5Frame.origin.y+leftDeleteBtn.adaptiveIphone5Frame.size.height+10, 200, 15)];
    
    self.numberL.font = [UIFont fontWithAdaptiveIphone5Size:14];
    self.numberL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    self.numberL.textAlignment = NSTextAlignmentLeft;
    [back addSubview:self.numberL];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ensureBtn.adaptiveIphone5Frame = CGRectMake(10, back.adaptiveIphone5Frame.size.height-10-30,back.adaptiveIphone5Frame.size.width/2.0f-5-10, 30);
    [ensureBtn addTarget:self action:@selector(ensureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ensureBtn.layer.cornerRadius = [UIView countBeforeWithIphone5Length:32.0/2];
    ensureBtn.layer.masksToBounds = YES;
    ensureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [back addSubview:ensureBtn];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.adaptiveIphone5Frame = CGRectMake(back.adaptiveIphone5Frame.size.width/2.0f+5, ensureBtn.adaptiveIphone5Frame.origin.y,ensureBtn.adaptiveIphone5Frame.size.width, ensureBtn.adaptiveIphone5Frame.size.height);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    cancleBtn.backgroundColor = KBackgroundColor;
    cancleBtn.layer.cornerRadius = [UIView countBeforeWithIphone5Length:32.0/2];
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [back addSubview:cancleBtn];
    
    if ([type isEqualToString:@"buy"]) {
        [leftAddBtn setBackgroundImage:[UIImage imageNamed:@"buyBtn"] forState:UIControlStateNormal];
        [leftDeleteBtn setBackgroundImage:[UIImage imageNamed:@"buyBtn"] forState:UIControlStateNormal];
        [rightDeleteBtn setBackgroundImage:[UIImage imageNamed:@"buyBtn"] forState:UIControlStateNormal];
        [rightAddBtn setBackgroundImage:[UIImage imageNamed:@"buyBtn"] forState:UIControlStateNormal];
        self.numberL.text = [NSString stringWithFormat:@"可买%@个", countStr];
        [ensureBtn setTitle:@"买入" forState:UIControlStateNormal];
        [ensureBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    }
    if ([type isEqualToString:@"sell"]) {
        [leftAddBtn setBackgroundImage:[UIImage imageNamed:@"sellBtn"] forState:UIControlStateNormal];
        [leftDeleteBtn setBackgroundImage:[UIImage imageNamed:@"sellBtn"] forState:UIControlStateNormal];
        [rightAddBtn setBackgroundImage:[UIImage imageNamed:@"sellBtn"] forState:UIControlStateNormal];
        [rightDeleteBtn setBackgroundImage:[UIImage imageNamed:@"sellBtn"] forState:UIControlStateNormal];
        self.numberL.text = [NSString stringWithFormat:@"可卖%@个", countStr];
        [ensureBtn setTitle:@"卖出" forState:UIControlStateNormal];
        [ensureBtn setBackgroundImage:[UIImage imageNamed:@"sellBtn"] forState:UIControlStateNormal];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == self.leftInputField.tag) {
        [self.delegate prictTextChanged:self.leftInputField.text];
    }
    if (textField.tag == self.rightInputField.tag) {
        [self.delegate amountTextChanged:self.rightInputField.text];
    }
}

-(void)ensureBtnAction{
    CGFloat number = [self.numberL.text floatValue];
    CGFloat count = [self.rightInputField.text floatValue];
    if (count > number){
        if ([self.type isEqualToString:@"buy"]) {
            [MBProgressHUD gc_showErrorMessage:@"可买数量不足"];
        }
        if ([self.type isEqualToString:@"sell"]) {
            [MBProgressHUD gc_showErrorMessage:@"可卖数量不足"];
        }
        return;
    }
    [self.delegate ensureBtnAction:self.type];
}

-(void)deleteBtnAction{
    [self.delegate deleteBtnAction];
}

-(void)rightAddBtnAction{
    CGFloat number = [self.numberL.text floatValue];
    CGFloat count = [self.rightInputField.text floatValue];
    count += 10.00;
    if (count > number) {
        count -= 10.00;
        if ([self.type isEqualToString:@"buy"]) {
           [MBProgressHUD gc_showErrorMessage:@"可买数量不足"];
        }
        if ([self.type isEqualToString:@"sell"]) {
            [MBProgressHUD gc_showErrorMessage:@"可卖数量不足"];
        }
    }
    self.rightInputField.text = [NSString stringWithFormat:@"%.2f",count];
}

-(void)rightDeleteBtnAction{
    CGFloat count = [self.rightInputField.text floatValue];
    count -= 10.00;
    if (count < 0.00) {
        count += 10.00;
        [MBProgressHUD gc_showErrorMessage:@"不能再少了！"];
    }
    self.rightInputField.text = [NSString stringWithFormat:@"%.2f",count];
}

-(void)leftAddBtnAction{
    CGFloat count = [self.leftInputField.text floatValue];
    count += 0.01;
    self.leftInputField.text = [NSString stringWithFormat:@"%.2f",count];
}

-(void)leftDeleteBtnAction{
    CGFloat count = [self.leftInputField.text floatValue];
    count -= 0.01;
    if (count < 0.00) {
        count += 0.01;
        [MBProgressHUD gc_showErrorMessage:@"不能再少了！"];
    }
    self.leftInputField.text = [NSString stringWithFormat:@"%.2f",count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
