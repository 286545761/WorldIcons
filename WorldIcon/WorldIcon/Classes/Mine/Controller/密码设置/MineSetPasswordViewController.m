//
//  MineSetPasswordViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineSetPasswordViewController.h"
#import "WalletCell.h"

#import "PwdLoginResetViewController.h"
#import "PwdViewController.h"


@interface MineSetPasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)UITableView *setpwdTableView;
@end

@implementation MineSetPasswordViewController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"设置密码";
    [self setUpsetpwdTableView];
        
    _titleArray = @[@"登录密码修改",@"支付密码设置",@"支付密码修改",@"支付密码忘记"];
    
}
-(void)setUpsetpwdTableView{
    
    self.setpwdTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.setpwdTableView.showsVerticalScrollIndicator = NO;
    self.setpwdTableView.backgroundColor = [UIColor clearColor];
    self.setpwdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.setpwdTableView.rowHeight = 50;
    [self.view addSubview:self.setpwdTableView];
    
    self.setpwdTableView.delegate = self;
    self.setpwdTableView.dataSource = self;
    
}

#pragma mark -- tableView 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WalletCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pwdCell"];
    if (!cell) {
        cell = [[WalletCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"pwdCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLabel.text = _titleArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        PwdLoginResetViewController *pwdLoginResetVC = [[PwdLoginResetViewController alloc]init];
        pwdLoginResetVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pwdLoginResetVC animated:YES];
//        pwdLoginResetVC.hidesBottomBarWhenPushed = NO;
 
    }
    if (indexPath.row == 1) {
        PwdViewController *pwdPaySetVC = [[PwdViewController alloc]init];
        pwdPaySetVC.hidesBottomBarWhenPushed = YES;
        pwdPaySetVC.title = @"支付密码设置";
        [self.navigationController pushViewController:pwdPaySetVC animated:YES];
//        pwdPaySetVC.hidesBottomBarWhenPushed = NO;

    }
    if (indexPath.row == 2) {
        PwdViewController *pwdPaySetVC = [[PwdViewController alloc]init];
        pwdPaySetVC.hidesBottomBarWhenPushed = YES;
        pwdPaySetVC.title = @"支付密码修改";
        [self.navigationController pushViewController:pwdPaySetVC animated:YES];
        //        pwdPaySetVC.hidesBottomBarWhenPushed = NO;
        
    }
    if (indexPath.row == 3) {
        PwdViewController *pwdPaySetVC = [[PwdViewController alloc]init];
        pwdPaySetVC.hidesBottomBarWhenPushed = YES;
        pwdPaySetVC.title = @"支付密码忘记";

        [self.navigationController pushViewController:pwdPaySetVC animated:YES];
        //        pwdPaySetVC.hidesBottomBarWhenPushed = NO;
        
    }

}
@end
