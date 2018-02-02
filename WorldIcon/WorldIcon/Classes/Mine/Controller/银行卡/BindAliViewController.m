//
//  BindAliViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/9.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BindAliViewController.h"
#import "PriceTableViewCell.h"
#import "InputBuyAndSellView.h"
#import "BuyCoinRequest.h"
#import "MarketRequest.h"
#import "PriceModel.h"
#import "SellCoinRequest.h"
#import "PriceDetailView.h"
@interface BindAliViewController ()<UITableViewDataSource,UITableViewDelegate,InputBuyAndSellViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)InputBuyAndSellView *BuyAndSellView;
@property (nonatomic,strong)NSArray *sellArray;
@property (nonatomic,strong)NSArray *buyArray;
@property (nonatomic,strong)NSDictionary *responseDict;
@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString *currentPrice;
@property (nonatomic,assign)CGFloat buyMaxNum;
@property (nonatomic,assign)CGFloat sellMaxNum;
@property (nonatomic,assign)CGFloat buyMaxPrice;
@property (nonatomic,assign)CGFloat sellMaxPrice;
@end

@implementation BindAliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self initView];
    [self loadCurrentPrice];
    self.sellMaxNum = 0;
    self.buyMaxNum = 0;
    
    self.sellMaxPrice = 0;
    self.buyMaxPrice = 0;
}

#pragma mark -- 获取当前行情
-(void)loadCurrentPrice{
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    MarketRequest *marketReq = [MarketRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            self.responseDict = responseDict;
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *buyNumArray = [NSMutableArray array];
            for (NSDictionary *d in responseDict[@"buy"]) {
                BuyModel *m = [[BuyModel alloc]initWithDictionary:d error:nil];
                [arr addObject:m];
                [buyNumArray addObject:[NSNumber numberWithFloat:[m.num floatValue]]];
            }
            self.buyArray = [NSArray arrayWithArray:arr];
            self.buyMaxNum = [[buyNumArray valueForKeyPath:@"@max.floatValue"] floatValue];
            
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:10];
            NSMutableArray *sellNumArray = [NSMutableArray array];
            for (NSDictionary *d in responseDict[@"sell"]) {
                SellModel *m = [[SellModel alloc]initWithDictionary:d error:nil];
                [tempArray insertObject:m atIndex:0];
                [sellNumArray addObject:[NSNumber numberWithFloat:[m.num floatValue]]];
            }
            self.sellMaxNum = [[sellNumArray valueForKeyPath:@"@max.floatValue"] floatValue];
            self.sellArray = [NSArray arrayWithArray:tempArray];
            [self.tableView reloadData];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    marketReq.ub_id = [UserManager getUID];
    [marketReq startRequest];
}

-(void)ensureBtnAction:(NSString *)type
         withprictText:(NSString *)price
        withamountText:(NSString *)amount{
    self.currentPrice = price;
    self.account = amount;
    if ([type isEqualToString:@"buy"]) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"购买中..."];
        BuyCoinRequest *buyCoinReq = [BuyCoinRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
            [self.BuyAndSellView removeFromSuperview];
            if ([model.code isEqualToString:@"01"]) {
                [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            }else if ([model.code isEqualToString:@"10"]) {
                //买入成功
            }else if([model.code isEqualToString:@"20"]) {
                [MBProgressHUD gc_showErrorMessage:model.info];
            }else{
                [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            }
        } failureBlock:^(NSError *error) {
            [self.BuyAndSellView removeFromSuperview];
            [MBProgressHUD gc_hiddenHUD];
            [MBProgressHUD gc_showErrorMessage:@"网络错误"];
        }];
        buyCoinReq.ub_id = [UserManager getUID];
        buyCoinReq.vb_bc = self.account;
        buyCoinReq.vb_b = self.currentPrice;
        [buyCoinReq startRequest];
    }
    if ([type isEqualToString:@"sell"]) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"卖出中..."];
        SellCoinRequest *sellCoinReq = [SellCoinRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
            [self.BuyAndSellView removeFromSuperview];
            if ([model.code isEqualToString:@"01"]) {
                [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            }else if ([model.code isEqualToString:@"10"]) {
                //卖出成功
            }else if([model.code isEqualToString:@"20"]) {
                [MBProgressHUD gc_showErrorMessage:model.info];
            }else{
                [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            }
        } failureBlock:^(NSError *error) {
            [self.BuyAndSellView removeFromSuperview];
            [MBProgressHUD gc_hiddenHUD];
            [MBProgressHUD gc_showErrorMessage:@"网络错误"];
        }];
        sellCoinReq.ub_id = [UserManager getUID];
        sellCoinReq.vs_sc = self.account;
        sellCoinReq.vs_s = self.currentPrice;
        [sellCoinReq startRequest];
    }
}

