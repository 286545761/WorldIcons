//
//  EntrustViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "EntrustViewController.h"
#import "EntrustHeaderView.h"
#import "EntrustCell.h"
#import "BuySellRequest.h"
#import "PriceModel.h"

@interface EntrustViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *EntrustTb;

@property (nonatomic,strong)NSMutableArray *entrustArray;
@end

@implementation EntrustViewController
-(NSMutableArray *)entrustArray{
    if (!_entrustArray) {
        _entrustArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _entrustArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLabel.text = @"当前委托";
    
    [self setUpEntrustTb];

    [self setUpRightBarButton];

    [self loadEntrustData];
    
}
#pragma mark -- 右侧退出登录
-(void)setUpRightBarButton{
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:(UIBarButtonItemStyleDone) target:self action:@selector(updateAction)];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn;
    
}

-(void)setUpEntrustTb{
    
    self.EntrustTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.EntrustTb.showsVerticalScrollIndicator = NO;
    self.EntrustTb.backgroundColor = [UIColor clearColor];
    self.EntrustTb.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.EntrustTb.rowHeight = 60;
    [self.view addSubview:self.EntrustTb];
    
    self.EntrustTb.delegate = self;
    self.EntrustTb.dataSource = self;
    
}
#pragma mark -- tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.entrustArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EntrustCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entrustCell"];
    
    if (!cell) {
        cell = [[EntrustCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"entrustCell"];
    }
    cell.model = self.entrustArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    EntrustHeaderView *headerView = [[EntrustHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    
    return headerView;
}
#pragma mark -- 刷新数据
-(void)updateAction{

    [self loadEntrustData];
}
-(void)loadEntrustData{
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];

    BuySellRequest *buySellReq = [BuySellRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            for (NSDictionary *d in responseDict[@"BuySell"]) {
                
                BuySellModel *m = [[BuySellModel alloc]initWithDictionary:d error:nil];
                
                [self.entrustArray addObject:m];
            }
            
            [self.EntrustTb reloadData];
            
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

    buySellReq.type = @"1";

    buySellReq.page = @"";
    
    [buySellReq startRequest];

}
@end
