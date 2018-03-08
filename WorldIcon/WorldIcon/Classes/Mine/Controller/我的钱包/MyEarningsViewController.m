//
//  MyEarningsViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/6.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "MyEarningsViewController.h"
#import "MyIncomeRequest.h"
#import "IncomeModel.h"
#import "MyIncomeCell.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface MyEarningsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
//页码
@property (nonatomic,strong)NSString *page;
@end

@implementation MyEarningsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"我的收益";
    self.page = @"1";
    [self.view addSubview:self.tableView];
    [self reloadData:RefreshNoneType];
}

-(void)reloadData:(RefreshType )type{
    if (type == RefreshFootType) {
        self.page = [NSString stringWithFormat:@"%ld", [self.page integerValue] + 1 ];
    }else{
        self.page = @"1";
    }
    if (type == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    __weak typeof(self) weakSelf = self;
    MyIncomeRequest *mineralsReq = [MyIncomeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
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
                [weakSelf.dataArray removeAllObjects];
            }
            if ([weakSelf.page integerValue]>=[responseDict[@"total"] integerValue]) {
                weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else
                [weakSelf endRefresh];
            for (NSDictionary *d in responseDict[@"vm_income"]) {
                IncomeModel *m = [[IncomeModel alloc]initWithDictionary:d error:nil];
                [arr addObject:m];
            }
            [weakSelf.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
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
    mineralsReq.page = self.page;
    [mineralsReq startRequest];
}

#pragma mark -- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIncomeCell"];
    if (!cell) {
        cell = [[MyIncomeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MyIncomeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    IncomeModel *model = self.dataArray[indexPath.row];
    [cell reloadCellModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyIncomeCell getCellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIView countBeforeWithIphone5Length:35];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 35)];
    back.backgroundColor = KBackgroundColor;
    
    UILabel *oneL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 10, (320.0f-20)/4, 15)];
    oneL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    oneL.font = [UIFont boldSystemFontOfSize:15];
    oneL.text = @"下线";
    oneL.textAlignment = NSTextAlignmentCenter;
    [back addSubview:oneL];
    
    UILabel *twoL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(oneL.adaptiveIphone5Frame.size.width+10, 10, (320.0f-20)/4, 15)];
    twoL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    twoL.font = [UIFont boldSystemFontOfSize:15];
    twoL.text = @"数量";
    twoL.textAlignment = NSTextAlignmentCenter;
    [back addSubview:twoL];
    
    UILabel *threeL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(twoL.adaptiveIphone5Frame.size.width+twoL.adaptiveIphone5Frame.origin.x, 10, (320.0f-20)/4, 15)];
    threeL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    threeL.font = [UIFont boldSystemFontOfSize:15];
    threeL.text = @"单位";
    threeL.textAlignment = NSTextAlignmentCenter;
    [back addSubview:threeL];
    
    UILabel *fourL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(threeL.adaptiveIphone5Frame.size.width+threeL.adaptiveIphone5Frame.origin.x, 10, (320.0f-20)/4, 15)];
    fourL.textColor = [UIColor gc_colorWithHexString:@"#666666"];
    fourL.font = [UIFont boldSystemFontOfSize:15];
    fourL.text = @"层次";
    fourL.textAlignment = NSTextAlignmentCenter;
    [back addSubview:fourL];
    return back;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 64;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        __weak typeof (self) weakSelf = self;
        //下拉上拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf reloadData:RefreshHeadType];
        }];
        //下拉上拉刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf reloadData:RefreshFootType];
        }];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
