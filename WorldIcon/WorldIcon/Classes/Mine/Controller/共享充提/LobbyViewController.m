//
//  LobbyViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "LobbyViewController.h"
#import "CTOrderCell.h"
#import "ListTreAppRequest.h"
#import "GXCTModel.h"
#import "SupreappNodeRequest.h"

@interface LobbyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *currentTimeLine;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LobbyViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpcurrentTimeLine];
    
    [self loadListreapp];
    
}
-(void)setUpcurrentTimeLine{
    
    self.currentTimeLine = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44) style:(UITableViewStylePlain)];
    self.currentTimeLine.showsVerticalScrollIndicator = NO;
    self.currentTimeLine.backgroundColor = [UIColor clearColor];
    self.currentTimeLine.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.currentTimeLine.rowHeight = 185;
    [self.view addSubview:self.currentTimeLine];
    
    self.currentTimeLine.delegate = self;
    self.currentTimeLine.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
      return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CTOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ctorderCell"];
    
    if (!cell) {
        cell = [[CTOrderCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ctorderCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    
    @weakify(self);
    cell.supreappBlock = ^(){
        @strongify(self);
        [self supreappnodeWithRow:indexPath.row];
       
    };
    
    return cell;
    
}

-(void)loadListreapp{

    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    ListTreAppRequest *getappReq = [ListTreAppRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.dataArray) {
                [self.dataArray removeAllObjects];
            }
            for (NSDictionary *d in responseDict[@"vm_reapp"]) {
                
                GXCTModel *m = [[GXCTModel alloc]initWithDictionary:d error:nil];
                [self.dataArray addObject:m];
                
            }
            [self.currentTimeLine reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.type = @"0";
    getappReq.page = @"1";
    
    [getappReq startRequest];

}
-(void)supreappnodeWithRow:(NSInteger )row{

    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    SupreappNodeRequest *supreappNodeReq = [SupreappNodeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [self loadListreapp];
         
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    GXCTModel *model = self.dataArray[row];
    
    supreappNodeReq.ub_id = [UserManager getUID];
    supreappNodeReq.vra_id = model.vra_id;
    supreappNodeReq.vrs_status = @"1";
    supreappNodeReq.vrs_pic = @"";
    supreappNodeReq.vrs_info = @"";
    
    [supreappNodeReq startRequest];

}
@end
