//
//  MineBankCardViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineBankCardViewController.h"
#import "BankCardCell.h"
#import "BankCardAddViewController.h"
#import "GetCardRequest.h"
#import "CardModel.h"
#import "XLAlertView.h"
#import "DeleteRequest.h"
#import "UserAddCardViewController.h"

@interface MineBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *cardsArray;

@property (nonatomic,strong)UITableView    *cardTableView;

@end

@implementation MineBankCardViewController
- (NSMutableArray *)cardsArray{
    if (!_cardsArray) {
        _cardsArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _cardsArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadCardListOnNet];

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navLabel.text = @"账户列表";
    
    [self setUpMainUI];
    
}
-(void)setUpMainUI{
    
    self.cardTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    self.cardTableView.rowHeight=102;
    self.cardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cardTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.cardTableView];

    self.cardTableView.delegate = self;
    self.cardTableView.dataSource = self;
    
}
#pragma mark -- tableView 的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cardsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bankcardCell"];
    
    if (!cell) {
        cell = [[BankCardCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"bankcardCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.cardsArray[indexPath.row];
    
    //长按手势
    //添加长按手势
    UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    
    longPressGesture.minimumPressDuration=1.5f;//设置长按 时间
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    
    UIButton *addBtn = [UIButton new];
    addBtn.frame = CGRectMake(10, 0, 100, 57);
    [addBtn setImage:[UIImage imageNamed:@"添加银行卡加号"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addBtn setTitle:@"添加账户" forState:(UIControlStateNormal)];
    [addBtn setTitleColor:[UIColor gc_colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addBankCardAction) forControlEvents:UIControlEventTouchUpInside];
    [addBtn gc_layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyleLeft) imageTitleSpace:5];
    [view addSubview:addBtn];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(10, 56, kScreenWidth-20, 0.5);
    line.backgroundColor = [UIColor gc_colorWithHexString:@"#dbdbdb" alpha:1];
    [view addSubview:line];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 57;
}
#pragma mark -- 添加银行卡
-(void)addBankCardAction{
    UserAddCardViewController *bankCardAddVC = [[UserAddCardViewController alloc]init];
    bankCardAddVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bankCardAddVC animated:YES];
//    bankCardAddVC.hidesBottomBarWhenPushed = NO;

}
-(void)loadCardListOnNet{

    GetCardRequest *getCardReq = [GetCardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.cardsArray.count) {
                [self.cardsArray removeAllObjects];
            }
            
            for (NSDictionary *item in responseDict[@"user_card"]) {
                
                CardModel *m = [[CardModel alloc]initWithDictionary:item error:nil];
                
                [self.cardsArray addObject:m];
            }
            [self.cardTableView reloadData];
            
            [self.cardTableView.mj_header endRefreshing];

        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getCardReq.ub_id = [UserManager getUID];
    
    [getCardReq startRequest];
}
#pragma mark -- 长按删除银行卡
-(void)cellLongPress:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [sender locationInView:self.cardTableView];
        
        NSIndexPath *indexPath = [self.cardTableView indexPathForRowAtPoint:point]; // 可以获取我们在哪个cell上长按
        
        XLAlertView *xlAlertView = [[XLAlertView alloc] initWithMessage:@"解除绑定此张银行卡" sureBtn:@"确认" cancleBtn:@"取消"];
        xlAlertView.resultIndex = ^(NSInteger index){
            //回调---处理一系列动作
            if (index == 1) {//取消
                
            }
            if (index == 2) {//确定
                
                [self deleteBankCardActionWithIndexPath:indexPath];
                
            }
        };
        
        [xlAlertView showXLAlertView];
        
    }else{
    
    }
}
#pragma mark -- 删除银行卡
-(void)deleteBankCardActionWithIndexPath:(NSIndexPath*)indepth{
    
    CardModel *m = self.cardsArray[indepth.row];
    
    DeleteRequest *bundReq = [DeleteRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
        
            /** 1. 更新数据源(数组): 根据indexPaht.row作为数组下标, 从数组中删除数据. */
            [self.cardsArray removeObjectAtIndex:indepth.row];
            /** 2. TableView中 删除一个cell. */
            [self.cardTableView deleteRowsAtIndexPaths:@[indepth] withRowAnimation:UITableViewRowAnimationRight];
            
            [self.cardTableView reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    bundReq.ub_id = [UserManager getUID];
    bundReq.uc_khh = m.uc_khh;
    bundReq.uc_card = m.uc_card;
    bundReq.uc_addr = m.uc_addr;
    bundReq.uc_name = m.uc_name;
    bundReq.action = @"2";
    bundReq.uc_id = m.uc_id;
    
    [bundReq startRequest];

}

@end
