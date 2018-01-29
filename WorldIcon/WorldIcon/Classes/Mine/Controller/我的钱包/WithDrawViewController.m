//
//  WithDrawViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/20.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WithDrawViewController.h"
#import "InputView.h"
#import "GetCardRequest.h"
#import "CardModel.h"
#import "SRActionSheet.h"
#import "CashRequest.h"
#import "PaymentView.h"

@interface WithDrawViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *withDrawTableView;
@property (nonatomic,strong)NSMutableArray *cardsArray;
@property (nonatomic,strong)InputView *czjeLabel;
@property (nonatomic,strong)InputView *czyhkhLabel;
@property (nonatomic,strong)PaymentView  *payMentView;

@end

@implementation WithDrawViewController
- (NSMutableArray *)cardsArray{
    if (!_cardsArray) {
        _cardsArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _cardsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"美元提现";

    [self setUpwithDrawTableView];
    
    [self setUpHeaderView];
    
    [self loadUserCardsOnNet];
    
}
-(void)setUpwithDrawTableView{
    
    self.withDrawTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.withDrawTableView.showsVerticalScrollIndicator = NO;
    self.withDrawTableView.backgroundColor = [UIColor clearColor];
    self.withDrawTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.withDrawTableView.rowHeight = 40;
    [self.view addSubview:self.withDrawTableView];
    
    self.withDrawTableView.delegate = self;
    self.withDrawTableView.dataSource = self;
    
}
-(void)setUpHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    
    UIView *content1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 168)];
    content1.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:content1];

    //提现金额
    InputView *czjeLabel = [[InputView alloc]initWithFrame:CGRectMake(27, 40, kScreenWidth-54, 35) withTitle:@"提现金额" withPlaceholder:@"请输入充值金额"];
    [content1 addSubview:czjeLabel];
    self.czjeLabel = czjeLabel;
    
    //提现银行卡号
    InputView *czyhkhLabel = [[InputView alloc]initWithFrame:CGRectMake(27, 90, kScreenWidth-54, 35) withTitle:@"银行卡号" withPlaceholder:@"请选择银行卡号"];
    [content1 addSubview:czyhkhLabel];
    self.czyhkhLabel = czyhkhLabel;
    
    //选择所在地
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(selectUserCards) forControlEvents:(UIControlEventTouchUpInside)];
    [rView addSubview:chooseBtn];
    
    self.czyhkhLabel.field.rightViewMode = UITextFieldViewModeAlways;
    self.czyhkhLabel.field.rightView = rView;
    
    UIView *content2 = [[UIView alloc]initWithFrame:CGRectMake(0, 168, kScreenWidth, 82)];
    content2.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    [headerView addSubview:content2];
    
    //提交申请按钮
    UIButton *submitApplyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交申请" withRadius:(35.5*0.5)];
    submitApplyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitApplyBtn addTarget:self action:@selector(submitApplyAction) forControlEvents:UIControlEventTouchUpInside];
    [content2 addSubview:submitApplyBtn];
    
    [submitApplyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView).offset(kRatioX6(50));
        make.right.mas_equalTo(headerView).offset(-kRatioX6(50));
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(content2.mas_bottom).offset(0);
    }];

    self.withDrawTableView.tableHeaderView = headerView;
    
}
-(void)selectUserCards{

    [SRActionSheet sr_showActionSheetViewWithTitle:@"选择银行卡"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:@""
                                 otherButtonTitles:self.cardsArray
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                      if (actionIndex == -1) {
                                          
                                      }else{
                                          self.czyhkhLabel.field.text = self.cardsArray[actionIndex];
                                      }
                                  }];

}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark -- 提现
-(void)submitApplyAction{

    PaymentView *view = [[PaymentView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    view.redbag_moneyLabel1.text = [NSString stringWithFormat:@"$%@",self.czjeLabel.field.text];
    view.redbag_InfoLabel.text = @"提现";
    
    [kAppWindow addSubview:view];
    
    self.payMentView = view;
    
    @weakify(self);
    view.password.passwordBlock = ^(NSString *password) {
        @strongify(self);
        if (password.length==6) {
            [self enterCode:[NSString md5:password]];
        }
    };
    
}
-(void)enterCode:(NSString *)code{
    
    [self cashOnNet:code];
    
    [self.payMentView removeFromSuperview];
}

-(void)cashOnNet:(NSString *)code{

    CashRequest *cashReq = [CashRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
        
            @weakify(self);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
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
        
    }];
    
    cashReq.ub_id = [UserManager getUID];
    cashReq.ut_card =  self.czyhkhLabel.field.text;
    cashReq.ut_mount = self.czjeLabel.field.text;
    cashReq.ud_pay = code;
    cashReq.ut_khh = @"";
    cashReq.ut_name = @"";
    
    [cashReq startRequest];

}

-(void)loadUserCardsOnNet{

    GetCardRequest *getCardReq = [GetCardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.cardsArray) {
                [self.cardsArray removeAllObjects];
            }
            
            for (NSDictionary *item in responseDict[@"user_card"]) {
                
                CardModel *m = [[CardModel alloc]initWithDictionary:item error:nil];
                
                [self.cardsArray addObject:m.uc_card];
            }
  
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getCardReq.ub_id = [UserManager getUID];
    
    [getCardReq startRequest];

}
@end
