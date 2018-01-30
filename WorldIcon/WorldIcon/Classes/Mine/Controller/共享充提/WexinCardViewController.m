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
#import "GetCardRequest.h"
#import "CardModel.h"
#import "ZHPickView.h"
#import "OSAddressPickerView.h"
#import "SubappRequest.h"
#import "WaitView.h"
@interface WexinCardViewController ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton  *submitBtn;
/**
 *
 */
@property(nonatomic,strong)ZHPickView *pickview;
/**
 *<##>
 */
@property(nonatomic,strong)OSAddressPickerView *addressPickerView;

/**
 *列表模型
 */
@property(nonatomic,strong)NSMutableArray *WexinCardArray;
/**
 *存储所有的微信账号信息 名字 所在地
 */
@property(nonatomic,strong)NSMutableArray *WexinCountArray;
/**
 *存储所有的微信账号
 */
@property(nonatomic,strong)NSMutableArray *allWeXinCountArray;

@end

@implementation WexinCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWexinCardInfo];
    [self.view addSubview:self.tableView];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    back.backgroundColor = [UIColor clearColor];
    [back addSubview:self.submitBtn];
    self.tableView.tableFooterView = back;
}
-(OSAddressPickerView *)addressPickerView{
    
    //    if (!_addressPickerView) {
    _addressPickerView = [OSAddressPickerView shareInstance];
    //        [_addressPickerView showBottomView];
    [kAppWindow addSubview:_addressPickerView];
    
    @weakify(self);
    
    _addressPickerView.block = ^(NSString *province,NSString *city,NSString *district)
    {
        @strongify(self);
        
        SharingApplicationModel *provincemodel=self.WexinCardArray[2];
        provincemodel.titledetails=province;
        self.WexinCardArray[2]=provincemodel;
        SharingApplicationModel *citymodel=self.WexinCardArray[3];
        citymodel.titledetails=city;
        self.WexinCardArray[3]=citymodel;
        [self.tableView reloadData];
    };
    //    }
    return _addressPickerView;
}

-(NSMutableArray *)allWeXinCountArray{
    if (!_allWeXinCountArray) {
        _allWeXinCountArray =[[NSMutableArray alloc]init];
    }
    return _allWeXinCountArray;
}
-(NSMutableArray *)WexinCountArray{
    if (!_WexinCountArray) {
        _WexinCountArray =[[NSMutableArray alloc]init];
    }
    return _WexinCountArray;
}
-(void)loadWexinCardInfo{
    
    
    GetCardRequest *getCardReq = [GetCardRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            if (self.WexinCountArray) {
                [self.WexinCountArray removeAllObjects];
                [self.allWeXinCountArray removeAllObjects];
            }
            
            for (NSDictionary *item in responseDict[@"user_card"]) {

                CardModel *m = [[CardModel alloc]initWithDictionary:item error:nil];

                [self.WexinCountArray addObject:m];

                [self.allWeXinCountArray addObject:m.uc_card];

            }
            
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    getCardReq.ub_id = [UserManager getUID];
    getCardReq.type=@"2";
    
    
    [getCardReq startRequest];
    
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
    __weak  typeof(self) weakSelf=self;
    cell.index=indexPath;
    cell.model=self.WexinCardArray[indexPath.row];
    cell.selectBlock=^(NSIndexPath*indexPath){
        
        
        if (indexPath.row==0) {
            
            [weakSelf showCardCountView];
            
            
        }else if (indexPath.row==2||indexPath.row==3){
            
            [self.addressPickerView showBottomView];
            
            
        }
        
        
        
    };
    return cell;
}

-(void)showCardCountView{
    
    if (self.allWeXinCountArray.count>0) {
        if (self.pickview) {
            self.pickview=nil;
        }
        _pickview = [[ZHPickView alloc]initWithArray:self.allWeXinCountArray];
        _pickview.frame = CGRectMake(0, 0, GCWidth, GCHeight);
        //    _pickview.tag = 100+index.section;
        _pickview.backgroundColor = [UIColor gc_colorWithHexString:@"#000000" alpha:0.6];
        [self.view addSubview:_pickview];
        _pickview.delegate=self;
        [_pickview showView];
        
    }
    else{
        [MBProgressHUD gc_showSuccessMessage:@"请绑定银行卡"];
    }
    
    
    
    
}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if ([self.allWeXinCountArray containsObject:resultString]) {
        
        CardModel *m=self.WexinCountArray[[self.allWeXinCountArray indexOfObject:resultString]];
        SharingApplicationModel *model=self.WexinCardArray[0];
        model.titledetails=m.uc_card;
        
        self.WexinCardArray[0]=model;
        SharingApplicationModel *namemodel=self.WexinCardArray[1];
        namemodel.titledetails=m.uc_name;
        self.WexinCardArray[1]=namemodel;
        
//        SharingApplicationModel *LocalModel=self.bandCardArray[2];
//        LocalModel.titledetails=[NSString stringWithFormat:@"%@  %@",m.uc_khh,m.uc_addr];
//        self.bandCardArray[2]=LocalModel;
        [self.tableView reloadData];
        
        
    }
    
    
    
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
    
//    if (self.backBlock) {
//        self.backBlock();
//    }
    SubappRequest*subApp = [SubappRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {

        if ([model.code isEqualToString:@"01"]) {

            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }else if ([model.code isEqualToString:@"10"]) {
//                    [MBProgressHUD gc_showSuccessMessage:[NSString stringWithFormat:@"%@",responseDict[@"result"][@"info"]]];

            if (self.backBlock) {
                self.backBlock();
            }
//            WaitView *waitView = [[WaitView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//            [self.view addSubview:waitView];


        }else if([model.code isEqualToString:@"20"]) {

            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{

            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }

    } failureBlock:^(NSError *error) {

    }];

    subApp.ub_id = [UserManager getUID];

    subApp.type=@"0";
    subApp.va_card=@"0";
    subApp.va_yhzh=@"0";
    subApp.va_weixin=@"1";
    subApp.va_name=@"0";
    subApp.va_zf_name=@"0";
    subApp.va_zhifubao=@"0";
    subApp.va_zf_zh=@"0";

    subApp.va_yhzh=@"0";
    subApp.va_khh=@"0";
    subApp.ub_id = [UserManager getUID];







    SharingApplicationModel *name=self.WexinCardArray[1];

    subApp.va_wx_name=name.titledetails;
    SharingApplicationModel *va_yhzh=self.WexinCardArray[0];
    subApp.va_wx_zh=va_yhzh.titledetails;
    SharingApplicationModel *va_sf=self.WexinCardArray[2];
    subApp.va_sf=va_sf.titledetails;
    SharingApplicationModel *va_cs=self.WexinCardArray[3];
    subApp.va_cs=va_cs.titledetails;
    [subApp startRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
