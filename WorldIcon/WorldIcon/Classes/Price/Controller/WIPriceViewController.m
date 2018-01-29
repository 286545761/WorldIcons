//
//  WIPriceViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIPriceViewController.h"
#import "PriceSectionHeaderView.h"
#import "PriceSectionFooterView.h"
#import "PriceCell.h"
#import "DealView.h"

#import "EntrustViewController.h"
#import "HistoryViewController.h"

#import "MarketRequest.h"
#import "PriceModel.h"

#import "BuyCoinRequest.h"
#import "SellCoinRequest.h"

@interface WIPriceViewController ()<UITableViewDataSource,UITableViewDelegate,PriceSectionFooterViewDelegate,DealViewDelagate>
@property (nonatomic,assign) CGFloat currentPrice;
@property (nonatomic,assign) CGFloat account;

@property (nonatomic,strong)UITableView *priceTableView;
@property (nonatomic,strong)UIWindow *window1;
@property (nonatomic,strong)DealView *dealView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)NSArray *sellArray;
@property (nonatomic,strong)NSMutableArray *buyArray;
@property (nonatomic,strong)NSDictionary *responseDict;
@end

@implementation WIPriceViewController
- (NSDictionary *)responseDict{
    if (!_responseDict) {
        _responseDict = [NSDictionary dictionary];
    }
    return _responseDict;
}
- (NSArray *)sellArray{
    if (!_sellArray) {
        _sellArray = [NSArray array];
    }
    return _sellArray;
}
-(NSMutableArray *)buyArray{
    if (!_buyArray) {
        _buyArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _buyArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"行情";
   
    [self setUpRightBarButton];
    
    [self setUpLeftBarButton];
    
    [self setUppriceTableView];
    
    [self loadCurrentPrice];
    
}
#pragma mark --
-(void)setUpRightBarButton{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"历史记录" style:(UIBarButtonItemStyleDone) target:self action:@selector(historyAction)];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = btn;
}

#pragma mark --
-(void)setUpLeftBarButton{
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"当前委托" style:(UIBarButtonItemStyleDone) target:self action:@selector(entrustAction)];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem = btn;
}

