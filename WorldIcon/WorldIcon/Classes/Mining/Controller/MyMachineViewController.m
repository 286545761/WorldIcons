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
#import "TheMillDetailsView.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};

@interface MyMachineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myMachineTableView;
//页码
@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)MJRefreshAutoNormalFooter *footer;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)TheMillDetailsView *DetailsView;

@end

@implementation MyMachineViewController
-(TheMillDetailsView *)DetailsView{
    if (!_DetailsView) {
        _DetailsView =[[TheMillDetailsView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _DetailsView.typeString=@"1";
        
    }
    return _DetailsView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = @"1";

    [self setUpmyMachineTableView];
    
    [self loadMyMachineOnNetWithPage:RefreshNoneType];
}

-(void)setUpmyMachineTableView{
    
    self.myMachineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49-40) style:(UITableViewStylePlain)];
    self.myMachineTableView.showsVerticalScrollIndicator = NO;
    self.myMachineTableView.backgroundColor = [UIColor clearColor];
    self.myMachineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myMachineTableView.rowHeight = 95;
    [self.view addSubview:self.myMachineTableView];
    
    self.myMachineTableView.delegate = self;
    self.myMachineTableView.dataSource = self;
    __weak typeof (self) weakSelf = self;
    //下拉上拉刷新
    self.myMachineTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadMyMachineOnNetWithPage:RefreshHeadType];
    }];
    self.myMachineTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMyMachineOnNetWithPage:RefreshFootType];
    }];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyMachineSectionHeaderView *headerView = [[MyMachineSectionHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.DetailsView showViewWithDataSource:self.dataArray[indexPath.row]];
    
    
}
-(void)loadMyMachineOnNetWithPage:(RefreshType )type{
    if (type == RefreshFootType) {
        self.page = [NSString stringWithFormat:@"%ld", [self.page integerValue] + 1 ];
    }else{
        self.page = @"1";
    }
    if (type == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    __weak typeof(self) weakSelf = self;
    MyMachineRequest *myMachineReq = [MyMachineRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
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
                weakSelf.myMachineTableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else
                [weakSelf endRefresh];
            for (NSDictionary *item in array) {
                MachineModel *m = [[MachineModel alloc]initWithDictionary:item error:nil];
                [arr addObject:m];
            }
            [weakSelf.dataArray addObjectsFromArray:arr];
            [self.myMachineTableView reloadData];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf endRefresh];
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];

    myMachineReq.page = [self.page integerValue];
    myMachineReq.ub_id = [UserManager getUID];
    [myMachineReq startRequest];
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.myMachineTableView.mj_header endRefreshing];
    [self.myMachineTableView.mj_footer endRefreshing];
}

@end
