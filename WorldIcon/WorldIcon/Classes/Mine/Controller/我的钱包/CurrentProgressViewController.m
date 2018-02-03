//
//  CurrentProgressViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/31.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CurrentProgressViewController.h"
#import "CurrentProgressHeaderView.h"
#import "CurrentProgressCell.h"
#import "InputView.h"
#import "GetReappRequest.h"
#import "GXCTModel.h"
#import "SupreappRequest.h"
#import "ConfirmTransferMoneyViewController.h"
#import "SRActionSheet.h"
#import "GetCardRequest.h"
#import "CardModel.h"

@interface CurrentProgressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *cardsArray;
@property (nonatomic,strong)NSMutableArray *cardNumArray;

@property (nonatomic,strong)UITableView *currentProgressTableView;

@property (nonatomic,strong)CurrentProgressHeaderView *currentProHeaderView;

@property (nonatomic,strong)NSDictionary *reappDic;

@property (nonatomic,strong)NSMutableArray *reappStatusArray;

@property (nonatomic,strong)InputView *czyhkhLabel;

@property (nonatomic,strong)InputView *label1;
@property (nonatomic,strong)InputView *label2;

@property (nonatomic,strong)NSString *uc_id;//银行卡ID
@end

@implementation CurrentProgressViewController
- (NSMutableArray *)cardNumArray{
    if (!_cardNumArray) {
        _cardNumArray = [NSMutableArray array];
    }
    return _cardNumArray;
}
- (NSMutableArray *)cardsArray{
    if (!_cardsArray) {
        _cardsArray = [NSMutableArray array];
    }
    return _cardsArray;
}
-(NSMutableArray *)reappStatusArray{
    if (!_reappStatusArray) {
        _reappStatusArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _reappStatusArray;
}

-(NSDictionary *)reappDic{
    if (!_reappDic) {
        _reappDic = [NSDictionary dictionary];
    }
    return _reappDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.dic) {
        
    }else{
    
        [self.dic setValue:self.vra_id forKey:@"vra_id"];
        [self.dic setValue:@"1"  forKey:@"vra_status"];
        [self.dic setValue:@"1"  forKey:@"vra_order_status"];

    }
    
    switch ([self.dic[@"vra_status"] integerValue]) {
        case 0:
            [self type1];//没有订单
            break;
        case 1:
            self.navLabel.text = @"当前进度";

            [self type2];//有订单
            break;
        default:
            break;
    }
}
#pragma mark -- 没有订单
-(void)type1{
    
    switch ([self.type intValue]) {
        case 0:
            self.navLabel.text = @"充值";
            
            [self type5];
            break;
        case 1:
            self.navLabel.text = @"提现";
            
            [self type6];
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark ---- 有订单在做
-(void)type2{
    
    switch ([self.dic[@"vra_order_status"] intValue]) {
        case 0:
            [self type3];
            break;
        case 1:
            [self type4];
            break;
            
        default:
            break;
    }
}
#pragma 已经被接单
-(void)type4{
    
    [self loadGetReappWithDic:self.dic];
    
    [self setUpcurrentProgressTableView];
}
#pragma mark -- 等待接单
-(void)type3{
    
    [MBProgressHUD gc_showWarnMessage:@"等待接单..."];
    
    @weakify(self);
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    });
}
#pragma mark ----------- 充值
-(void)type5{
    InputView *czyhkhLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 40, kScreenWidth-60, 40) withTitle:@"充值金额" withPlaceholder:@"请输入充值金额"];
    [self.view addSubview:czyhkhLabel];
    self.czyhkhLabel = czyhkhLabel;
    
    //提交充值按钮
    UIButton *submitApplyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交充值" withRadius:(35.5*0.5)];
    submitApplyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitApplyBtn addTarget:self action:@selector(inputAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitApplyBtn];
    
    [submitApplyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(30));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(30));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(czyhkhLabel.mas_bottom).offset(20);
    }];

}
#pragma mark ------- 提现
-(void)type6{

    //提现银行卡号
    InputView *label1 = [[InputView alloc]initWithFrame:CGRectMake(27, 40, kScreenWidth-54, 40) withTitle:@"提现银行卡号" withPlaceholder:@"请选择银行卡号"];
    [self.view addSubview:label1];
    self.label1 = label1;
    //提现金额
    InputView *label2 = [[InputView alloc]initWithFrame:CGRectMake(27, 95, kScreenWidth-54, 40) withTitle:@"提现金额" withPlaceholder:@"请输入充值金额"];
    [self.view addSubview:label2];
    self.label2 = label2;

    //选择所在地
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    
    UIButton *chooseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chooseBtn.frame = CGRectMake(5, 7.5, 20, 20);
    [chooseBtn setImage:[UIImage imageNamed:@"向下"] forState:(UIControlStateNormal)];
    chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [chooseBtn setTitle:@"" forState:(UIControlStateNormal)];
    [chooseBtn addTarget:self action:@selector(selectUserCards) forControlEvents:(UIControlEventTouchUpInside)];
    [rView addSubview:chooseBtn];
    
    self.label1.field.rightViewMode = UITextFieldViewModeAlways;
    self.label1.field.rightView = rView;
    
    //提交申请按钮
    UIButton *submitApplyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交申请" withRadius:(35.5*0.5)];
    submitApplyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitApplyBtn addTarget:self action:@selector(outputAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitApplyBtn];
    
    [submitApplyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(27));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(27));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.label2.mas_bottom).offset(20);
    }];
    
}
-(void)selectUserCards{
    
    [self loadUserCardsOnNet];
}

