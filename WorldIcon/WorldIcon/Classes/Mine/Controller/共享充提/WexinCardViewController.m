//
//  WexinCardViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/4.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "WexinCardViewController.h"
#import "GXCTApplyTableViewCell.h"
#import "SharingApplicationModel.h"
@interface WexinCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton  *submitBtn;
/**
 *<##>
 */
@property(nonatomic,strong)NSMutableArray *WexinCardArray;

@end

@implementation WexinCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    back.backgroundColor = [UIColor clearColor];
    [back addSubview:self.submitBtn];
    self.tableView.tableFooterView = back;
}
-(NSMutableArray *)WexinCardArray{
    if (!_WexinCardArray) {
        _WexinCardArray =[[NSMutableArray alloc]init];
        NSArray *needBandCardArray=@[@[@"微信号",@"请选择微信号"],@[@"微信名字",@"微信名字"],@[@"省市",@"省市"],@[@"城市",@"城市"]];
        [self ConversionModelWithArray:needBandCardArray];
    }
    
    
    return _WexinCardArray;
}
-(void)ConversionModelWithArray:(NSArray*)bandCardArr{
    
    for (NSArray *info in bandCardArr) {
        SharingApplicationModel *model=[[SharingApplicationModel alloc]init];
        model.titile=info[0];
        if (info.count>1) {
            model.titledetails=info[1];
        }
        [self.WexinCardArray addObject:model];
        
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"GXCTApplyTableViewCell";
    GXCTApplyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GXCTApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model=self.WexinCardArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.WexinCardArray.count;
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
        rect.size.width -= 20;
        rect.size.height -= 64;
        rect.size.height -= 44;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        //        _tableView.separatorInset = UIEdgeInsetsMake(0,[UIView countBeforeWithIphone5Length:10], 0, [UIView countBeforeWithIphone5Length:10]);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _submitBtn.adaptiveIphone5Frame = CGRectMake(35, 20, 320-70, 40);
        [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    return _submitBtn;
}

-(void)submitBtnAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
