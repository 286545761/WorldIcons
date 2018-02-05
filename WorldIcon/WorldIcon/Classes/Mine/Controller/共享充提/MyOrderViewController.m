//
//  MyOrderViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderCell.h"
#import "ListTreAppRequest.h"
#import "GXCTModel.h"
#import "CurrentProgressAViewController.h"
#import "newCurrentProgressAViewController.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myOrderTb;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MyOrderViewController

-(void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    
    [self loadListreapp];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpmyOrderTb];
    
//    [self loadListreapp];
}
-(void)setUpmyOrderTb{
    
    self.myOrderTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44) style:(UITableViewStylePlain)];
    self.myOrderTb.showsVerticalScrollIndicator = NO;
    self.myOrderTb.backgroundColor = [UIColor clearColor];
    self.myOrderTb.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myOrderTb.rowHeight = 135;
    [self.view addSubview:self.myOrderTb];
    
    self.myOrderTb.delegate = self;
    self.myOrderTb.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myorderCell"];
    
    if (!cell) {
        cell = [[MyOrderCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"myorderCell"];
    }
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    newCurrentProgressAViewController *currentProVC =[[newCurrentProgressAViewController alloc]init];
//    CurrentProgressAViewController *currentProVC = [[CurrentProgressAViewController alloc]init];
//    currentProVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:currentProVC animated:YES];
    
}
-(void)loadListreapp{
    
    ListTreAppRequest *getappReq = [ListTreAppRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.dataArray) {
                [self.dataArray removeAllObjects];
            }
            for (NSDictionary *d in responseDict[@"vm_reapp"]) {
                
                ReApp *m = [[ReApp alloc]initWithDictionary:d error:nil];
                
                [self.dataArray addObject:m];
                
            }
            
            [self.myOrderTb reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.type = @"3";
    getappReq.page = @"1";
    
    [getappReq startRequest];
    
}

@end