-(void)showUserCards{

    
    [SRActionSheet sr_showActionSheetViewWithTitle:@"选择银行卡"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:@""
                                 otherButtonTitles:self.cardNumArray
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                      if (actionIndex == -1) {
                                          
                                      }else{
                                          
                                          CardModel *m = self.cardsArray[actionIndex];
                                          self.label1.field.text = [NSString stringWithFormat:@"%@",m.uc_card];
                                          self.uc_id = [NSString stringWithFormat:@"%@",m.uc_id];
                                          
                                      }
                                  }];

}
-(void)setUpcurrentProgressTableView{
    
    self.currentProgressTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.currentProgressTableView.showsVerticalScrollIndicator = NO;
    self.currentProgressTableView.backgroundColor = [UIColor clearColor];
    self.currentProgressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.currentProgressTableView.rowHeight = 100;
    [self.view addSubview:self.currentProgressTableView];
    
    self.currentProgressTableView.delegate = self;
    self.currentProgressTableView.dataSource = self;
    
}
-(void)setUpHeaderView:(NSDictionary *)dic{
    
    _currentProHeaderView = [[CurrentProgressHeaderView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 130) withDic:dic];
    self.currentProgressTableView.tableHeaderView = _currentProHeaderView;
    
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reappStatusArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currentCell"];
    if (!cell) {
        cell = [[CurrentProgressCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"currentCell"];
    }
    
    cell.model = self.reappStatusArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //充值
    if ([self.reappDic[@"vra_type"] intValue] ==0) {
        
        if (self.reappStatusArray.count == 1) {
    
            cell.confirmBtn.hidden = NO;
            cell.rightBottomLabel.hidden = NO;
            cell.rightBottomLabel.text = @"用户确认汇钱";
    
            cell.confirmBlock = ^(){
                //跳转转账界面
                ConfirmTransferMoneyViewController *confireVC = [[ConfirmTransferMoneyViewController alloc]init];
                confireVC.vra_id =self.dic[@"vra_id"];
                confireVC.vrs_status = @"2";
                [self.navigationController pushViewController:confireVC animated:YES];
            };
        }

    }
    
    //提现
    if ([self.reappDic[@"vra_type"] intValue] ==1 ) {
    
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)loadGetReappWithDic:(NSDictionary *)dic{

    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];

    GetReappRequest *getappReq = [GetReappRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }else if ([model.code isEqualToString:@"10"]) {
            
            self.reappDic = responseDict[@"vm_reapp"];

            [self setUpHeaderView:self.reappDic];

            for (NSDictionary *d in responseDict[@"vm_reapp_status"]) {
                ReAppStatus *m = [[ReAppStatus alloc]initWithDictionary:d error:nil];
                
                [self.reappStatusArray addObject:m];
            }
            
            [self.currentProgressTableView reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = dic[@"vra_id"];
    [getappReq startRequest];

}
#pragma mark -- 充值
-(void)inputAction{
    [self submitApplyActionWithType:@"0"];
}
#pragma mark -- 提现
-(void)outputAction{
    [self submitApplyActionWithType:@"1"];
}
#pragma mark --- 提现充值操作
-(void)submitApplyActionWithType:(NSString *)type{

    SupreappRequest *getappReq = [SupreappRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_type = type;

    if ([type isEqualToString:@"0"]) {
        getappReq.uc_id = @"";
        getappReq.vra_fee = self.czyhkhLabel.field.text;
    }else{
        getappReq.uc_id = self.uc_id;//银行卡标识
        getappReq.vra_fee = self.label2.field.text;
    }
    getappReq.vra_zh_type = @"0";//0 银行卡 1 微信 2支付宝 3 BTC
    [getappReq startRequest];

}
-(void)loadUserCardsOnNet{
    
    GetCardRequest *getCardReq = [GetCardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.cardsArray) {
                
                [self.cardsArray removeAllObjects];
                [self.cardNumArray removeAllObjects];
                
            }
            for (NSDictionary *item in responseDict[@"user_card"]) {
                
                CardModel *m = [[CardModel alloc]initWithDictionary:item error:nil];
                
                [self.cardsArray addObject:m];
                
                [self.cardNumArray addObject:m.uc_card];
                
            }
            
            [self showUserCards];
            
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
