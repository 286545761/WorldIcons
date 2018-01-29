//
//  BindAliViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/9.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BindAliViewController.h"
#import "PriceTableViewCell.h"
@interface BindAliViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation BindAliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self initView];
}

-(void)initView{
    UIView *back = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 30)];
    back.backgroundColor = [UIColor clearColor];
    
    UILabel *leftL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(10+25, 0, 320/2-10-25, 30)];
    leftL.text = @"价格/美元";
    leftL.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    leftL.textAlignment = NSTextAlignmentCenter;
    leftL.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:leftL];
    
    UILabel *rightL = [[UILabel alloc]initWithAdaptiveIphone5Frame:CGRectMake(320/2, 0, 320/2-10, 30)];
    rightL.text = @"数量/oc";
    rightL.textColor = [UIColor gc_colorWithHexString:@"#999999"];
    rightL.textAlignment = NSTextAlignmentCenter;
    rightL.font = [UIFont boldSystemFontOfSize:14];
    [back addSubview:rightL];
    self.tableView.tableHeaderView = back;
    
    UIView *footerback = [[UIView alloc]initWithAdaptiveIphone5Frame:CGRectMake(0, 0, 320, 80)];
    footerback.backgroundColor = [UIColor clearColor];
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"buyBtn"] forState:UIControlStateNormal];
    [buyBtn setTitle:@"买入" forState:UIControlStateNormal];
    buyBtn.adaptiveIphone5Frame = CGRectMake(50, 0, 80, 80);
    buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchDown];
    [footerback addSubview:buyBtn];
    
    UIButton *sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sellBtn.adaptiveIphone5Frame = CGRectMake(320-50-80, 0, 80, 80);
    [sellBtn setBackgroundImage:[UIImage imageNamed:@"sellBtn"] forState:UIControlStateNormal];
    sellBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [sellBtn setTitle:@"卖出" forState:UIControlStateNormal];
    [sellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sellBtn addTarget:self action:@selector(sellBtnAction) forControlEvents:UIControlEventTouchDown];
    [footerback addSubview:sellBtn];
    
    self.tableView.tableFooterView = footerback;
}

-(void)buyBtnAction{
    
}

-(void)sellBtnAction{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"PriceTableViewCell";
    PriceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if (indexPath.row == 0) {
            cell.whiteV.adaptiveIphone5Frame = CGRectMake(10, 20, 300, 10);
        }else if (indexPath.row == 4) {
            cell.whiteV.adaptiveIphone5Frame = CGRectMake(10, 0, 300, 10);
        }else
            cell.whiteV.adaptiveIphone5Frame = CGRectMake(10, 0, 300, 30);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIView countBeforeWithIphone5Length:30];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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


-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 64;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.separatorInset = UIEdgeInsetsMake(0,[UIView countBeforeWithIphone5Length:10], 0, [UIView countBeforeWithIphone5Length:10]);
        _tableView.separatorColor = [UIColor gc_colorWithHexString:@"#f5f5f5"];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
