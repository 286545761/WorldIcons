//
//  MachineShopViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MachineShopViewController.h"
#import "MachineShopSectionHeaderView.h"
#import "MachineShopCell.h"
#import "MachineRequest.h"
#import "BuyMachineRequest.h"
#import "MachinesModel.h"

#import "PaymentView.h"

@interface MachineShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView              *machineShopTableView;
@property (nonatomic,assign)NSInteger                 page;
@property (nonatomic,strong)MJRefreshAutoNormalFooter *footer;
@property (nonatomic,strong)NSMutableArray            *dataArray;
@property (nonatomic,strong)PaymentView               *payMentView;

@end

@implementation MachineShopViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;

    [self setUpMachineShopTableView];
    
    [self loadMachinesOnNetWithPage:self.page];

    [self addRefresh];
    
}
-(void)addRefresh{
    
    @weakify(self);
    //默认block方法：设置下拉刷新
    self.machineShopTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        self.page = 1;

        [self loadMachinesOnNetWithPage:self.page];
        
    }];
    
    //默认block方法：设置上拉加载更多
    self.machineShopTableView.mj_footer = _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        @strongify(self);
        self.page++;
        [self loadMachinesOnNetWithPage:self.page];
        
    }];
}
-(void)setUpMachineShopTableView{

    self.machineShopTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49-40) style:(UITableViewStylePlain)];
    self.machineShopTableView.showsVerticalScrollIndicator = NO;
    self.machineShopTableView.backgroundColor = [UIColor clearColor];
    self.machineShopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.machineShopTableView.rowHeight = 85;
    [self.view addSubview:self.machineShopTableView];
    
    self.machineShopTableView.delegate = self;
    self.machineShopTableView.dataSource = self;

}
#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    MachineShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"machineshopCell"];
    
    if (!cell) {
        cell = [[MachineShopCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"machineshopCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MachinesModel *model = self.dataArray[indexPath.row];

    cell.model = model;
    
    cell.block = ^(){
    
        PaymentView *view = [[PaymentView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
        view.redbag_moneyLabel1.text = [NSString stringWithFormat:@"$%@",model.cm_value];
        view.redbag_InfoLabel.text = @"购买矿机";

        [kAppWindow addSubview:view];
        
        self.payMentView = view;
        
        @weakify(self);
        view.password.passwordBlock = ^(NSString *password) {
            @strongify(self);
            if (password.length==6) {
                [self enterCode:[NSString md5:password] withModel:model];
            }
        };
    };
    return cell;

}
#pragma mark --- 余额支付
-(void)enterCode:(NSString *)code withModel:(MachinesModel *)model{
    
    [self buyMachineOnNetWithCm_id:model.cm_id cm_value:model.cm_value ud_pay:code];
    
    [self.payMentView removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MachineShopSectionHeaderView *headerView = [[MachineShopSectionHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
 
    
}
-(void)loadMachinesOnNetWithPage:(NSInteger)page{
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    MachineRequest *machineReq = [MachineRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary *item in responseDict[@"machine"]) {
                
                MachinesModel *m = [[MachinesModel alloc]initWithDictionary:item error:nil];
                [self.dataArray addObject:m];
            }
            
            [self.machineShopTableView reloadData];
            
            [self.machineShopTableView.mj_header endRefreshing];
            [_footer endRefreshing];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    machineReq.page = page;
    machineReq.ub_id = [UserManager getUID];
    
    [machineReq startRequest];
    
}

-(void)buyMachineOnNetWithCm_id:(NSString *)cm_id cm_value:(NSString *)cm_value ud_pay:(NSString *)ud_pay{

        BuyMachineRequest *buyMachineReq = [BuyMachineRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            //返回我的矿机列表
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    buyMachineReq.ub_id = [UserManager getUID];
    buyMachineReq.cm_id = cm_id;
    buyMachineReq.cm_value = cm_value;
    buyMachineReq.ud_pay = ud_pay;
    
    [buyMachineReq startRequest];

}
@end
