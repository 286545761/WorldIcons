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
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface MachineShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView              *machineShopTableView;
//页码
@property (nonatomic,strong)NSString *page;
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

    self.page = @"1";

    [self setUpMachineShopTableView];
    
    [self loadMachinesOnNetWithPage:RefreshNoneType];
}
-(void)setUpMachineShopTableView{

    self.machineShopTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49-40) style:(UITableViewStylePlain)];
    self.machineShopTableView.showsVerticalScrollIndicator = NO;
    self.machineShopTableView.backgroundColor = [UIColor clearColor];
    self.machineShopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.machineShopTableView.rowHeight = 95;
    [self.view addSubview:self.machineShopTableView];
    
    self.machineShopTableView.delegate = self;
    self.machineShopTableView.dataSource = self;
    
    __weak typeof (self) weakSelf = self;
    //下拉上拉刷新
    self.machineShopTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadMachinesOnNetWithPage:RefreshHeadType];
    }];
    self.machineShopTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMachinesOnNetWithPage:RefreshFootType];
    }];

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
        view.backgroundColor = RGBA(0, 0, 0, 0.3f);
        view.redbag_moneyLabel1.text = [NSString stringWithFormat:@"OC %@",model.cm_value];
        view.redbag_InfoLabel.text = @"购买矿机";
        view.payType = 3;
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
    headerView.backgroundColor = KBackgroundColor;
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(void)loadMachinesOnNetWithPage:(RefreshType )type{
    if (type == RefreshFootType) {
        self.page = [NSString stringWithFormat:@"%ld", [self.page integerValue] + 1 ];
    }else{
        self.page = @"1";
    }
    if (type == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    __weak typeof(self) weakSelf = self;
    MachineRequest *machineReq = [MachineRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [weakSelf endRefresh];
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            NSMutableArray *arr = [NSMutableArray array];
            NSArray *array = responseDict[@"machine"];
            if (array.count && type == RefreshFootType) {
                weakSelf.page = [@([weakSelf.page integerValue] + 1) stringValue];
            }else if(type == RefreshHeadType || type == RefreshNoneType) {
                weakSelf.page = @"1";
                [weakSelf.dataArray removeAllObjects];
            }
            if ([weakSelf.page integerValue]>=[responseDict[@"total"] integerValue]) {
                weakSelf.machineShopTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else
                [weakSelf endRefresh];
            for (NSDictionary *item in responseDict[@"machine"]) {
                MachinesModel *m = [[MachinesModel alloc]initWithDictionary:item error:nil];
                [arr addObject:m];
            }
            [weakSelf.dataArray addObjectsFromArray:arr];
            [self.machineShopTableView reloadData];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf endRefresh];
        [MBProgressHUD gc_hiddenHUD];
    }];
    machineReq.page = [self.page integerValue];
    machineReq.ub_id = [UserManager getUID];
    [machineReq startRequest];
}

-(void)buyMachineOnNetWithCm_id:(NSString *)cm_id cm_value:(NSString *)cm_value ud_pay:(NSString *)ud_pay{
    [MBProgressHUD gc_showActivityMessageInWindow:@"支付中..."];
    BuyMachineRequest *buyMachineReq = [BuyMachineRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            //返回我的矿机列表
            [MBProgressHUD gc_showSuccessMessage:@"购买矿机成功"];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    buyMachineReq.ub_id = [UserManager getUID];
    buyMachineReq.cm_id = cm_id;
    buyMachineReq.cm_value = cm_value;
    buyMachineReq.ud_pay = ud_pay;
    [buyMachineReq startRequest];
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.machineShopTableView.mj_header endRefreshing];
    [self.machineShopTableView.mj_footer endRefreshing];
}
 
@end
