//
//  TWLAlertView.m
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//eregfg

#import "TWLAlertView.h"
#import <sys/utsname.h>//获取设备型号

#define k_w [UIScreen mainScreen].bounds.size.width
#define k_h [UIScreen mainScreen].bounds.size.height
@implementation TWLAlertView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //创建遮罩
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_w, k_h)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackClick)];
        [self.blackView addGestureRecognizer:tap];
        [self addSubview:_blackView];
        //创建alert
        self.alertview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 150)];
        self.alertview.center = self.center;
        self.alertview.layer.cornerRadius = 3.0;
        self.alertview.clipsToBounds = YES;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertview];
        [self exChangeOut:self.alertview dur:0.6];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.alertview.frame = CGRectMake(0, 0, 270, 150);

    _tipLable = [[UILabel alloc]init];
    _tipLable.text = _title;
    [_tipLable setFont:[UIFont systemFontOfSize:18]];
    [_tipLable setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    _tipLable.frame = CGRectMake(0,10,self.alertview.frame.size.width,43);
    _tipLable.textAlignment = NSTextAlignmentCenter;
    [self.alertview addSubview:_tipLable];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(10, 58, self.alertview.frame.size.width-20, 0.5);
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#999999" alpha:0.5];
    [self.alertview addSubview:line];
    
    [self creatViewWithAlert];

    UILabel *line2 = [UILabel new];
    line2.frame = CGRectMake(10, self.alertview.frame.size.height-45, self.alertview.frame.size.width-20, 0.5);
    line2.backgroundColor = [UIColor gc_colorWithHexString:@"#999999" alpha:0.5];
    [self.alertview addSubview:line2];
    
    NSString* phoneModel = [AppManager iphoneType];//方法在下面
    
    if ([phoneModel isEqualToString:@"iPhone 5"] || [phoneModel isEqualToString:@"iPhone 5c"] || [phoneModel isEqualToString:@"iPhone 5s"]) {
        self.alertview.center = CGPointMake(self.center.x, self.center.y-55);
    }else{
        self.alertview.center = CGPointMake(self.center.x, self.center.y-32);
    }
    
    [self createBtnTitle:_btnTitleArr];
    
}

- (void)creatViewWithAlert
{
    _textF =[[UITextField alloc]initWithFrame:CGRectMake(30, _tipLable.frame.origin.y+ _tipLable.frame.size.height+10, self.alertview.frame.size.width-60, 35)];
    _textF.placeholder = @"请输入对方手机号";
    _textF.returnKeyType = UIReturnKeyDone;
    _textF.textAlignment = NSTextAlignmentCenter;
    _textF.delegate = self;
    [_textF becomeFirstResponder];
    [self.alertview addSubview:_textF];

    UIImageView *bgImg = [[UIImageView alloc]init];
    bgImg.image = [UIImage imageNamed:@"input"];
    bgImg.frame = CGRectMake(30, _tipLable.frame.origin.y+ _tipLable.frame.size.height+40, _textF.frame.size.width, 5);
    [self.alertview addSubview:bgImg];
    
}
- (void)createBtnTitle:(NSArray *)titleArr
{
    
    CGFloat m = self.alertview.frame.size.width;
    
    for (int i=0; i<_numBtn; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_numBtn == 1) {
            btn.frame = CGRectMake(0, self.alertview.frame.size.height-45,(m), 45);
        }else{
            
            btn.frame = CGRectMake(i*(m/2), self.alertview.frame.size.height-45, m/2, 45);
        }
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.alertview addSubview:btn];
        
        if (btn.tag == 101) {
             [btn setTitleColor:[UIColor gc_colorWithHexString:@"#ef3b3c"] forState:(UIControlStateNormal)];
        }else{
             [btn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
        }
        
        //分隔线
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb"];
        [btn addSubview:line];
        
        [self.alertview addSubview:btn];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.alertview.mas_centerX);
            make.width.mas_equalTo(1);
            make.top.equalTo(btn).offset(0);
            make.bottom.equalTo(btn).offset(0);
        }];

    }
}
- (void)blackClick
{
    [self cancleView];
}
- (void)cancleView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
    
}
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

-(void)clickButton:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:password:)]) {
        if (_password == nil) {
            [self textFieldShouldEndEditing:_textF];
            [_textF resignFirstResponder];
        }
        if ([button.titleLabel.text isEqualToString:@"退出页面"]) {
            button.tag = 101;
        }
        [self.delegate didClickButtonAtIndex:button.tag password:_password];
    }
    [self cancleView];
}
-(void)initWithTitle:(NSString *) title contentStr:(NSString *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr

{
    _title = title;
    _type = type;
    _numBtn = btnNum;
    _btnTitleArr = btnTitleArr;
    _contentStr = content;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    _password = textField.text;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
