//
//  MessageViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/20.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageRequest.h"
#import "MessageModel.h"

#import "CTRecordViewController.h"//用户充提记录
#import "GXCTViewController.h"//接单大厅
#import "CurrentProgressAViewController.h"//共享者节点
#import "CurrentProgressViewController.h"//用户节点
#import "WIMineViewController.h"
#import "newCurrentProgressAViewController.h"// 共享者当前进度

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *messageTableView;
@property (nonatomic,assign)NSInteger   page;
@property (nonatomic,strong)MJRefreshAutoNormalFooter *footer;
@property (nonatomic,strong)NSMutableArray      *dataArray;

@end

@implementation MessageViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _page = 1;

    self.navLabel.text = @"消息中心";
    
    [self setUpLeftBarButton];
    
    [self setUpmessageTableView];
    
    [self laodMessageOnNetWithPage:_page];
    
    [self addRefresh];

}

-(void)addRefresh{
    
    @weakify(self);
    //默认block方法：设置下拉刷新
    self.messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        
        _page = 1;
        [self laodMessageOnNetWithPage:_page];
        
    }];
    
    //默认block方法：设置上拉加载更多
    self.messageTableView.mj_footer = _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        _page++;
        
        [self laodMessageOnNetWithPage:_page];
    }];
}
#pragma mark -- 停止刷新
-(void)endRefresh{
    
    if (_page == 1) {
        
        [self.messageTableView.mj_header endRefreshing];
    }
    [_footer endRefreshing];
    
}



