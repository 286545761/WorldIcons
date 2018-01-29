//
//  MerchantSearchViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MerchantSearchViewController.h"
#import "MerchantAllCell.h"
#import "AgentListRequest.h"
#import "MerchantDetailViewController.h"

@interface MerchantSearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITextField *textField;
@property (nonatomic,strong)UITableView *resultTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MerchantSearchViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpResultTableView];
    
    [self setUpSearchField];
    
}
-(void)setUpResultTableView{

    self.resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.resultTableView.showsVerticalScrollIndicator = NO;
    self.resultTableView.backgroundColor = [UIColor clearColor];
    self.resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.resultTableView.rowHeight = 85;
    [self.view addSubview:self.resultTableView];
    
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
    
}

-(void)setUpSearchField{

    //输入框
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 60, 30)];
    _textField.accessibilityIdentifier = @"contact_name";
    _textField.layer.borderColor = [[UIColor gc_colorWithHexString:@"#dbdbdb"] CGColor];
    _textField.layer.borderWidth = 0.5;
    _textField.layer.cornerRadius = 15;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = [UIFont systemFontOfSize:15.0];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"请输入商家名称搜索";
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.delegate = self;
    
    self.navigationItem.titleView = _textField;

}
#pragma mark UITableViewDatasource
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MerchantDetailViewController *detailVC = [[MerchantDetailViewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.hidesBottomBarWhenPushed = NO;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];

    //发起请求 搜索
    AgentListRequest *agentListReq = [AgentListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            for (NSDictionary *item in responseDict[@"agentlist"]) {
                
                AgentModel *m = [[AgentModel alloc]initWithDictionary:item error:nil];
                [self.dataArray addObject:m];
            }
            [self.resultTableView reloadData];

        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    
    agentListReq.ub_id = [UserManager getUID];
    agentListReq.page = 1;
    agentListReq.vm_type = @"";
    agentListReq.vm_province = @"";
    agentListReq.vm_city = @"";
    agentListReq.vm_agent_name = textField.text;
    
    [agentListReq startRequest];

    return YES;
    
}
@end
