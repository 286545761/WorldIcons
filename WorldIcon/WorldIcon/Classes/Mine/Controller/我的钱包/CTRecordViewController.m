//
//  CTRecordViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CTRecordViewController.h"
#import "CTRecordHeaderView.h"
#import "CTRecordCell.h"
#import "ListTreAppRequest.h"
#import "GXCTModel.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface CTRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *CTOrderTb;

@property (nonatomic,strong)NSMutableArray *dataArray;

//页码
@property (nonatomic,strong)NSString *page;
@end

@implementation CTRecordViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"充提记录";
    [self setUpCTOrderTb];
    self.page = @"1";
    if (self.type) {
        [self loadListreappWithType:self.type withRefreshType:RefreshNoneType];//共享者
    }else{
        [self loadListreappWithType:@"2" withRefreshType:RefreshNoneType];//用户
    }
}

-(void)setUpCTOrderTb{
    
    self.CTOrderTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.CTOrderTb.showsVerticalScrollIndicator = NO;
    self.CTOrderTb.backgroundColor = [UIColor clearColor];
    self.CTOrderTb.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.CTOrderTb.rowHeight = 60;
    [self.view addSubview:self.CTOrderTb];
    
    self.CTOrderTb.delegate = self;
    self.CTOrderTb.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CTRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordCell"];
    
    if (!cell) {
        cell = [[CTRecordCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"recordCell"];
    }
    cell.model = self.dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CTRecordHeaderView *headerView = [[CTRecordHeaderView alloc]init];
    headerView.backgroundColor = KBackgroundColor;
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    return headerView;
}


-(void)loadListreappWithType:(NSString *)type
             withRefreshType:(RefreshType)RefreshType{
    if (RefreshType == RefreshFootType) {
        self.page = [NSString stringWithFormat:@"%ld", [self.page integerValue] + 1 ];
    }else{
        self.page = @"1";
    }
    if (RefreshType == RefreshNoneType) {
        [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    }
    __weak typeof(self) weakSelf = self;
    ListTreAppRequest *getappReq = [ListTreAppRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [weakSelf endRefresh];
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            NSMutableArray *arr = [NSMutableArray array];
            NSArray *array = responseDict[@"vm_gongx"];
            if (array.count && RefreshType == RefreshFootType) {
                weakSelf.page = [@([weakSelf.page integerValue] + 1) stringValue];
            }else if(RefreshType == RefreshHeadType || RefreshType == RefreshNoneType) {
                weakSelf.page = @"1";
                [weakSelf.dataArray removeAllObjects];
            }
            if ([weakSelf.page integerValue]>=[responseDict[@"total"] integerValue]) {
                weakSelf.CTOrderTb.mj_footer.state = MJRefreshStateNoMoreData;
            }else
                [weakSelf endRefresh];
            
            for (NSDictionary *d in responseDict[@"vm_gongx"]) {
                GXCTModel *m = [[GXCTModel alloc]initWithDictionary:d error:nil];
                [arr addObject:m];
            }
            [weakSelf.dataArray addObjectsFromArray:arr];
            [weakSelf.CTOrderTb reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [self endRefresh];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.type = type;//1 vm_gongx
    getappReq.page = self.page;
    
    [getappReq startRequest];
    
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.CTOrderTb.mj_header endRefreshing];
    [self.CTOrderTb.mj_footer endRefreshing];
}
@end