#pragma mark -- 主视图
-(void)setUpmessageTableView{
    
    self.messageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.messageTableView.showsVerticalScrollIndicator = NO;
    self.messageTableView.backgroundColor = [UIColor clearColor];
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTableView.rowHeight = 85;
    [self.view addSubview:self.messageTableView];
    
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    
}
#pragma mark -- 左侧返回事件
-(void)setUpLeftBarButton{
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"后退箭头"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    
    if (!cell) {
        cell = [[MessageCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"messageCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageModel *model = self.dataArray[indexPath.row];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (model) {
        
        [userInfo setValue:[NSString stringWithFormat:@"%@",model.info] forKey:@"info"];
        [userInfo setValue:[NSString stringWithFormat:@"%@",model.type] forKey:@"type"];
        
    }else{
       userInfo = (NSMutableDictionary *)self.dic;
    }
   

    //0 接单大厅  1 共享者  2 充值  3提现  当前进度
    if ([userInfo[@"type"] integerValue]==0) {
        //跳到共享充提接单大厅

                    GXCTViewController *ctRecordVC = [[GXCTViewController alloc]init];
        [ctRecordVC test3];

                    ctRecordVC.selectIndex = 1;
    
                    [self.navigationController pushViewController:ctRecordVC animated:YES];
        
    }else if ([userInfo[@"type"] integerValue]==1){
        //1 共享者充提记录  2 用户充提记录  else    //跳到共享者当前进度
        
        if ([userInfo[@"info"] integerValue]==1) {
            GXCTViewController *ctRecordVC = [[GXCTViewController alloc]init];
            [ctRecordVC test3];
            
            ctRecordVC.selectIndex = 3;
 
            [self.navigationController pushViewController:ctRecordVC animated:YES];
            
            
        }else if ([userInfo[@"info"] integerValue]==2){
            CTRecordViewController *ctRecordVC = [[CTRecordViewController alloc]init];
            ctRecordVC.type = @"1";
            
            [self.navigationController pushViewController:ctRecordVC animated:YES];

            
            
        }else{
            newCurrentProgressAViewController *newCurrentProgressAVC=[[newCurrentProgressAViewController alloc]init];
            ReApp*rmodel =[[ReApp alloc]init];

            rmodel.vra_id=model.vra_id;
            newCurrentProgressAVC.newmodel=rmodel;
            [self.navigationController pushViewController:newCurrentProgressAVC animated:YES];
            


        }




    }else if ([userInfo[@"type"] integerValue]==2){
        //1 共享者充提记录  2 用户充提记录     //跳到申请者充值当前进度

        if ([userInfo[@"info"] integerValue]==1) {
            GXCTViewController *ctRecordVC = [[GXCTViewController alloc]init];
            [ctRecordVC test3];
            
            ctRecordVC.selectIndex = 3;
            
            [self.navigationController pushViewController:ctRecordVC animated:YES];
            
        }else if ([userInfo[@"info"] integerValue]==2){
            CTRecordViewController *ctRecordVC = [[CTRecordViewController alloc]init];
            ctRecordVC.type = @"1";
            
            [self.navigationController pushViewController:ctRecordVC animated:YES];
            
            
            
        }else{
            newCurrentProgressAViewController *newCurrentProgressAVC=[[newCurrentProgressAViewController alloc]init];
            ReApp*rmodel =[[ReApp alloc]init];
            
            rmodel.vra_id=model.vra_id;
            newCurrentProgressAVC.newmodel=rmodel;
            [self.navigationController pushViewController:newCurrentProgressAVC animated:YES];
            
            
        }

    }else if ([userInfo[@"type"] integerValue]==3){
        //1 共享者充提记录  2 用户充提记录      //跳到申请者提现当前进度

        if ([userInfo[@"info"] integerValue]==1) {
            GXCTViewController *ctRecordVC = [[GXCTViewController alloc]init];
            [ctRecordVC test3];
            
            ctRecordVC.selectIndex = 3;
            
            [self.navigationController pushViewController:ctRecordVC animated:YES];
            
        }else if ([userInfo[@"info"] integerValue]==2){
            CTRecordViewController *ctRecordVC = [[CTRecordViewController alloc]init];
            ctRecordVC.type = @"1";
            
            [self.navigationController pushViewController:ctRecordVC animated:YES];
            
            
            
        }else{
            newCurrentProgressAViewController *newCurrentProgressAVC=[[newCurrentProgressAViewController alloc]init];
            ReApp*rmodel =[[ReApp alloc]init];
            
            rmodel.vra_id=model.vra_id;
            newCurrentProgressAVC.newmodel=rmodel;
            [self.navigationController pushViewController:newCurrentProgressAVC animated:YES];
            
            
        }

    }
    
    
// //   if ([userInfo[@"info"] integerValue] == 0) {
// //       //跳转控制器
////        if ([userInfo[@"type"] integerValue] == 1) {//跳向接单大厅
////            GXCTViewController *ctRecordVC = [[GXCTViewController alloc]init];
////            ctRecordVC.selectIndex = 1;
////            [self.navigationController pushViewController:ctRecordVC animated:YES];
//        }
//        if ([userInfo[@"type"] integerValue] == 2) {//跳向充值节点
//            CurrentProgressViewController *ctRecordVC = [[CurrentProgressViewController alloc]init];
//            ctRecordVC.vra_id = userInfo[@"vra_id"];
//            ctRecordVC.status = @"2";
//            [self.navigationController pushViewController:ctRecordVC animated:YES];
//        }
//        if ([userInfo[@"type"] integerValue] == 3) {//跳向提现节点
//            CurrentProgressViewController *ctRecordVC = [[CurrentProgressViewController alloc]init];
//            ctRecordVC.vra_id = userInfo[@"vra_id"];
//            ctRecordVC.status = @"3";
//            [self.navigationController pushViewController:ctRecordVC animated:YES];
//        }
//    }
//    if ([userInfo[@"info"] integerValue] == 1) {//共享者充提记录
//        GXCTViewController *ctRecordVC = [[GXCTViewController alloc]init];
//        ctRecordVC.selectIndex = 3;
//
//        [self.navigationController pushViewController:ctRecordVC animated:YES];
//    }
//    if ([userInfo[@"info"] integerValue] == 2) {//用户充提记录
////
////        CTRecordViewController *ctRecordVC = [[CTRecordViewController alloc]init];
////        ctRecordVC.type = @"1";
////
////        [self.navigationController pushViewController:ctRecordVC animated:YES];
////    }

}
#pragma mark -- 加载消息列表
-(void)laodMessageOnNetWithPage:(NSInteger)page{

    MessageRequest *messageReq = [MessageRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        [self.messageTableView.mj_header endRefreshing];
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if ([responseDict[@"total"] integerValue] == 0) {
                
                [self.dataArray removeAllObjects];
                [self.messageTableView reloadData];
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
            
            for (NSDictionary *item in responseDict[@"message"]) {
                MessageModel *m = [[MessageModel alloc]initWithDictionary:item error:nil];
                [self.dataArray addObject:m];
            }
            
            [self.messageTableView reloadData];
            [self.messageTableView.mj_header endRefreshing];
            [_footer endRefreshing];
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [self.messageTableView.mj_header endRefreshing];
    }];
    
    messageReq.ub_id = [UserManager getUID];
    messageReq.page = page;
    [messageReq startRequest];
}
@end