-(void)initView{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 30)];
    back.backgroundColor = [UIColor clearColor];
    
    UILabel *leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10+25, 0, 320/2-10-25, 30)];
    leftL.text = @"价格/美元";
    leftL.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    leftL.textAlignment = NSTextAlignmentCenter;
    leftL.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:leftL];
    
    UILabel *rightL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(320/2, 0, 320/2-10, 30)];
    rightL.text = @"数量/oc";
    rightL.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    rightL.textAlignment = NSTextAlignmentCenter;
    rightL.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:rightL];
    self.tableView.tableHeaderView = back;
    
    UIView *footerback = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 80)];
    footerback.backgroundColor = [UIColor clearColor];
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"buyBtn"] forState:UIControlStateNormal];
    [buyBtn setTitle:@"买入" forState:UIControlStateNormal];
    buyBtn.adaptiveIphone5Frame = CGRectMake(50, 0, 80, 80);
    buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchDown];
    [footerback addSubview:buyBtn];
    
    UIButton *sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sellBtn.adaptiveIphone5Frame = CGRectMake(320-50-80, 0, 80, 80);
    [sellBtn setBackgroundImage:[UIImage imageNamed:@"sellBtn"] forState:UIControlStateNormal];
    sellBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [sellBtn setTitle:@"卖出" forState:UIControlStateNormal];
    [sellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sellBtn addTarget:self action:@selector(sellBtnAction) forControlEvents:UIControlEventTouchDown];
    [footerback addSubview:sellBtn];
    
    self.tableView.tableFooterView = footerback;
}

-(void)buyBtnAction{
    if (self.buyArray.count > 0) {
        BuyModel *model = self.buyArray[0];
        self.buyMaxPrice = [model.vb_b floatValue];
    }else
        self.buyMaxPrice = 1.00;
    
    UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
    self.BuyAndSellView = [[InputBuyAndSellView alloc]initWithType:@"buy" withCount:[NSString stringWithFormat:@"%f",([self.responseDict[@"mount"] floatValue]/self.buyMaxPrice)] withPrice:[NSString stringWithFormat:@"%f",self.buyMaxPrice]];
    self.BuyAndSellView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.BuyAndSellView.amount = [self.responseDict[@"mount"] floatValue];
    self.BuyAndSellView.delegate = self;
    [Windown addSubview:self.BuyAndSellView];
}

-(void)sellBtnAction{
    if (self.sellArray.count > 0) {
        SellModel *model = self.sellArray[self.sellArray.count-1];
        self.sellMaxPrice = [model.vs_s floatValue];
    }else
        self.sellMaxPrice = 1.00;
    
    UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
    self.BuyAndSellView = [[InputBuyAndSellView alloc]initWithType:@"sell" withCount:[NSString stringWithFormat:@"%f",([self.responseDict[@"coin"] floatValue]/self.buyMaxPrice)] withPrice:[NSString stringWithFormat:@"%f",self.sellMaxPrice]];
    self.BuyAndSellView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.BuyAndSellView.amount = [self.responseDict[@"coin"] floatValue];
    self.BuyAndSellView.delegate = self;
    [Windown addSubview:self.BuyAndSellView];
}

- (void)deleteBtnAction{
    [self.BuyAndSellView removeFromSuperview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.buyArray.count;
    }
    return self.sellArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"PriceTableViewCell";
    PriceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if (indexPath.row == 0) {
            cell.whiteV.adaptiveIphone5Frame = CGRectMake(10, 20, 300, 10);
        }else if (indexPath.row == 4) {
            cell.whiteV.adaptiveIphone5Frame = CGRectMake(10, 0, 300, 10);
        }else
            cell.whiteV.adaptiveIphone5Frame = CGRectMake(10, 0, 300, 30);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        cell.max = self.buyMaxNum;
        [cell reloadCellBuyModel:self.buyArray[indexPath.row] withIndexpath:indexPath];
    }
    if (indexPath.section == 0) {
        cell.max = self.sellMaxNum;
        [cell reloadCellSellModel:self.sellArray[indexPath.row] withIndexpath:self.sellArray.count-indexPath.row];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIView countBeforeWithIphone5Length:30];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [UIView countBeforeWithIphone5Length:10];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}



-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 64;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.separatorInset = UIEdgeInsetsMake(0,[UIView countBeforeWithIphone5Length:10], 0, [UIView countBeforeWithIphone5Length:10]);
        _tableView.separatorColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
