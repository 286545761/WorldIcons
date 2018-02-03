//
//  WIMerchantViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIMerchantViewController.h"
#import "MerchantSectionHeaderView.h"
#import "MerchantAllCell.h"
#import "MerchantDetailViewController.h"
#import "ApplicationJoinViewController.h"
#import "MerchantSearchViewController.h"

#import "AgentListRequest.h"
#import "AgentModel.h"

#import "OSAddressPickerView.h"
#import "TypePickerView.h"
#import "AgentTypeRequest.h"

@interface WIMerchantViewController ()<UITableViewDelegate,UITableViewDataSource,MerchantSectionHeaderViewDelegate>

@property (nonatomic,strong)OSAddressPickerView *addressPickerView;
@property (nonatomic,strong)UITableView         *merchantTableView;
@property (nonatomic,strong)NSMutableArray      *dataArray;
@property (nonatomic,strong)MJRefreshAutoNormalFooter *footer;
@property (nonatomic,strong)MerchantSectionHeaderView *headerView;
@property (nonatomic,strong)NSArray *typeArray;
@property (nonatomic,assign)NSInteger   page;
@property (nonatomic,copy)NSString   *type;
@property (nonatomic,copy)NSString   *province;
@property (nonatomic,copy)NSString   *city;


@end

@implementation WIMerchantViewController

-(NSArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSArray array];
    }
    return _typeArray;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];

    _page = 1;
    
    self.navLabel.text = @"商家";

    [self setUpRightBarButton];
    
    [self setUpLeftBarButton];
    
    [self setUpmerchantTableView];
    
    [self loadAgentListWithPage:1 withType:_type withProvince:_province withCity:_city withAgentName:@""];

    [self loadTypes];

    [self addRefresh];
    
}
-(void)addRefresh{
    
    @weakify(self);
    //默认block方法：设置下拉刷新
    self.merchantTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        @strongify(self);

        _page = 1;
       [self loadAgentListWithPage:self.page withType:self.type withProvince:self.province withCity:self.city withAgentName:@""];
        
    }];
    
    //默认block方法：设置上拉加载更多
    self.merchantTableView.mj_footer = _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);

        _page++;
        
        [self loadAgentListWithPage:self.page withType:self.type withProvince:self.province withCity:self.city withAgentName:@""];
    }];
}
#pragma mark -- 停止刷新
-(void)endRefresh{
    
    if (_page == 1) {
        
        [self.merchantTableView.mj_header endRefreshing];
    }
    [_footer endRefreshing];
    
}

#pragma mark -- 右侧申请入驻
-(void)setUpRightBarButton{
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"申请入驻" style:(UIBarButtonItemStyleDone) target:self action:@selector(applicationJoinAction)];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn;
    
}
#pragma mark -- 左侧搜索
-(void)setUpLeftBarButton{
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索框"] style:(UIBarButtonItemStyleDone) target:self action:@selector(searchAction)];
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;
    
}

