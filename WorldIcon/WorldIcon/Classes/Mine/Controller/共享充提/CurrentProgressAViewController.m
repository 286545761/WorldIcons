//
//  CurrentProgressAViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/1.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CurrentProgressAViewController.h"
#import "CurrentProgressAView.h"
#import "CurrentProgressCell.h"
#import "GetReappRequest.h"
#import "SupreappNodeRequest.h"

@interface CurrentProgressAViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *currentProgressTableView;

@property (nonatomic,strong)CurrentProgressAView *currentProHeaderView;

@property (nonatomic,strong)NSDictionary *reappDic;

@property (nonatomic,strong)NSMutableArray *reappStatusArray;

@end

@implementation CurrentProgressAViewController
- (NSMutableArray *)reappStatusArray{
    if (!_reappStatusArray) {
        _reappStatusArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _reappStatusArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    switch ([self.model.vra_type intValue]) {
        case 0://充值
            
            self.navLabel.text = @"充值进度";
//            [self type2];
            
            break;
        case 1://提现
            self.navLabel.text = @"提现进度";

//            [self type3];

            break;
    
        default:
            break;
    }
    [self setUpcurrentProgressTableView];
    
    [self loadGetReappWithModel:self.model];
}

-(void)setUpcurrentProgressTableView{
    
    self.currentProgressTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.currentProgressTableView.showsVerticalScrollIndicator = NO;
//    self.currentProgressTableView.backgroundColor = [UIColor redColor];
    self.currentProgressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.currentProgressTableView.rowHeight = 100;
    [self.view addSubview:self.currentProgressTableView];
    
    self.currentProgressTableView.delegate = self;
    self.currentProgressTableView.dataSource = self;
    
}
-(void)setUpHeaderView:(NSDictionary *)dic{
    
    if ([dic[@"vra_type"] intValue] == 1) {
      _currentProHeaderView = [[CurrentProgressAView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 160) withDic:dic];
    }else{
      _currentProHeaderView = [[CurrentProgressAView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 130) withDic:dic];
    }
  
    self.currentProgressTableView.tableHeaderView = _currentProHeaderView;
    
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reappStatusArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currentProCell"];
    if (!cell) {
        cell = [[CurrentProgressCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"currentProCell"];
    }
    cell.model = self.reappStatusArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if ([self.reappDic[@"vra_type"] integerValue ] == 1) {//提现
        if (indexPath.row == self.reappStatusArray.count-1) {
            cell.rightBottomLabel.hidden = NO;
            cell.confirmBtn.hidden = NO;
            cell.rightBottomLabel.text = @"共享者已打款";
            @weakify(self);
            cell.confirmBlock = ^(){
                @strongify(self);
                [self supreappnodeWithModel1:self.model];
                
            };
        }
    }else{
        if (self.reappStatusArray.count == 2) {
            if (indexPath.row == self.reappStatusArray.count-1) {
                cell.rightBottomLabel.hidden = NO;
                cell.confirmBtn.hidden = NO;
                cell.rightBottomLabel.text = @"共享者确认收钱";
                @weakify(self);
                cell.confirmBlock = ^(){
                    @strongify(self);
                    [self supreappnodeWithModel:self.model];
                    
                };
            }
        }
    }
    
//    
//    if (self.reappStatusArray.count == 1) {
//        
//        if (indexPath.row == self.reappStatusArray.count-1) {
//            cell.rightBottomLabel.hidden = NO;
//            cell.confirmBtn.hidden = NO;
//            cell.rightBottomLabel.text = @"共享者已打款";
//            @weakify(self);
//            cell.confirmBlock = ^(){
//                @strongify(self);
//                [self supreappnodeWithModel:self.model];
//                
//            };
//        }
//    }
//    
//    if (self.reappStatusArray.count == 2) {
//        if (indexPath.row == self.reappStatusArray.count-1) {
//            cell.rightBottomLabel.hidden = NO;
//            cell.confirmBtn.hidden = NO;
//            cell.rightBottomLabel.text = @"共享者确认收钱";
//            @weakify(self);
//            cell.confirmBlock = ^(){
//                @strongify(self);
//                [self supreappnodeWithModel:self.model];
//                
//            };
//        }
//    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)loadGetReappWithModel:(ReApp *)model{
    
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.currentProgressTableView reloadData];
            });
            
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }

    } failureBlock:^(NSError *error) {
        
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = model.vra_id;
    [getappReq startRequest];
    
}
-(void)supreappnodeWithModel:(ReApp *)model{
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];

    SupreappNodeRequest *getappReq = [SupreappNodeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = model.vra_id;
    getappReq.vrs_status = @"3";
    getappReq.vrs_info = @"";
    getappReq.vrs_pic = @"";
    
    [getappReq startRequest];
}
-(void)supreappnodeWithModel1:(ReApp *)model{
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];

    SupreappNodeRequest *getappReq = [SupreappNodeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = model.vra_id;
    getappReq.vrs_status = @"2";
    getappReq.vrs_info = @"";
    getappReq.vrs_pic = @"";
    
    [getappReq startRequest];
}

@end
