//
//  editPersonalInformationViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/3.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "editPersonalInformationViewController.h"


@interface editPersonalInformationViewController ()
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIView *upView;

@property(nonatomic,strong)UITextField *numberTextField;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *provinceTextField;
@property(nonatomic,strong)UITextField *cityTextField;
@property(nonatomic,strong)UIView *downView;
@end

@implementation editPersonalInformationViewController
-(void)setTypeString:(NSString *)typeString{
    
    _typeString=typeString;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"共享者修改";
    
    
    [self makeUI];
    
    
    
}
-(void)makeUI{
    UIView *numberView =[self viewLeftTitile:@"微信账号" WithTextField:self.numberTextField WithTextFieldAction:YES];
    UIView *nameView =[self viewLeftTitile:@"微信名字" WithTextField:self.nameTextField WithTextFieldAction:NO];
    UIView *prView =[self viewLeftTitile:@"省份" WithTextField:self.provinceTextField WithTextFieldAction:YES];
    UIView *cityView =[self viewLeftTitile:@"城市" WithTextField:self.cityTextField WithTextFieldAction:YES];
    [self.upView addSubview:numberView];
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.upView);
        make.top.equalTo(self.upView.mas_top).offset(20);
        make.height.equalTo(@40);
    }];
    
    [self.upView addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.upView);
        make.top.equalTo(numberView.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    [self.downView addSubview:prView];
    [prView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.downView);
        make.top.equalTo(self.downView.mas_top).offset(20);
        make.height.equalTo(@40);
    }];
    
    [self.downView addSubview:cityView];
    [cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.downView);
        make.top.equalTo(prView.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
  
    
    
}
-(UIView *)upView{
    if (!_upView) {
        _upView =[[UIView alloc]init];
        _upView.backgroundColor =[UIColor whiteColor];
        _upView.layer.cornerRadius=5.f;
        _upView.layer.masksToBounds=YES;

    }
    
    
    return _upView;
}
-(UIView *)downView{
    if (!_downView) {
        _downView =[[UIView alloc]init];
        _downView.backgroundColor =[UIColor whiteColor];
        _downView.layer.cornerRadius=5.f;
        _downView.layer.masksToBounds=YES;
        
    }
    
    
    return _downView;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(UIView*)viewLeftTitile:(NSString*)titile WithTextField:(UITextField*)nTextField WithTextFieldAction:(BOOL)isAction{
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 40)];

    UILabel *leftLable =[UILabel gc_labelWithTitle:titile withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:16 withTextAlignment:NSTextAlignmentRight];
    leftLable.frame=CGRectMake(0, 0, 100, 40);
    
    [bgView addSubview:leftLable];
    nTextField =[UITextField gc_textFieldWithPlacHolder:@"" withTextColor:[UIColor gc_colorWithHexString:@"#333333"] withTextFont:16];
    UILabel *rightLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    rightLabel.backgroundColor=[UIColor clearColor];
    [nTextField setValue:[UIColor gc_colorWithHexString:@"#999999"]
                      forKeyPath:@"_placeholderLabel.textColor"];
  nTextField.backgroundColor=[UIColor gc_colorWithHexString:@"#999999" alpha:0.3];
    nTextField.leftView=rightLabel;
   nTextField.leftViewMode=UITextFieldViewModeAlways;
    nTextField.layer.cornerRadius=20.f;
   nTextField.layer.masksToBounds=YES;
    nTextField.delegate=self;
    if (isAction) {
        UIView *rigthtView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 42,40)];
        UIImageView *rightImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 20, 7)];//12*7
        rightImageView.image=[UIImage imageWithRenderOriginalName:@"xiajian"];
        [rigthtView addSubview:rightImageView];
        nTextField.rightView=rigthtView;
        nTextField.rightViewMode=UITextFieldViewModeAlways;
        nTextField.userInteractionEnabled=YES;
    }else{
         nTextField.userInteractionEnabled=NO;
    }

    
    bgView.backgroundColor=[UIColor clearColor];
    [bgView addSubview:nTextField];
    [nTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgView);
        make.left.equalTo(leftLable.mas_right).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-20);
    }];
    
    return bgView;
}
-(void)submitBtnAction{
    
    
    
    
}
-(void)viewDidLayoutSubviews{
            
            [super viewDidLayoutSubviews];
            [self.view addSubview:self.upView];
            [self.view addSubview:self.downView];
            [self.upView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(10);
                make.left.equalTo(self.view.mas_left).offset(10);
                make.right.equalTo(self.view.mas_right).offset(-10);
                make.height.equalTo(@130);
                
            }];
            [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.upView.mas_bottom).offset(10);
                make.left.equalTo(self.view.mas_left).offset(10);
                make.right.equalTo(self.view.mas_right).offset(-10);
                make.height.equalTo(@130);
                
            }];
            
        }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
