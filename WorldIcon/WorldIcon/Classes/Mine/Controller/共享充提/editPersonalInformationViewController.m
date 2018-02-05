//
//  editPersonalInformationViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/3.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "editPersonalInformationViewController.h"
#import "SubappRequest.h"
#import "GetCardRequest.h"
#import "CardModel.h"
#import "ZHPickView.h"



@interface editPersonalInformationViewController ()<UITextFieldDelegate,ZHPickViewDelegate>
@property (nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIView *upView;

@property(nonatomic,strong)UITextField *numberTextField;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *provinceTextField;
@property(nonatomic,strong)UITextField *cityTextField;
@property(nonatomic,strong)UIView *downView;
@property(nonatomic,strong)NSMutableArray* dataSoureceArray;
@property(nonatomic,strong)NSMutableArray* allCardListArray;


@end

@implementation editPersonalInformationViewController
-(NSMutableArray *)allCardListArray{
    if (!_allCardListArray) {
        _allCardListArray =[[NSMutableArray alloc]init];
    }
    
    return _allCardListArray;
}
-(NSMutableArray *)dataSoureceArray{
    if (!_dataSoureceArray) {
        _dataSoureceArray =[[NSMutableArray alloc]init];
    }
    return _dataSoureceArray;
}
-(void)setTypeString:(NSString *)typeString{
    
    _typeString=typeString;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"共享者修改";
    
    
    [self makeUI];
    
    [self loadDataAllCard];
    
    
}
-(void)loadDataAllCard{
    
    GetCardRequest *getCardReq = [GetCardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.dataSoureceArray.count) {
                [self.dataSoureceArray removeAllObjects];
            }
            
            for (NSDictionary *item in responseDict[@"user_card"]) {
                
                CardModel *m = [[CardModel alloc]initWithDictionary:item error:nil];
                [self.allCardListArray addObject:m.uc_card];
                [self.dataSoureceArray addObject:m];
            }
            
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    if ([self.typeString isEqualToString:@"0"]) {// 银行
         getCardReq.type=@"1";

    }else if ([self.typeString isEqualToString:@"1"]){// 微信

         getCardReq.type=@"1";
        
    }else if ([self.typeString isEqualToString:@"2"]){//支付宝
        
         getCardReq.type=@"1";
        
        
    }
    
    getCardReq.ub_id = [UserManager getUID];
   
    
    [getCardReq startRequest];
    
    
}
-(void)changeAllCardInfo{
    
    SubappRequest*subApp = [SubappRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if (
                  [model.code isEqualToString:@"10"]) {
            
            
            
//            [MBProgressHUD gc_showSuccessMessage:@"保证金提交成功"];
//
//            @weakify(self);
//            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
//
//            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                @strongify(self);
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
    if ([self.typeString isEqualToString:@"0"]) {// 银行
      
        subApp.va_card=@"1";
        subApp.va_weixin=@"0";
        subApp.va_wx_zh=@"0";
        subApp.va_zhifubao=@"0";
        subApp.va_zf_zh=@"0";
        subApp.va_wx_name=@"0";
        subApp.va_zf_name=@"0";
        subApp.va_khh=self.nameTextField.text;
        subApp.va_name=@"";
        subApp.va_yhzh=self.numberTextField.text;
    }else if ([self.typeString isEqualToString:@"1"]){// 微信

        subApp.va_card=@"0";
        subApp.va_weixin=@"1";
        subApp.va_wx_zh=self.numberTextField.text;
        subApp.va_zhifubao=@"0";
        subApp.va_zf_zh=@"0";
        subApp.va_wx_name=self.nameTextField.text;
        subApp.va_zf_name=@"0";
        subApp.va_khh=@"";
        subApp.va_name=@"";
        subApp.va_yhzh=@"";

        
    }else if ([self.typeString isEqualToString:@"2"]){//支付宝
    
        subApp.va_card=@"0";
        subApp.va_weixin=@"0";
        subApp.va_wx_zh=@"0";
        subApp.va_zhifubao=@"1";
        subApp.va_zf_zh=self.numberTextField.text;
        subApp.va_wx_name=@"0";
        subApp.va_zf_name=self.nameTextField.text;
        subApp.va_khh=@"";
        subApp.va_name=@"";
        subApp.va_yhzh=@"";

        
        
    }
      subApp.type=@"0";
    subApp.va_sf=self.provinceTextField.text;
    subApp.va_cs=self.cityTextField.text;
     subApp.ub_id = [UserManager getUID];

    
    [subApp startRequest];
    
    
    
}
-(void)makeUI{
    
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
    

    
    NSString *acountTextType;
    NSString *acountNumberString;
    NSString *acountTextName;
    NSString *acountName;
    NSString *SFStrig;
    NSString*cityString;
    if ([self.typeString isEqualToString:@"0"]) {
        acountTextType=@"银行账户";
        acountNumberString=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_yhzh"]];
        acountTextName=@"账户姓名";
        acountName=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_name"]];
     
    }else if ([self.typeString isEqualToString:@"1"]){
        acountTextType=@"微信账号";
        acountNumberString=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_wx_zh"]];
        acountTextName=@"微信姓名";
        acountName=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_wx_name"]];
        
    }else if ([self.typeString isEqualToString:@"2"]){
        
        acountTextType=@"支付号账号";
        acountNumberString=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_zf_zh"]];
        acountTextName=@"支付宝姓名";
        acountName=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_zf_name"]];
 
        
    }
    SFStrig=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_sf"]];
    cityString=[NSString stringWithFormat:@"%@",self.AccountInformationDictionary[@"vm_rere"][@"vr_cs"]];;
    
    UIView *numberView =[self viewLeftTitile:acountTextType WithTextField:self.numberTextField WithTextFieldAction:YES withTage:1000];
    UIView *nameView =[self viewLeftTitile:acountTextName WithTextField:self.nameTextField WithTextFieldAction:NO withTage:1001];
    UIView *prView =[self viewLeftTitile:@"省份" WithTextField:self.provinceTextField WithTextFieldAction:YES withTage:1002];
    UIView *cityView =[self viewLeftTitile:@"城市" WithTextField:self.cityTextField WithTextFieldAction:YES withTage:1003];
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
    
    self.numberTextField.text=acountNumberString;
    self.nameTextField.text=acountName;
    self.provinceTextField.text=SFStrig;
    self.cityTextField.text=cityString;
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(35);
        make.right.equalTo(self.view.mas_right).offset(-35);
        make.top.equalTo(self.downView.mas_bottom).offset(30);
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
}

-(UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    
    return _submitBtn;
}
-(UIView*)viewLeftTitile:(NSString*)titile WithTextField:(UITextField*)nTextField WithTextFieldAction:(BOOL)isAction withTage:(NSInteger)tage{
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
        rigthtView.userInteractionEnabled=YES;
        UIImageView *rightImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 20, 7)];//12*7
        rightImageView.tag=tage;
        rightImageView.image=[UIImage imageWithRenderOriginalName:@"xiajian"];
        [rigthtView addSubview:rightImageView];
        rightImageView.userInteractionEnabled=YES;
        nTextField.rightView=rigthtView;
        UITapGestureRecognizer *reg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listInfo:)];
        [rightImageView addGestureRecognizer:reg];
        nTextField.rightViewMode=UITextFieldViewModeAlways;
        
    }
   
