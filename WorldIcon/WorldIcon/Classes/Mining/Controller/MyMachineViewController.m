//
//  MyMachineViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MyMachineViewController.h"
#import "MyMachineCell.h"
#import "MyMachineSectionHeaderView.h"
#import "MyMachineRequest.h"
#import "MachineModel.h"

@interface MyMachineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myMachineTableView;
@property (nonatomic,assign)NSInteger   page;
@property (nonatomic,strong)MJRefreshAutoNormalFooter *footer;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MyMachineViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;

    [self setUpmyMachineTableView];
    
    [self loadMyMachineOnNetWithPage:self.page];

    [self addRefresh];
}

-(void)addRefresh{
    
    @weakify(self);
    //默认block方法：设置下拉刷新
    self.myMachineTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        self.page = 1;
        [self loadMyMachineOnNetWithPage:self.page];
    }];
    
    //默认block方法：设置上拉加载更多
    self.myMachineTableView.mj_footer = _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        @strongify(self);
        self.page++;
        [self loadMyMachineOnNetWithPage:self.page];
    }];
}
#pragma mark -- 停止刷新
-(void)endRefresh{
    
    if (self.page == 1) {
        
        [self.myMachineTableView.mj_header endRefreshing];
    }
    [_footer endRefreshing];
    
}
-(void)setUpmyMachineTableView{
    
    self.myMachineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49-40) style:(UITableViewStylePlain)];
    self.myMachineTableView.showsVerticalScrollIndicator = NO;
    self.myMachineTableView.backgroundColor = [UIColor clearColor];
    self.myMachineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myMachineTableView.rowHeight = 85;
    [self.view addSubview:self.myMachineTableView];
    
    self.myMachineTableView.delegate = self;
    self.myMachineTableView.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMachineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mymachineCell"];
    
    if (!cell) {
        cell = [[MyMachineCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"mymachineCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyMachineSectionHeaderView *headerView = [[MyMachineSectionHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(void)loadMyMachineOnNetWithPage:(NSInteger)page{

    MyMachineRequest *myMachineReq = [MyMachineRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary *item in responseDict[@"machine"]) {
             
                MachineModel *m = [[MachineModel alloc]initWithDictionary:item error:nil];
                [self.dataArray addObject:m];
            }
            
            [self.myMachineTableView reloadData];

            [self.myMachineTableView.mj_header endRefreshing];
            [_footer endRefreshing];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];

    myMachineReq.page = page;
    myMachineReq.ub_id = [UserManager getUID];
    
    [myMachineReq startRequest];
    
}
@end
