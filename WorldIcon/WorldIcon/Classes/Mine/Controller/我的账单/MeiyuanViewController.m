//
//  MeiyuanViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/21.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MeiyuanViewController.h"
#import "BillCell.h"
#import "BillRequest.h"
#import "BillModel.h"

@interface MeiyuanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *billTableView;
@property (nonatomic,assign)NSInteger   page;
@property (nonatomic,strong)NSMutableArray      *dataArray;
@property (nonatomic,strong)MJRefreshAutoNormalFooter *footer;

@end

@implementation MeiyuanViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpbillTableView];
    
    self.page = 1;
    [self loadBillOnNetWithPage:self.page];
    
    [self addRefresh];

}
-(void)addRefresh{
    
    @weakify(self);
    //默认block方法：设置下拉刷新
    self.billTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        
        self.page = 1;
        [self loadBillOnNetWithPage:self.page];
        
    }];
    
    //默认block方法：设置上拉加载更多
    self.billTableView.mj_footer = _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        self.page++;
        
        [self loadBillOnNetWithPage:self.page];
    }];
}
#pragma mark -- 停止刷新
-(void)endRefresh{
    
    if (_page == 1) {
        
        [self.billTableView.mj_header endRefreshing];
    }
    [_footer endRefreshing];
    
}

-(void)setUpbillTableView{
    
    self.billTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
        if (@available(iOS 11.0, *)) {
            self.billTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44);
        }
    }else{
        self.billTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    }
    self.billTableView.showsVerticalScrollIndicator = NO;
    self.billTableView.backgroundColor = [UIColor clearColor];
    self.billTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.billTableView.rowHeight = 95;
    [self.view addSubview:self.billTableView];
    
    self.billTableView.delegate = self;
    self.billTableView.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"billCell"];
    if (!cell) {
        cell = [[BillCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"billCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    header.backgroundColor = KBackgroundColor;

    NSArray *titleArray = @[@"内容/时间",@"金额"];
    for (int i = 0; i < 2; i++) {
        UILabel *label = [UILabel gc_labelWithTitle:titleArray[i] withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:15 withTextAlignment:(NSTextAlignmentCenter)];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.frame = CGRectMake(kScreenWidth/2*i, 0, kScreenWidth/2, 40);
        [header addSubview:label];
    }

    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(void)loadBillOnNetWithPage:(NSInteger)page{
    
    BillRequest *billReq = [BillRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (page == 1) {
                
                [self.dataArray removeAllObjects];
            }
            
            if (page > [responseDict[@"total"] integerValue]) {
                
                [_footer setTitle:@"--我是有底线的--" forState:MJRefreshStateNoMoreData];
                
                [_footer endRefreshingWithNoMoreData];
                
                [self.billTableView.mj_header endRefreshing];

                return ;
            }
            
            for (NSDictionary *item in responseDict[@"coin_order"]) {
                
                BillModel *m = [[BillModel alloc]initWithDictionary:item error:nil];
                [self.dataArray addObject:m];
                
            }
            
            [self.billTableView reloadData];
            
            [self.billTableView.mj_header endRefreshing];
            [_footer endRefreshing];
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [self.billTableView.mj_header endRefreshing];
    }];
    
    billReq.ub_id = [UserManager getUID];
    billReq.page = page;
    billReq.type = @"1";
    
    [billReq startRequest];
    
}

@end
