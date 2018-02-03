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
static NSString *cellT=@"newBaseInfoTableViewCell";
@interface newBaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton  *submitBtn;
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
    [back addSubview:self.submitBtn];
    self.tableView.tableFooterView = back;
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
    getCardReq.type=@"0";
    
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
        
    } ;
    return cell;
    
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
