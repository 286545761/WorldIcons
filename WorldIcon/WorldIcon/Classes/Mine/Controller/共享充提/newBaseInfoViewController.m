//
//  newBaseInfoViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newBaseInfoViewController.h"
#import "GXCTApplyTableViewCell.h"
#import "newBaseInfoTableViewCell.h"
#import "GetCardRequest.h"
#import "newBaseInfoModel.h"
#import "toDepositOrturnsOutMarginViewController.h"
#import "editPersonalInformationViewController.h"
static NSString *cellT=@"newBaseInfoTableViewCell";
@interface newBaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton  *toDepositBtn;//转入保证金
@property(nonatomic,strong)UIButton  *turnsOutMarginBtn;// 转出保证金
/**
 *列表
 */
@property(nonatomic,strong)NSMutableArray *listArray;

@end

@implementation newBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAcountBaseInfo];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    back.backgroundColor = [UIColor clearColor];
    [back addSubview:self.toDepositBtn];
    [self.toDepositBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(back.mas_centerY);
        make.left.equalTo(back.mas_left).offset(35);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2-2*35, 40));
    }];
    [back addSubview:self.turnsOutMarginBtn];
    
    [self.turnsOutMarginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(back.mas_centerY);
        make.right.equalTo(back.mas_right).offset(-35);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2-2*35, 40));
    }];
    
    
    self.tableView.tableFooterView = back;
}
-(UIButton *)toDepositBtn{
    if (!_toDepositBtn) {
       _toDepositBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toDepositBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [_toDepositBtn setTitle:@"转入保证金" forState:UIControlStateNormal];
        [_toDepositBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toDepositBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _toDepositBtn.tag=1000;
        _toDepositBtn.layer.cornerRadius=20.f;
        _toDepositBtn.layer.masksToBounds=YES;
//        _toDepositBtn.adaptiveIphone5Frame = CGRectMake(35, 20, 100, 40);
        [_toDepositBtn addTarget:self action:@selector(toDepositOrturnsOutMarginAction:) forControlEvents:UIControlEventTouchDown];

    }
    return _toDepositBtn;
}
-(UIButton *)turnsOutMarginBtn{
    if (!_turnsOutMarginBtn) {
       _turnsOutMarginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_turnsOutMarginBtn setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
        [_turnsOutMarginBtn setTitle:@"转出保证金" forState:UIControlStateNormal];
        [_turnsOutMarginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       _turnsOutMarginBtn.layer.cornerRadius=20.f;
        _turnsOutMarginBtn.layer.masksToBounds=YES;
        _turnsOutMarginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _turnsOutMarginBtn.tag=1001;
//        _toDepositBtn.adaptiveIphone5Frame = CGRectMake(320-35-100, 20, 100, 40);
        [_turnsOutMarginBtn addTarget:self action:@selector(toDepositOrturnsOutMarginAction:) forControlEvents:UIControlEventTouchDown];
    }
    
    return _turnsOutMarginBtn;
}
-(void)toDepositOrturnsOutMarginAction:(UIButton*)button{
    toDepositOrturnsOutMarginViewController *toDepositOrturnsOutMarginVC=[[toDepositOrturnsOutMarginViewController alloc]init];
    
    if (button.tag==1000) {//转入保证金
        toDepositOrturnsOutMarginVC.typeString=@"0";
    }else{
        toDepositOrturnsOutMarginVC.typeString=@"1";
        
    }
    [self.navigationController pushViewController:toDepositOrturnsOutMarginVC animated:YES];
    
    
}
-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray =[[NSMutableArray alloc]init];
        NSArray *needBandCardArray=@[@[@"银行卡",@"银行账户",@"账户名字",@"所在省市"],@[@"微信",@"银微信号",@"微信名字"],@[@"支付宝",@"银微信号",@"微信名字"],@[@"位置",@"省份",@"城市",@"保证金"]];
        [self ConversionModelWithArray:needBandCardArray];
    }
    return _listArray;
}
-(void)ConversionModelWithArray:(NSArray*)bandCardArr{

    for (NSArray *info in bandCardArr) {
        newBaseInfoModel *model=[[newBaseInfoModel alloc]init];
        model.typeString=info[0];
        model.acountTextString=info[1];
        model.acoutNameString=info[2];
        if ([info lastObject]!=model.acoutNameString) {
            model.localTextString=info[3];
            
            
        }

        
        [self.listArray addObject:model];

    }
    
}


-(void)loadAcountBaseInfo{
    GetCardRequest *getCardReq = [GetCardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            NSInteger i=0;
            for (NSDictionary *item in responseDict[@"user_card"]) {
                newBaseInfoModel *model=self.listArray[i];
                model.acountString=item[@"uc_card"];
                model.acountName=item[@"uc_name"];
                model.local=item[@"uc_khh"];
                model.addString=item[@"uc_addr"];
                
              
                self.listArray[i]=model;
                  i++;
            }
            [self.tableView reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getCardReq.ub_id = [UserManager getUID];
    getCardReq.type=@"1";
    
    [getCardReq startRequest];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    newBaseInfoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellT];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.index=indexPath;
    cell.model=self.listArray[indexPath.row];
    __weak typeof(self)  weakSelf=self;
    cell.editorBlock = ^(NSIndexPath *index) {
        [weakSelf editPersonalInformation:index];
        
        
    } ;
    return cell;
    
}
-(void)editPersonalInformation:(NSIndexPath*)index{
    editPersonalInformationViewController *editPersonalInformationVC=[[editPersonalInformationViewController alloc]init];
    editPersonalInformationVC.typeString=[NSString stringWithFormat:@"%ld",(long)index.row];
    editPersonalInformationVC.title=@"共享者修改";
    [self.navigationController pushViewController:editPersonalInformationVC animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 130;
    }
    return 100;
//    return [UIView countBeforeWithIphone5Length:45];
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
         _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[newBaseInfoTableViewCell class] forCellReuseIdentifier:cellT];
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
