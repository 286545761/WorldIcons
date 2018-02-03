//
//  BindWechatViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/9.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BindWechatViewController.h"
#import "entrustTableViewCell.h"
#import "BuySellRequest.h"
#import "PriceModel.h"
#import "PriceDetailView.h"
#import "RevokeRequest.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshHeadType = 1,  // 下拉
    RefreshFootType = 2,  // 上拉
    RefreshNoneType = 3   // 第一次加载
};
@interface BindWechatViewController ()<UITableViewDataSource,UITableViewDelegate,PriceDetailViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *entrustArray;
@property (nonatomic,strong)PriceDetailView *priceDetailView;
//页码
@property (nonatomic,strong)NSString *page;
@end

@implementation BindWechatViewController

- (void)viewDidLoad {
    self.page = @"1";
    [super viewDidLoad];
    self.entrustArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self initView];
    [self loadEntrustData:RefreshNoneType];
}

-(void)loadEntrustData:(RefreshType )type{
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
            NSArray *array = responseDict[@"BuySell"];
            if (array.count && type == RefreshFootType) {
                weakSelf.page = [@([weakSelf.page integerValue] + 1) stringValue];
            }else if(type == RefreshHeadType || type == RefreshNoneType) {
                weakSelf.page = @"1";
                [weakSelf.entrustArray removeAllObjects];
            }
            if ([weakSelf.page integerValue]>=[responseDict[@"total"] integerValue]) {
                weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            }else
                [weakSelf endRefresh];
            for (NSDictionary *d in responseDict[@"BuySell"]) {
                BuySellModel *m = [[BuySellModel alloc]initWithDictionary:d error:nil];
                [arr addObject:m];
            }
            [weakSelf.entrustArray addObjectsFromArray:arr ];
            [self.tableView reloadData];
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
    buySellReq.type = @"1";
    buySellReq.page = self.page;
    [buySellReq startRequest];
}

-(void)initView{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 30)];
    back.backgroundColor = [UIColor clearColor];
    
    UILabel *l1 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10, 0, (320-20)/4, 30)];
    l1.text = @"委托时间";
    l1.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    l1.textAlignment = NSTextAlignmentCenter;
    l1.font = [UIFont boldSystemFontOfSize:15];
    [back addSubview:l1];
    
    UILabel *l2 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(l1.adaptiveIphone5Frame.origin.x+l1.adaptiveIphone5Frame.size.width, 0, (320-20)/4, 30)];
    l2.text = @"数量/价格";
    l2.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    l2.textAlignment = NSTextAlignmentCenter;
    l2.font = [UIFont boldSystemFontOfSize:15];
    [back addSubview:l2];
    
    UILabel *l3 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(l2.adaptiveIphone5Frame.origin.x+l2.adaptiveIphone5Frame.size.width, 0, (320-20)/4, 30)];
    l3.text = @"委托类型";
    l3.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    l3.textAlignment = NSTextAlignmentCenter;
    l3.font = [UIFont boldSystemFontOfSize:15];
    [back addSubview:l3];
    
    UILabel *l4 = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(l3.adaptiveIphone5Frame.origin.x+l3.adaptiveIphone5Frame.size.width, 0, (320-20)/4, 30)];
    l4.text = @"状态";
    l4.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    l4.textAlignment = NSTextAlignmentCenter;
    l4.font = [UIFont boldSystemFontOfSize:15];
    [back addSubview:l4];
    
    self.tableView.tableHeaderView = back;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.entrustArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"entrustTableViewCell";
    entrustTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[entrustTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell reloadCellModel:self.entrustArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIView countBeforeWithIphone5Length:60];
}

-(CGFloat)tableView:(UITableView *)tableViewg heightForFooterInSection:(NSInteger)section{
    return [UIView countBeforeWithIphone5Length:10];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BuySellModel *model = self.entrustArray[indexPath.row];
    UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
    self.priceDetailView = [[PriceDetailView alloc]initWithBuyModel:model];
    self.priceDetailView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.priceDetailView.index = indexPath;
    self.priceDetailView.delegate = self;
    [Windown addSubview:self.priceDetailView];
}

- (void)bottomPassBtnOnClick{
    [self.priceDetailView removeFromSuperview];
}

- (void)revokeBtnOnClick:(NSIndexPath *)index{
    [self.priceDetailView removeFromSuperview];
    BuySellModel *model = self.entrustArray[index.row];
    [MBProgressHUD gc_showActivityMessageInWindow:@"撤销中..."];
    RevokeRequest *buySellReq = [RevokeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [MBProgressHUD gc_hiddenHUD];
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }else if ([model.code isEqualToString:@"10"]) {
    
//            self.entrustArray = [NSArray arrayWithArray:arr];
            [self.tableView reloadData];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    buySellReq.ub_id = [UserManager getUID];
    buySellReq.vsb_id = model.vb_id;
    if ([model.type isEqualToString:@"1"]) {
        buySellReq.type = @"1";
    }
    if ([model.type isEqualToString:@"2"]) {
        buySellReq.type = @"2";
    }
    [buySellReq startRequest];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 64;
        rect.size.height -= 74;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.separatorInset = UIEdgeInsetsMake(0,[UIView countBeforeWithIphone5Length:10], 0, [UIView countBeforeWithIphone5Length:10]);
        _tableView.separatorColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        __weak typeof (self) weakSelf = self;
        //下拉上拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadEntrustData:RefreshHeadType];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadEntrustData:RefreshFootType];
        }];
    }
    return _tableView;
}

#pragma mark    ----    MJRefresh   -----
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


@end