//    }else{
//         nTextField.userInteractionEnabled=NO;
//    }
//        nTextField.userInteractionEnabled=NO;
    
    bgView.backgroundColor=[UIColor clearColor];
    [bgView addSubview:nTextField];
    [nTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgView);
        make.left.equalTo(leftLable.mas_right).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-20);
    }];
    switch (tage) {
        case 1000:
            self.numberTextField=nTextField;
            break;
        case 1001:
            self.nameTextField=nTextField;
            break;
        case 1002:
            self.provinceTextField=nTextField;
            break;
        case 1003:
           self.cityTextField=nTextField;
            break;
            
        default:
            break;
    }
    return bgView;
}

-(void)listInfo:(UITapGestureRecognizer*)tag{
    UIImageView *rightImageView =(UIImageView*)tag.view;
    switch (rightImageView.tag) {
        case 1000:
            [self showAllCards];
            break;
        case 1001:
            
            break;
        case 1002:
            [self changeCity];
            break;
        case 1003:
            [self changeCity];
            break;
        default:
            break;
    }
    
    
    
}
-(void)changeCity{
    
    
    
}
-(void)submitBtnAction{
    
    
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
    
}
    
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField ==self.numberTextField) {
////        [self showAllCards];
//
//    }else if (textField==self.nameTextField){
//
//
//
//    }else if (textField==self.provinceTextField){
//
//
//
//    }else if (textField==self.cityTextField){
//
//
//
//
//    }
//
//}
-(void)showAllCards{
    if (self.allCardListArray.count>0) {
        if (self.pickview) {
            self.pickview=nil;
        }
        _pickview = [[ZHPickView alloc]initWithArray:self.allCardListArray];
        _pickview.frame = CGRectMake(0, 0, GCWidth, GCHeight);
        //    _pickview.tag = 100+index.section;
        _pickview.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
        [self.view addSubview:_pickview];
        _pickview.delegate=self;
        [_pickview showView];
        
    }
    
    
}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if ([self.allCardListArray containsObject:resultString]) {
        
        CardModel *m=self.dataSoureceArray[[self.allCardListArray indexOfObject:resultString]];
   
        self.numberTextField.text=m.uc_card;
        self.nameTextField.text=m.uc_name;
        
        
        
    }
    
    
}


@end
