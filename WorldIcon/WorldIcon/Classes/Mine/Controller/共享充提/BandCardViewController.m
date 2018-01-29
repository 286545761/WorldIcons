//
//  BandCardViewController.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/4.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "BandCardViewController.h"
#import "GXCTApplyTableViewCell.h"
#import "SharingApplicationModel.h"
#import "GetCardRequest.h"
#import "CardModel.h"
#import "ZHPickView.h"
#import "OSAddressPickerView.h"
@interface BandCardViewController ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate>
/**
 *<##>
 */
@property(nonatomic,strong)OSAddressPickerView *addressPickerView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton  *submitBtn;
@property (nonatomic,strong)ZHPickView *pickview;


/**
 *<##>
 */
@property(nonatomic,strong)NSMutableArray *bandCardArray;
/**
 *<##>
 */
@property(nonatomic,strong)NSMutableArray *cardsArray;
/**
 *co
 */
@property(nonatomic,strong)NSMutableArray *cardCountArray;
@end

@implementation BandCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCardListOnNet];
    [self.view addSubview:self.tableView];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    back.backgroundColor = [UIColor clearColor];
    [back addSubview:self.submitBtn];
    self.tableView.tableFooterView = back;
}
-(NSMutableArray *)cardCountArray{
    if (!_cardCountArray) {
        _cardCountArray =[[NSMutableArray alloc]init];
    }
    return _cardCountArray;
}
-(NSMutableArray *)cardsArray{
    if (!_cardsArray) {
        _cardsArray =[[NSMutableArray alloc]init];
    }
    return _cardsArray;
}
-(void)loadCardListOnNet{
    
    GetCardRequest *getCardReq = [GetCardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            if (self.cardsArray.count) {
                [self.cardsArray removeAllObjects];
            }
            
            for (NSDictionary *item in responseDict[@"user_card"]) {
                
                CardModel *m = [[CardModel alloc]initWithDictionary:item error:nil];
                [self.cardCountArray addObject:m.uc_card];
                [self.cardsArray addObject:m];
            }

            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getCardReq.ub_id = [UserManager getUID];
    
    [getCardReq startRequest];
}

-(NSMutableArray *)bandCardArray{
    
    
    if (!_bandCardArray) {
        _bandCardArray =[[NSMutableArray alloc]init];
        
        NSArray *needBandCardArray=@[@[@"银行账户",@"请选择银行账户"],@[@"账户名字",@"银行账户名字"],@[@"所在省份",@"所在省市"],@[@"省市",@"省市"],@[@"城市",@"城市"]];
        [self ConversionModelWithArray:needBandCardArray];
        
    }
    return _bandCardArray;
}
-(void)ConversionModelWithArray:(NSArray*)bandCardArr{
    
    for (NSArray *info in bandCardArr) {
        SharingApplicationModel *model=[[SharingApplicationModel alloc]init];
        model.titile=info[0];
        if (info.count>1) {
                   model.titledetails=info[1];
        }
        [self.bandCardArray addObject:model];
 
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"GXCTApplyTableViewCell";
    GXCTApplyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GXCTApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.index=indexPath;
    cell.model=self.bandCardArray[indexPath.row];
    
    __weak typeof(self) weakSelf=self;
    cell.selectBlock=^(NSIndexPath*indexPath){
        if (indexPath.row==0) {
            if (weakSelf.cardsArray.count>0) {
                [weakSelf showCardCountView];
            }
          
        }else if (indexPath.row==3||indexPath.row==4){
            
            [self.addressPickerView showBottomView];
            
            
        }
       
        
        
    };
    return cell;
}
-(void)showCardCountView{
    if (self.pickview) {
        self.pickview=nil;
    }
    if (self.cardCountArray.count>0) {
        
    _pickview = [[ZHPickView alloc]initWithArray:self.cardCountArray];
    _pickview.frame = CGRectMake(0, 0, GCWidth, GCHeight);
//    _pickview.tag = 100+index.section;
    _pickview.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
    [self.view addSubview:_pickview];
    _pickview.delegate=self;
        [_pickview showView];}
    else{
            
            NSLog(@"绑定银行卡");
            
        }
    
    
    
    
}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if ([self.cardCountArray containsObject:resultString]) {
       
  CardModel *m=self.cardsArray[[self.cardCountArray indexOfObject:resultString]];
        SharingApplicationModel *model=self.bandCardArray[0];
        model.titledetails=m.uc_card;
        
        self.bandCardArray[0]=model;
        SharingApplicationModel *namemodel=self.bandCardArray[1];
        namemodel.titledetails=m.uc_name;
        self.bandCardArray[1]=namemodel;
        
            SharingApplicationModel *LocalModel=self.bandCardArray[2];
        LocalModel.titledetails=[NSString stringWithFormat:@"%@  %@",m.uc_khh,m.uc_addr];
        self.bandCardArray[2]=LocalModel;
        [self.tableView reloadData];
        
        
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bandCardArray.count;
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
-(OSAddressPickerView *)addressPickerView{
    
    if (!_addressPickerView) {
        _addressPickerView = [OSAddressPickerView shareInstance];
//        [_addressPickerView showBottomView];
        [kAppWindow addSubview:_addressPickerView];
        
        @weakify(self);
        
        _addressPickerView.block = ^(NSString *province,NSString *city,NSString *district)
        {
            @strongify(self);
            
            SharingApplicationModel *provincemodel=self.bandCardArray[3];
            provincemodel.titledetails=province;
            self.bandCardArray[3]=provincemodel;
              SharingApplicationModel *citymodel=self.bandCardArray[4];
            citymodel.titledetails=city;
            self.bandCardArray[4]=citymodel;
            [self.tableView reloadData];
        };
    }
    return _addressPickerView;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