-(void)setUpmerchantTableView{
    
    self.merchantTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.merchantTableView.showsVerticalScrollIndicator = NO;
    self.merchantTableView.backgroundColor = [UIColor clearColor];
    self.merchantTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.merchantTableView.rowHeight = 85;
    [self.view addSubview:self.merchantTableView];
    
    self.merchantTableView.delegate = self;
    self.merchantTableView.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MerchantAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"merchantAllCell"];
    
    if (!cell) {
        cell = [[MerchantAllCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"merchantAllCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[MerchantSectionHeaderView alloc]init];
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    self.headerView.delegate = self;
    return self.headerView;
}
#pragma mark -- MerchantSectionHeaderViewDelegate
-(void)sectionHeaderView:(MerchantSectionHeaderView *)view didSelected:(NSString *)tool{

    if ([tool isEqualToString:@"选择分类"]) {
        
        TypePickerView *typeView = [TypePickerView shareInstance];
        [typeView showBottomView];
        typeView.types = _typeArray;
        
        [kAppWindow addSubview:typeView];
        
        @weakify(self);
        
        typeView.block = ^(NSString *type)
        {
            @strongify(self);
            
            [self.headerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[UILabel class]]) {
                    if (obj.tag == 101) {
                        UILabel *l = (UILabel *)obj;
                        l.text = [NSString stringWithFormat:@"%@",type];
                        _type = type;
                        
                        //更新数据
                        [self loadAgentListWithPage:self.page withType:self.type withProvince:self.province withCity:self.city withAgentName:@""];
                    }
                }
            }];

            
        };
    }
    
    if ([tool isEqualToString:@"选择地点"]) {
       
        _addressPickerView = [OSAddressPickerView shareInstance];
        [_addressPickerView showBottomView];
        [kAppWindow addSubview:_addressPickerView];
        
        @weakify(self);
    
        _addressPickerView.block = ^(NSString *province,NSString *city,NSString *district)
        {
            @strongify(self);
            
            [self.headerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[UILabel class]]) {
                    if (obj.tag == 102) {
                        UILabel *l = (UILabel *)obj;
                        l.text = [NSString stringWithFormat:@"%@%@",province,city];
                        _province = province;
                        _city = city;
                        
                        //更新数据
                        [self loadAgentListWithPage:self.page withType:self.type withProvince:self.province withCity:self.city withAgentName:@""];
                    }
                }
            }];

           
        };
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MerchantDetailViewController *detailVC = [[MerchantDetailViewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.hidesBottomBarWhenPushed = NO;

}
#pragma mark -- 申请入驻
-(void)applicationJoinAction{

    ApplicationJoinViewController *joinVC = [[ApplicationJoinViewController alloc]init];
    joinVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:joinVC animated:YES];
    joinVC.hidesBottomBarWhenPushed = NO;
    
}
#pragma mark -- 搜索框
-(void)searchAction{
    
    MerchantSearchViewController *merchantSearchVC = [[MerchantSearchViewController alloc]init];
    merchantSearchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:merchantSearchVC animated:YES];
    
}

-(void)loadAgentListWithPage:(NSInteger)page withType:(NSString *)type withProvince:(NSString *)province withCity:(NSString *)city withAgentName:(NSString *)AgentName{

    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];

    AgentListRequest *agentListReq = [AgentListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if ([responseDict[@"total"] integerValue] == 0) {
                
                [self.dataArray removeAllObjects];
                [self.merchantTableView reloadData];
                return ;
                
            }
            
            if (page == 1) {
                
                [self.dataArray removeAllObjects];
            }
            
            if (page > [responseDict[@"total"] integerValue]) {
                
                [_footer setTitle:@"--我是有底线的--" forState:MJRefreshStateNoMoreData];
                [_footer endRefreshingWithNoMoreData];
                
                return ;
            }
           
            for (NSDictionary *item in responseDict[@"agentlist"]) {
                
                AgentModel *m = [[AgentModel alloc]initWithDictionary:item error:nil];
                [self.dataArray addObject:m];
                
            }
            
            [self.merchantTableView reloadData];
            
            [self.merchantTableView.mj_header endRefreshing];
            [_footer endRefreshing];
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }

    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];

    }];
    
    agentListReq.ub_id = [UserManager getUID];
    agentListReq.page = page;
    agentListReq.vm_type = type == nil ? @"" : type;
    agentListReq.vm_province = province == nil ? @"" : province;
    agentListReq.vm_city = city == nil ? @"" : city;
    agentListReq.vm_agent_name = AgentName == nil ? @"" : AgentName;
    
    [agentListReq startRequest];
    
}
-(void)loadTypes{

    AgentTypeRequest *agentTypeReq = [AgentTypeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            _typeArray = responseDict[@"type"];
           
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
        
    }];
    
    [agentTypeReq startRequest];

}
@end
