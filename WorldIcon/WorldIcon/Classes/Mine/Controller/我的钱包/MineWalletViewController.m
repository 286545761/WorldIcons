//
//  MineWalletViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineWalletViewController.h"
#import "WalletHeaderView.h"
#import "WalletCell.h"
#import "RechargeViewController.h"
#import "WithDrawViewController.h"
#import "BalanceRequest.h"
#import "withdrawExplainView.h"
#import "TWLAlertView.h"
#import "OnlineTransferViewController.h"
#import "CTRecordViewController.h"
#import "RechargeAndWithdrawVC.h"
#import "GetReappStatusRequest.h"
#import "CurrentProgressViewController.h"
#import "ShareStateModel.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface MineWalletViewController ()<UITableViewDataSource,UITableViewDelegate,TWlALertviewDelegate,BtnChooseViewDelegate>

@property (nonatomic,strong)UITableView *walletTableView;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)WalletHeaderView *walletHeaderView;
@property (nonatomic,strong)NSDictionary *responseDict;
@property (nonatomic,strong)withdrawExplainView *withdrawExplainView;
@property (nonatomic,strong)NSString *txedStr;
@end

@implementation MineWalletViewController

- (NSDictionary *)responseDict{
    if (!_responseDict) {
        _responseDict = [NSDictionary dictionary];
    }
    return _responseDict;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLabel.text = @"我的钱包";
    self.txedStr = @"0.00";
    [self setUpwalletTableView];
    
    _titleArray = @[@"提现额度",@"美元充值",@"美元提现",@"在线转账",@"充提记录",@"我的收益"];
    
    [self loadUserBalanceOnNet:RefreshNoneType];
    
}
-(void)setUpwalletTableView{
    
    self.walletTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.walletTableView.showsVerticalScrollIndicator = NO;
    self.walletTableView.backgroundColor = [UIColor clearColor];
    self.walletTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.walletTableView.rowHeight = 50;
    [self.view addSubview:self.walletTableView];
    
    self.walletTableView.delegate = self;
    self.walletTableView.dataSource = self;
    __weak typeof (self) weakSelf = self;
    //下拉上拉刷新
    _walletTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadUserBalanceOnNet:RefreshHeadType];
    }];
    
}
-(void)setUpHeaderView:(NSDictionary *)dic{
    
    _walletHeaderView = [[WalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150+15+15+10) withDic:dic];
    self.walletTableView.tableHeaderView = _walletHeaderView;
    
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WalletCell *cell = [tableView dequeueReusableCellWithIdentifier:@"walletCell"];
    if (!cell) {
        cell = [[WalletCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"walletCell"];
    }
    CGSize s = [tool characterAdaption:_titleArray[indexPath.row] withFont:[UIFont systemFontOfSize:15]];
    [cell.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.back).offset(10);
        make.size.mas_equalTo(CGSizeMake(kRatioX6(s.width), kRatioY6(20)));
        make.centerY.mas_equalTo(cell.back.mas_centerY);
    }];
    if (indexPath.row == 0) {
        cell.rightLabel.text = @"提现额度说明";
        UILabel *amountL = [[UILabel alloc]init];
        amountL.text = self.txedStr;
        amountL.textColor = [UIColor gc_colorWithHexString:@"#ff9900"];
        amountL.font = [UIFont systemFontOfSize:13];
        [cell.back addSubview:amountL];
        [amountL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.leftLabel.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(kRatioX6(80), kRatioY6(20)));
            make.centerY.mas_equalTo(cell.back.mas_centerY);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLabel.text = _titleArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
        self.withdrawExplainView = [[withdrawExplainView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.withdrawExplainView.delegate = self;
        [Windown addSubview:self.withdrawExplainView];
    }
    if (indexPath.row == 1) {
        //判断是否有在做的订单
        [self getReappStatusRequestWithType:@"0"];
    }
    if (indexPath.row == 2) {
        
        [self getReappStatusRequestWithType:@"1"];
    }
    if (indexPath.row == 3) {
        //设置备注
        [self loadAlertView:@"提示" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确定", nil] type:11];
    }
    if (indexPath.row == 4) {
        CTRecordViewController *ctRecordVC = [[CTRecordViewController alloc]init];
        [self.navigationController pushViewController:ctRecordVC animated:YES];
    }
}

- (void)bottomPassBtnOnClick{
    [self.withdrawExplainView removeFromSuperview];
}

#pragma mark -- TWLAlertView代理方法
- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSInteger)num btnStrArr:(NSArray *)array type:(NSInteger)typeStr
{
    TWLAlertView *alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [alertView initWithTitle:title contentStr:content type:typeStr btnNum:num btntitleArr:array];
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    
}
-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password{
    
    OnlineTransferViewController *onlineTransferVC = [[OnlineTransferViewController alloc]init];
    
    switch (index) {
        case 101:
            
            if (password.length == 0) {
                
                [MBProgressHUD gc_showErrorMessage:@"请输入对方手机号"];
                
            }else{
                onlineTransferVC.phone = password;
                [self.navigationController pushViewController:onlineTransferVC animated:YES];
                
            }
            break;
        case 100:
            
            break;
        default:
            break;
    }
}

-(void)loadUserBalanceOnNet:(RefreshType )type{
    if (type == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    BalanceRequest *balanceReq = [BalanceRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        [self endRefresh];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            self.txedStr = responseDict[@"txed"];
            [self setUpHeaderView:responseDict];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"请求错误"];
    }];
    balanceReq.ub_id = [UserManager getUID];
    [balanceReq startRequest];
}

-(void)getReappStatusRequestWithType:(NSString *)type{
    [MBProgressHUD gc_showActivityMessageInWindow:@"验证中..."];
    
    GetReappStatusRequest *getreappReq = [GetReappStatusRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            ShareStateModel *m = [[ShareStateModel alloc]initWithDictionary:responseDict error:nil];
            //未接单
            if (![m.vra_status isEqualToString:@"1"]) {
                RechargeAndWithdrawVC *rechargeVC = [[RechargeAndWithdrawVC alloc]init];
                rechargeVC.model = m;
                rechargeVC.type = [type integerValue];
                [self.navigationController pushViewController:rechargeVC animated:YES];
            }else{
                
            }
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        
        [MBProgressHUD gc_showErrorMessage:@"请求错误"];
    }];
    
    getreappReq.ub_id = [UserManager getUID];
    getreappReq.type = type;
    [getreappReq startRequest];
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.walletTableView.mj_header endRefreshing];
    [self.walletTableView.mj_footer endRefreshing];
}


@end