-(void)setUppriceTableView{
    
    self.priceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.priceTableView.showsVerticalScrollIndicator = NO;
    self.priceTableView.backgroundColor = [UIColor clearColor];
    self.priceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.priceTableView.rowHeight = 45;
    [self.view addSubview:self.priceTableView];
    
    self.priceTableView.delegate = self;
    self.priceTableView.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sellArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"priceCell"];
    
    if (!cell) {
        cell = [[PriceCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"priceCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {//卖
        cell.tag = 3001;
        cell.index = [NSString stringWithFormat:@"%ld",(5-indexPath.row)];

        cell.sellModel = self.sellArray[indexPath.row];
    }
    if (indexPath.section == 1) {//买
        cell.tag = 3002;
        cell.index = [NSString stringWithFormat:@"%ld",(indexPath.row+1)];

        cell.buyModel = self.buyArray[indexPath.row];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 35 :10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section== 1 ? 50 :0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        PriceSectionHeaderView *headerView = [[PriceSectionHeaderView alloc]init];
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 35);
        
        return headerView;
    }else{
        return nil;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (section == 1) {
        PriceSectionFooterView *footerView = [[PriceSectionFooterView alloc]init];
        footerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        footerView.backgroundColor = [UIColor whiteColor];
        footerView.delegate = self;
        
        return footerView;
    }else{
        return nil;
    }
}
#pragma mark -- 历史按钮
-(void)historyAction{

    HistoryViewController *historyVC = [[HistoryViewController alloc]init];
    historyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:historyVC animated:YES];
    
}
#pragma mark -- 委托按钮
-(void)entrustAction{

    EntrustViewController *entrustVC = [[EntrustViewController alloc]init];
    entrustVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:entrustVC animated:YES];
    
}
#pragma mark PriceSectionFooterViewDelegate
-(void)priceSectionViewFooterView:(UIView *)footerView didClickButton:(NSInteger)tag{

    if (tag == 2003) {//买入
        //计算可买数量
        /*
         "amount": "0.00" 用户余额
         "mount": "0.00", 用户可用余额
         "coin": 0,  用户欧力币数量
         "kycoin": 0 用户可用欧力币数量
         */
        //用户可用余额
        NSString *str3 = [self.responseDict[@"mount"] stringByReplacingOccurrencesOfString:@"," withString:@""];
        CGFloat mount = [str3 floatValue];
        //当前欧力币价格
        PriceCell *cell = [self.priceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        self.currentPrice = [cell.jyPrice.text floatValue];
        //可买数量
        self.account = mount/self.currentPrice;
        
        CGFloat account = self.account;
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.backView.backgroundColor = [UIColor gc_colorWithHexString:@"#575757" alpha:.5];

        self.dealView = [[DealView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 195) withDealType:@"买入" withNumber:[NSString stringWithFormat:@"可买%.2lf个",self.account] withField1:cell.jyPrice.text withField2:[NSString stringWithFormat:@"%.2lf个",self.account]];
        self.dealView.delegate = self;
        
        self.dealView.center = self.backView.center;
        [self.backView addSubview:self.dealView];
        
        self.window1 =[UIApplication sharedApplication].keyWindow;

        [self.window1 addSubview:self.backView];
        
        @weakify(self);
        self.dealView.pricejianblock = ^(){
            @strongify(self);
            
            if (self.currentPrice <= 0.1) {
                [MBProgressHUD gc_showErrorMessage:@"不能低于0.1"];

                return ;
            }
            
           self.currentPrice = self.currentPrice - 0.1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.priceField.text = [NSString stringWithFormat:@"%.2lf",self.currentPrice];
            });
            
        };
        self.dealView.pricejiablock = ^(){
            @strongify(self);
            
            self.currentPrice = self.currentPrice + 0.1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.priceField.text = [NSString stringWithFormat:@"%.2lf",self.currentPrice];
            });
        };
        self.dealView.accountjianblock = ^(){
            @strongify(self);
            
            self.account = self.account - 10;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.countField.text = [NSString stringWithFormat:@"%.2lf",self.account];
            });

        };
        self.dealView.accountjiablock = ^(){
            @strongify(self);
            
            if (self.account >= account) {
                [MBProgressHUD gc_showErrorMessage:@"超出数量"];

                return ;
            }
            
            self.account = self.account + 10;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.countField.text = [NSString stringWithFormat:@"%.2lf",self.account];
            });
        };
        
        self.dealView.didClickButtonBlock = ^(){
            @strongify(self);

            [self buyOnlyCoin];
            
            [self.dealView removeFromSuperview];
            
            [self.backView removeFromSuperview];
            
        };
    }
    if (tag == 2004) {//卖出
        
        self.account = [self.responseDict[@"kycoin"] floatValue];
        //计算可卖数量
        
        PriceCell *cell = [self.priceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        
        self.currentPrice = [cell.jyPrice.text floatValue];
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.backView.backgroundColor = [UIColor gc_colorWithHexString:@"#575757" alpha:.5];
        
        self.dealView = [[DealView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 195) withDealType:@"卖出" withNumber:[NSString stringWithFormat:@"可卖%@个",self.responseDict[@"kycoin"]] withField1:cell.jyPrice.text withField2:[NSString stringWithFormat:@"%@个",self.responseDict[@"kycoin"]]];
        self.dealView.delegate = self;
        self.dealView.center = self.backView.center;
        [self.backView addSubview:self.dealView];
        
        self.window1 =[UIApplication sharedApplication].keyWindow;
        
        [self.window1 addSubview:self.backView];
        
        @weakify(self);
        self.dealView.pricejianblock = ^(){
            @strongify(self);
            
            if (self.currentPrice <= 0.1) {
                [MBProgressHUD gc_showErrorMessage:@"不能低于0.1"];

                return ;
            }
            
            self.currentPrice = self.currentPrice - 0.1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.priceField.text = [NSString stringWithFormat:@"%.2lf",self.currentPrice];
            });
            
        };
        self.dealView.pricejiablock = ^(){
            @strongify(self);
            
            self.currentPrice = self.currentPrice + 0.1;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.priceField.text = [NSString stringWithFormat:@"%.2lf",self.currentPrice];
            });
        };
        self.dealView.accountjianblock = ^(){
            @strongify(self);
            
            self.account = self.account - 10;

            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.countField.text = [NSString stringWithFormat:@"%.2lf",self.account];
            });
            
        };
        self.dealView.accountjiablock = ^(){
            @strongify(self);
            
            if (self.account >= [self.responseDict[@"kycoin"] floatValue]) {

                [MBProgressHUD gc_showErrorMessage:@"超出数量"];

                return ;
            }
            self.account = self.account + 10;

            dispatch_async(dispatch_get_main_queue(), ^{
                self.dealView.countField.text = [NSString stringWithFormat:@"%.2lf",self.account];
            });
        };
        
        self.dealView.didClickButtonBlock = ^(){
            @strongify(self);

            [self sellOnlyCoin];
            
            [self.dealView removeFromSuperview];
            
            [self.backView removeFromSuperview];
            
        };
    }
}
-(void)closeDealView:(DealView *)dealView{
    
    [self.dealView removeFromSuperview];
    
    [self.backView removeFromSuperview];
    
}

-(void)cancleDealView:(DealView *)dealView{
    
    [self.dealView removeFromSuperview];
    
    [self.backView removeFromSuperview];
    
}
#pragma mark -- 买入欧力币
-(void)buyOnlyCoin{

    BuyCoinRequest *buyCoinReq = [BuyCoinRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
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
        [MBProgressHUD gc_hiddenHUD];
        
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    
    buyCoinReq.ub_id = [UserManager getUID];
    
    buyCoinReq.vb_bc = [NSString stringWithFormat:@"%.2lf",self.account];
    
    buyCoinReq.vb_b = [NSString stringWithFormat:@"%.2lf",self.currentPrice];
    
    [buyCoinReq startRequest];

}
#pragma mark -- 卖出欧力币
-(void)sellOnlyCoin{
    
    SellCoinRequest *sellCoinReq = [SellCoinRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
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
        [MBProgressHUD gc_hiddenHUD];
        
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    
    sellCoinReq.ub_id = [UserManager getUID];
    
    sellCoinReq.vs_sc = [NSString stringWithFormat:@"%.2lf",self.account];
    
    sellCoinReq.vs_s = [NSString stringWithFormat:@"%.2lf",self.currentPrice];
    
    [sellCoinReq startRequest];

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
            
            for (NSDictionary *d in responseDict[@"buy"]) {
                
                BuyModel *m = [[BuyModel alloc]initWithDictionary:d error:nil];
                
                [self.buyArray addObject:m];
            }
            NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:10];
            
            for (NSDictionary *d in responseDict[@"sell"]) {
                
                SellModel *m = [[SellModel alloc]initWithDictionary:d error:nil];
                
                [tempArray addObject:m];
                
                self.sellArray = [[tempArray reverseObjectEnumerator] allObjects];
            }
 
            [self.priceTableView reloadData];
            
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
@end
