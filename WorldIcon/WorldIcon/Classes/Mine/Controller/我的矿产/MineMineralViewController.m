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

    [self loadMineralsOnNet];

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

    if (indexPath.row == 0) {
        cell.kmLabel.text = @"金矿";
        cell.zlLabel.text = [NSString stringWithFormat:@"总量：%@",_m.vf_jk];
        [cell.complexBtn setTitle:@"合成欧力币" forState:UIControlStateNormal];
    }
    if (indexPath.row == 1) {
        cell.kmLabel.text = @"银矿";
        cell.zlLabel.text = [NSString stringWithFormat:@"总量：%@",_m.vf_yk];
        [cell.complexBtn setTitle:@"锻炼金矿" forState:UIControlStateNormal];
    }
    if (indexPath.row == 2) {
        cell.kmLabel.text = @"铜矿";
        cell.zlLabel.text = [NSString stringWithFormat:@"总量：%@",_m.vf_tk];
        [cell.complexBtn setTitle:@"锻炼银矿" forState:UIControlStateNormal];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self compoundMineralWithType:[NSString stringWithFormat:@"%ld",3-indexPath.row]];;
    
}
-(void)loadMineralsOnNet{

    MineralsRequest *mineralsReq = [MineralsRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
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
        
    }];
    
    mineralsReq.ub_id = [UserManager getUID];
    
    [mineralsReq startRequest];
}
-(void)compoundMineralWithType:(NSString *)action{

    ConvertRequest *convertReq = [ConvertRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
                        
            [self loadMineralsOnNet];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    convertReq.ub_id = [UserManager getUID];
    convertReq.action = action;
    [convertReq startRequest];
    
}
@end
