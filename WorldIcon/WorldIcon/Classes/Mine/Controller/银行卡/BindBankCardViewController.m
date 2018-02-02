//
//  BindBankCardViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/9.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BindBankCardViewController.h"
#import "InputView.h"
#import "ZHPickView.h"
#import "BundRequest.h"

@interface BindBankCardViewController ()<ZHPickViewDelegate>
@property (nonatomic,strong)ZHPickView *pickerView;
@property (nonatomic,strong)InputView *sjhlLabel;
@property (nonatomic,strong)InputView *khhLabel;
@property (nonatomic,strong)InputView *hyflLabel;
@property (nonatomic,strong)InputView *yzmlLabel;

@end

@implementation BindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpCustomView];
    
}
-(void)setUpCustomView{

    UIScrollView *mainScrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mainScrolView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainScrolView];
    
    UIView *contentView1 = [UIView new];
    contentView1.frame = CGRectMake(0, 0, kScreenWidth, 120);
    contentView1.backgroundColor = [UIColor whiteColor];
    [mainScrolView addSubview:contentView1];
    
    UIView *contentView2 = [UIView new];
    contentView2.frame = CGRectMake(0, 130, kScreenWidth, 120);
    contentView2.backgroundColor = [UIColor whiteColor];
    [mainScrolView addSubview:contentView2];
    
    //添加银行卡
    UIButton *addBankCardBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"完成" withRadius:(35.5*0.5)];
    addBankCardBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addBankCardBtn addTarget:self action:@selector(addBankCardAction) forControlEvents:UIControlEventTouchUpInside];
    [mainScrolView addSubview:addBankCardBtn];
    
    //商家名称
    InputView *khhLabel = [[InputView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 35) withTitle:@"持卡人  " withPlaceholder:@"请输入持卡人"];
    khhLabel.titleLabel.textAlignment = NSTextAlignmentRight;
    [contentView1 addSubview:khhLabel];
    self.khhLabel = khhLabel;
    //卡号
    InputView *hyflLabel = [[InputView alloc]initWithFrame:CGRectMake(10, 65, kScreenWidth-20, 35) withTitle:@"卡号  " withPlaceholder:@"请输入卡号"];
    hyflLabel.titleLabel.textAlignment = NSTextAlignmentRight;
    [contentView1 addSubview:hyflLabel];
    self.hyflLabel = hyflLabel;
    
    InputView *sjhlLabel = [[InputView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 35) withTitle:@"开户行  " withPlaceholder:@"请选择开户行"];
    sjhlLabel.titleLabel.textAlignment = NSTextAlignmentRight;
    [contentView2 addSubview:sjhlLabel];
    self.sjhlLabel = sjhlLabel;
    
    //选择所在地
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(selectkhh) forControlEvents:(UIControlEventTouchUpInside)];
    [rView addSubview:chooseBtn];
    
    self.sjhlLabel.field.rightViewMode = UITextFieldViewModeAlways;
    self.sjhlLabel.field.rightView = rView;
    
    InputView *yzmlLabel = [[InputView alloc]initWithFrame:CGRectMake(10, 65, kScreenWidth-20, 35) withTitle:@"开户行地址" withPlaceholder:@"请输入开户行地址"];
    yzmlLabel.titleLabel.textAlignment = NSTextAlignmentRight;
    [contentView2 addSubview:yzmlLabel];
    self.yzmlLabel = yzmlLabel;
    
    [addBankCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(25));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(yzmlLabel.mas_bottom).offset(kRatioY6(40));
    }];

}
#pragma mark -- 选择开户行
-(void)selectkhh{
    
    [self.view endEditing:YES];
    
    _pickerView=[[ZHPickView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _pickerView.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
    [self.view addSubview:_pickerView];
    
    _pickerView.delegate=self;
    
    [_pickerView showView];
}
#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    self.sjhlLabel.field.text = resultString;
    
}
#pragma mark -- 添加银行卡
-(void)addBankCardAction{
    [self.view endEditing:YES];
    [MBProgressHUD gc_showActivityMessageInWindow:@"添加中..."];
    BundRequest *bundReq = [BundRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [MBProgressHUD gc_showSuccessMessage:@"银行卡添加成功"];
            
            @weakify(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    bundReq.ub_id = [UserManager getUID];
    bundReq.uc_khh = self.sjhlLabel.field.text;
    bundReq.uc_card = self.hyflLabel.field.text;
    bundReq.uc_addr = self.yzmlLabel.field.text;
    bundReq.uc_name = self.khhLabel.field.text;
    bundReq.action = @"1";
    
    [bundReq startRequest];
}

@end
