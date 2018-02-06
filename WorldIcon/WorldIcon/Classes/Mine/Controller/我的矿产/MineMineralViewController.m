//
//  MineMineralViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineMineralViewController.h"
#import "MineralCell.h"
#import "MineralsRequest.h"
#import "MineralsModel.h"
#import "ConvertRequest.h"
#import "XLAlertView.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface MineMineralViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mineralTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong) MineralsModel *m;
@end

@implementation MineMineralViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"我的矿产";

    [self setUpmineralTableView];

    [self loadMineralsOnNet:RefreshNoneType];

}
-(void)setUpmineralTableView{
    
    self.mineralTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.mineralTableView.showsVerticalScrollIndicator = NO;
    self.mineralTableView.backgroundColor = [UIColor clearColor];
    self.mineralTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mineralTableView.rowHeight = 85;
    [self.view addSubview:self.mineralTableView];
    
    self.mineralTableView.delegate = self;
    self.mineralTableView.dataSource = self;
    
    __weak typeof (self) weakSelf = self;
    //下拉上拉刷新
    self.mineralTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadMineralsOnNet:RefreshHeadType];
    }];
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineraCell"];
    
    if (!cell) {
        cell = [[MineralCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"mineraCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath;
    if (indexPath.row == 0) {
        cell.kmLabel.text = @"金矿";
        if (_m.vf_jk.length == 0) {
            cell.zlLabel.text = [NSString stringWithFormat:@"总量：0"];
        }else
            cell.zlLabel.text = [NSString stringWithFormat:@"总量：%@",_m.vf_jk];
        [cell.complexBtn setTitle:@"合成欧力币" forState:UIControlStateNormal];
    }
    if (indexPath.row == 1) {
        cell.kmLabel.text = @"银矿";
        if (_m.vf_yk.length == 0) {
            cell.zlLabel.text = [NSString stringWithFormat:@"总量：0"];
        }else
            cell.zlLabel.text = [NSString stringWithFormat:@"总量：%@",_m.vf_yk];
        [cell.complexBtn setTitle:@"锻炼金矿" forState:UIControlStateNormal];
    }
    if (indexPath.row == 2) {
        cell.kmLabel.text = @"铜矿";
        if (_m.vf_tk.length == 0) {
            cell.zlLabel.text = [NSString stringWithFormat:@"总量：0"];
        }else
            cell.zlLabel.text = [NSString stringWithFormat:@"总量：%@",_m.vf_tk];
        [cell.complexBtn setTitle:@"锻炼银矿" forState:UIControlStateNormal];
    }
    cell.btnBlock = ^(NSIndexPath *index){
        [self compoundMineralWithType:[NSString stringWithFormat:@"%ld",3-indexPath.row]];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)loadMineralsOnNet:(RefreshType )type{
    if (type == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    MineralsRequest *mineralsReq = [MineralsRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        [self endRefresh];
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            _m = [[MineralsModel alloc]initWithDictionary:responseDict[@"vm_func"] error:nil];
            
            [self.mineralTableView reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [self endRefresh];
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"请求错误"];
    }];
    mineralsReq.ub_id = [UserManager getUID];
    [mineralsReq startRequest];
}

-(void)compoundMineralWithType:(NSString *)action{
    NSString *str;
    if ([action isEqualToString:@"3"]) {
        str = @"您确定要合成欧力币吗？";
    }
    if ([action isEqualToString:@"2"]) {
        str = @"您确定要锻炼金矿吗？";
    }
    if ([action isEqualToString:@"1"]) {
        str = @"您确定要锻炼银矿吗？";
    }
    XLAlertView *xlAlertView = [[XLAlertView alloc] initWithMessage:str sureBtn:@"确认" cancleBtn:@"取消"];
    xlAlertView.resultIndex = ^(NSInteger index){
        //回调---处理一系列动作
        if (index == 1) {//取消
        }
        if (index == 2) {//确定
            [MBProgressHUD gc_showActivityMessageInWindow:@"合成中..."];
            ConvertRequest *convertReq = [ConvertRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
                [MBProgressHUD gc_hiddenHUD];
                if ([model.code isEqualToString:@"01"]) {
                    [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
                }else if ([model.code isEqualToString:@"10"]) {
                    [self loadMineralsOnNet:RefreshNoneType];
                }else if([model.code isEqualToString:@"20"]) {
                    [MBProgressHUD gc_showErrorMessage:model.info];
                }else{
                    [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
                }
            } failureBlock:^(NSError *error) {
                [MBProgressHUD gc_hiddenHUD];
            }];
            convertReq.ub_id = [UserManager getUID];
            convertReq.action = action;
            [convertReq startRequest];
        }
    };
    [xlAlertView showXLAlertView];
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.mineralTableView.mj_header endRefreshing];
    [self.mineralTableView.mj_footer endRefreshing];
}

@end
