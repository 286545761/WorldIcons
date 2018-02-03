//
//  HistoryViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryHeaderView.h"
#import "HistoryCell.h"
#import "BuySellRequest.h"
#import "PriceModel.h"
#import "PriceDetailView.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface HistoryViewController ()<UITableViewDataSource,UITableViewDelegate,PriceDetailViewDelegate>

@property (nonatomic,strong)UITableView *HistoryTb;

@property (nonatomic,strong)NSArray *sectionArray;

@property (nonatomic,strong)NSMutableArray *historyArray;

@property (nonatomic,strong)PriceDetailView *priceDetailView;

//页码
@property (nonatomic,strong)NSString *page;
@end

@implementation HistoryViewController

- (NSMutableArray *)historyArray{
    if (!_historyArray) {
        _historyArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _historyArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = @"1";
//    self.navLabel.text = @"历史记录";

    [self setUpHistoryTb];
    
//    self.sectionArray = @[@"2017-10-01",@"2017-10-03",@"2017-10-05"];

    [self loadHistoryData:RefreshNoneType];
}

-(void)setUpHistoryTb{
    
    self.HistoryTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44-44) style:(UITableViewStyleGrouped)];
    self.HistoryTb.showsVerticalScrollIndicator = NO;
    self.HistoryTb.backgroundColor = [UIColor clearColor];
    self.HistoryTb.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HistoryTb.rowHeight = 60;
    [self.view addSubview:self.HistoryTb];
    
    self.HistoryTb.delegate = self;
    self.HistoryTb.dataSource = self;
    
    HistoryHeaderView *headerView = [[HistoryHeaderView alloc]init];
    headerView.frame = CGRectMake(20, 0, kScreenWidth-40, 35);
    self.HistoryTb.tableHeaderView = headerView;
    __weak typeof (self) weakSelf = self;
    //下拉上拉刷新
    _HistoryTb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHistoryData:RefreshHeadType];
    }];
    _HistoryTb.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadHistoryData:RefreshFootType];
    }];
}

#pragma mark -- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.historyArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HistoryListModel *m = self.historyArray[section];
    return m.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    if (!cell) {
        cell = [[HistoryCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"historyCell"];
    }
    HistoryListModel *m = self.historyArray[indexPath.section];
    cell.model = m.list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    sectionView.backgroundColor = [UIColor clearColor];

    UILabel *sectionLabel = [UILabel gc_labelWithTitle:@"2017-12-05" withTextColor:[UIColor gc_colorWithHexString:@"#666666"] withTextFont:(14) withTextAlignment:(NSTextAlignmentLeft)];
    sectionLabel.frame = CGRectMake(10, 0, 150, 35);
    HistoryListModel *m = self.historyArray[section];
    sectionLabel.text = [NSString stringWithFormat:@"%@",m.vsb_date];
    [sectionView addSubview:sectionLabel];
    return sectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel *model = self.historyArray[indexPath.row];
    UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
    self.priceDetailView = [[PriceDetailView alloc]initWithListModel:model];
    self.priceDetailView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.priceDetailView.delegate = self;
    [Windown addSubview:self.priceDetailView];
}

- (void)bottomPassBtnOnClick{
    [self.priceDetailView removeFromSuperview];
}

-(void)loadHistoryData:(RefreshType )type{
    if (type == RefreshFootType) {
        self.page = [NSString stringWithFormat:@"%ld", [self.page integerValue] + 1 ];
    }else{
        self.page = @"1";
    }
    if (type == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    __weak typeof(self) weakSelf = self;
    BuySellRequest *buySellReq = [BuySellRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [weakSelf endRefresh];
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
            NSMutableArray *arr = [NSMutableArray array];
            NSArray *array = responseDict[@"historyList"];
            if (array.count && type == RefreshFootType) {
                weakSelf.page = [@([weakSelf.page integerValue] + 1) stringValue];
            }else if(type == RefreshHeadType || type == RefreshNoneType) {
                weakSelf.page = @"1";
                [weakSelf.historyArray removeAllObjects];
            }
            if ([weakSelf.page integerValue]>=[responseDict[@"total"] integerValue]) {
                weakSelf.HistoryTb.mj_footer.state = MJRefreshStateNoMoreData;
            }else
                [weakSelf endRefresh];
            for (NSDictionary *d in responseDict[@"historyList"]) {
                HistoryListModel *m = [[HistoryListModel alloc]initWithDictionary:d error:nil];
                [arr addObject:m];
            }
            [weakSelf.historyArray addObjectsFromArray:arr];
            [self.HistoryTb reloadData];
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
    buySellReq.ub_id = [UserManager getUID];
    buySellReq.type = @"2";
    buySellReq.page = self.page;
    [buySellReq startRequest];
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.HistoryTb.mj_header endRefreshing];
    [self.HistoryTb.mj_footer endRefreshing];
}
@end
