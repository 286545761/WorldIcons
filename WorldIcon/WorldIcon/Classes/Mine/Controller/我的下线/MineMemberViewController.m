//
//  MineMemberViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineMemberViewController.h"
#import "MemberHeaderView.h"
#import "MemberCell.h"
@interface MineMemberViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *memberTableView;

@end

@implementation MineMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"我的下线";
    
    [self setUpmemberTableView];
    
    [self setUpHeaderView];
    
}
-(void)setUpmemberTableView{
    
    self.memberTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.memberTableView.showsVerticalScrollIndicator = NO;
    self.memberTableView.backgroundColor = [UIColor clearColor];
    self.memberTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.memberTableView.rowHeight = 45;
    [self.view addSubview:self.memberTableView];
    
    self.memberTableView.delegate = self;
    self.memberTableView.dataSource = self;
    
}
-(void)setUpHeaderView{
    
    MemberHeaderView *headerView = [[MemberHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    
    self.memberTableView.tableHeaderView = headerView;
    
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell"];
    if (!cell) {
        cell = [[MemberCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"memberCell"];
    }

    if (indexPath.section == 0 && indexPath.row == 4) {
        cell.line.hidden = YES;
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
@end
