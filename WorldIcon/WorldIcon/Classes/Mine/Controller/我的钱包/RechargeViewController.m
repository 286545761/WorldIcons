//
//  RechargeViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/20.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeCell.h"
#import "InputView.h"
#import "CardModel.h"
#import "AdmincardRequest.h"
#import "RechargeRequest.h"
@interface RechargeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *rechargeTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)InputView *czjeLabel;
@property (nonatomic,strong)InputView *czyhkhLabel;
@property (nonatomic,strong)InputView *chsjLabel;

@end

@implementation RechargeViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"美元充值";
    
   }
//没有订单
-(void)type1{

    InputView *czyhkhLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 40, kScreenWidth-60, 40) withTitle:@"充值金额" withPlaceholder:@"请输入充值金额"];
    [self.view addSubview:czyhkhLabel];
    self.czyhkhLabel = czyhkhLabel;
    
    //提交充值按钮
    UIButton *submitApplyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交充值" withRadius:(35.5*0.5)];
    submitApplyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitApplyBtn addTarget:self action:@selector(submitApplyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitApplyBtn];
    
    [submitApplyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(30));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(30));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(czyhkhLabel.mas_bottom).offset(20);
    }];

    
}
//正在做订单
-(void)type2{

    [self loadAdminCardOnNet];
    
    [self setUprechargeTableView];
}

-(void)setUprechargeTableView{
    
    self.rechargeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.rechargeTableView.showsVerticalScrollIndicator = NO;
    self.rechargeTableView.backgroundColor = [UIColor clearColor];
    self.rechargeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rechargeTableView.rowHeight = 100;
    [self.view addSubview:self.rechargeTableView];
    
    self.rechargeTableView.delegate = self;
    self.rechargeTableView.dataSource = self;
    
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rechargeCell"];
    if (!cell) {
        cell = [[RechargeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"rechargeCell"];
    }
    cell.model = self.dataArray[indexPath.row];
    cell.block = ^(NSString *str){
    
        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        pboard.string = str;
        
        [MBProgressHUD gc_showSuccessMessage:@"已复制"];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 250;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    line.backgroundColor = [UIColor clearColor];
    [footer addSubview:line];
    
    UIView *content1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 167)];
    content1.backgroundColor = [UIColor whiteColor];
    [footer addSubview:content1];
    
    //充值金额
    InputView *czjeLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 20, kScreenWidth-60, 35) withTitle:@"充值金额" withPlaceholder:@"请输入充值金额"];
    [content1 addSubview:czjeLabel];
    self.czjeLabel = czjeLabel;
    
    //充值银行卡号
    InputView *czyhkhLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 66, kScreenWidth-60, 35) withTitle:@"银行卡号" withPlaceholder:@"点击上边银行卡号，实现复制"];
    [content1 addSubview:czyhkhLabel];
    self.czyhkhLabel = czyhkhLabel;
    //充值时间
    InputView *chsjLabel = [[InputView alloc]initWithFrame:CGRectMake(30, 108, kScreenWidth-60, 35) withTitle:@"充值时间" withPlaceholder:@"请输入选择充值时间"];
    [content1 addSubview:chsjLabel];
    self.chsjLabel = chsjLabel;
    
    UIView *content2 = [[UIView alloc]initWithFrame:CGRectMake(0, 177, kScreenWidth, 83)];
    content2.backgroundColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
    [footer addSubview:content2];
    
    //提交申请按钮
    UIButton *submitApplyBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交申请" withRadius:(35.5*0.5)];
    submitApplyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitApplyBtn addTarget:self action:@selector(submitApplyAction) forControlEvents:UIControlEventTouchUpInside];
    [content2 addSubview:submitApplyBtn];
    
    [submitApplyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(footer).offset(kRatioX6(50));
        make.right.mas_equalTo(footer).offset(-kRatioX6(50));
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(content2.mas_bottom).offset(0);
    }];
    
    return footer;

}
-(void)loadAdminCardOnNet{

    AdmincardRequest *adminReq = [AdmincardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            for (NSDictionary *item in responseDict[@"user_card"]) {
                
                CardModel *m = [[CardModel alloc]initWithDictionary:item error:nil];
                [self.dataArray addObject:m];
            }
            
            [self.rechargeTableView reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }

    } failureBlock:^(NSError *error) {
        
    }];
    
    adminReq.ub_id = [UserManager getUID];
    
    [adminReq startRequest];
    
}
#pragma mark -- 提交申请
-(void)submitApplyAction{

    RechargeRequest *rechargeReq = [RechargeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    rechargeReq.ub_id = [UserManager getUID];
    rechargeReq.uc_cz_date = self.chsjLabel.field.text;
    rechargeReq.uc_khh = @"";
    rechargeReq.uc_card = self.czyhkhLabel.field.text;
    rechargeReq.uc_mount = self.czjeLabel.field.text;
    rechargeReq.uc_name = @"";
    
    [rechargeReq startRequest];
}
@end
