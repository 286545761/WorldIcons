//
//  toDepositOrturnsOutMarginViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/3.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "toDepositOrturnsOutMarginViewController.h"


@interface toDepositOrturnsOutMarginViewController ()
@property(nonatomic,strong)UILabel *LefthasMonLable;
@property(nonatomic,strong)UILabel *righthasMonLable;

@property(nonatomic,strong)UITextField *inputMonTextField;
@property(nonatomic,strong)UILabel *leftInputMonLabel;
@property(nonatomic,strong)UILabel *rightInputMonLabel;
@property(nonatomic,strong)UIButton  *submitBtn;
@property(nonatomic,strong)UIView   *bgView;
@end

@implementation toDepositOrturnsOutMarginViewController
-(void)setTypeString:(NSString *)typeString{
    _typeString=typeString;
    if ([typeString isEqualToString: @"0"]) {
        self.title=@"转入保证金";
        
    }else{
        self.title=@"转出保证金";
        
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.height.equalTo(@150);
    }];
    [self.bgView addSubview:self.LefthasMonLable];
    //    self.LefthasMonLable .backgroundColor=[UIColor redColor];
    [self.LefthasMonLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(30);
        make.left.equalTo(self.bgView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [self.bgView addSubview:self.righthasMonLable];
    [self.righthasMonLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.LefthasMonLable.mas_centerY).offset(0);
        make.right.equalTo(self.bgView.mas_right).offset(-30);
        make.left.equalTo(self.LefthasMonLable.mas_right).offset(10);
        make.height.equalTo(@40);
        
    }];
    [self.bgView addSubview: self.leftInputMonLabel];
    [self.leftInputMonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.LefthasMonLable.mas_bottom).offset(10);
        make.left.equalTo(self.bgView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.bgView addSubview:  self.rightInputMonLabel ];
    [self.rightInputMonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftInputMonLabel.mas_centerY).offset(0);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.bgView addSubview: self.inputMonTextField];
    [self.inputMonTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftInputMonLabel.mas_centerY).offset(0);
        make.right.equalTo(self.rightInputMonLabel.mas_left).offset(-10);
        make.left.equalTo(self.leftInputMonLabel.mas_right).offset(10);
        make.height.equalTo(@40);
    }];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(35);
        make.right.equalTo(self.view.mas_right).offset(-35);
        make.height.equalTo(@40);
        
    }];

    
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView =[[UIView alloc]init];
        _bgView.backgroundColor =[UIColor whiteColor];
        _bgView.layer.cornerRadius=5.f;
        _bgView.layer.masksToBounds=YES;
        
    }
    
    return _bgView ;
}
-(UILabel *)LefthasMonLable{
    
    if (!_LefthasMonLable) {
        NSString *titile;
        
        if ([self.typeString isEqualToString:@"0"]) {
            titile=@"可用账户余额";
            
        }else{
            titile=@"保证金金额";
            
        }
        _LefthasMonLable =[UILabel gc_labelWithTitle:titile withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    return _LefthasMonLable;
    
}

-(UILabel *)righthasMonLable{
    if (!_righthasMonLable) {
        _righthasMonLable =[UILabel gc_labelWithTitle:@"     888" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:16 withTextAlignment:NSTextAlignmentLeft];
        _righthasMonLable.backgroundColor=[UIColor gc_colorWithHexString:@"#999999" alpha:0.3];
        _righthasMonLable.layer.cornerRadius=20.f;
        _righthasMonLable.layer.masksToBounds=YES;
        
        
        
    }
    return _righthasMonLable;
    
}
-(UILabel *)rightInputMonLabel{
    if (!_rightInputMonLabel) {
        _rightInputMonLabel =[UILabel gc_labelWithTitle:@"元" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:16 withTextAlignment:NSTextAlignmentLeft];
    }
    
    return _rightInputMonLabel;
}
-(UILabel *)leftInputMonLabel{
    if (!_leftInputMonLabel) {
        NSString *titile;
        
        if ([self.typeString isEqualToString:@"0"]) {
            titile=@"保证金金额";
            
        }else{
            titile=@"转出金额";
            
        }
        _leftInputMonLabel =[UILabel gc_labelWithTitle:titile withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    }
    
    return _leftInputMonLabel;
}
-(UITextField *)inputMonTextField{
    
    if (!_inputMonTextField) {
        _inputMonTextField =[UITextField gc_textFieldWithPlacHolder:@"请输入金额" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:16];
        UILabel *rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
        rightLabel.backgroundColor=[UIColor clearColor];
        [_inputMonTextField setValue:[UIColor gc_colorWithHexString:@"#999999"]
                          forKeyPath:@"_placeholderLabel.textColor"];
        _inputMonTextField.backgroundColor=[UIColor gc_colorWithHexString:@"#999999" alpha:0.3];
        _inputMonTextField.leftView=rightLabel;
        _inputMonTextField.leftViewMode=UITextFieldViewModeAlways;
        _inputMonTextField.layer.cornerRadius=20.f;
        _inputMonTextField.layer.masksToBounds=YES;
        
    }
    
    return _inputMonTextField;
}

-(UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//        _submitBtn.adaptiveIphone5Frame = CGRectMake(35, 20, 320-70, 40);
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    
    return _submitBtn;
}
-(void)submitBtnAction{
    
    
    
}

@end
