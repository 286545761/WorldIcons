//
//  newBaseInfoViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newBaseInfoViewController.h"
#import "GXCTApplyTableViewCell.h"
@interface newBaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton  *submitBtn;

@end

@implementation newBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    back.backgroundColor = [UIColor clearColor];
    [back addSubview:self.submitBtn];
    self.tableView.tableFooterView = back;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"GXCTApplyTableViewCell";
    GXCTApplyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GXCTApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.index=indexPath;
//    cell.model=self.bandCardArray[indexPath.row];
    
//    __weak typeof(self) weakSelf=self;
    cell.selectBlock=^(NSIndexPath*indexPath){
        
        
//        if (indexPath.row==0) {
//
//            [weakSelf showCardCountView];
//
//
//        }else if (indexPath.row==3||indexPath.row==4){
//
//            [self.addressPickerView showBottomView];
//
//
//        }
        
        
        
    };
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIView countBeforeWithIphone5Length:45];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIView countBeforeWithIphone5Length:5];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        rect.origin.x = 10;
        rect.origin.y =10;
        rect.size.width -= 20;
        rect.size.height -= 64;
        rect.size.height -= 44;
        rect.size.height -= 14;
        rect.size.height -= 10;

        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
