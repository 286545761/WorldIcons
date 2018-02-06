//
//  newCurrentProgressAViewController.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/5.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newCurrentProgressAViewController.h"

#import "newCurrentProgressApplicantsTableViewCell.h"
#import "newCurrentProgressSharersTableViewCell.h"
#import "newCurrentProgressApplicantsTableViewCell.h"
#import "newCurrentProgressTableViewCell.h"
#import "newCurrentProgressMakeSureMoneyTableViewCell.h"
#import "GetReappRequest.h"
#import "GXCTModel.h"
#import "cancelOrderppRequest.h"
#import "ShareCTView.h"
#import "SupreappNodeRequest.h"
#import "ConfirmTransferMoneyViewController.h"



static NSString *SharersCell=@"newCurrentProgressSharersTableViewCell";
static NSString *ApplicantsSharersCell=@"newCurrentProgressApplicantsTableViewCell";
static NSString *ProgressCell=@"newCurrentProgressTableViewCell";
static NSString *MakeSureMoneyCell=@"newCurrentProgressMakeSureMoneyTableViewCell";
static NSString *fcell=@"fcell";
@interface newCurrentProgressAViewController ()<UITableViewDataSource,UITableViewDelegate,ShareCTViewBtnChooseViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *senderMessageView;
@property(nonatomic,strong)NSMutableDictionary *reappDic;
@property(nonatomic,strong)UITextField *senderTextField;
@property(nonatomic,strong)NSMutableArray *reappStatusArray;
@property(nonatomic,strong)ShareCTView *shareCTView;
@property(nonatomic,assign)BOOL isShowMakeMoney;
@end

@implementation newCurrentProgressAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadGetReappWithModel:self.model];
    self.isShowMakeMoney=NO;
     self.navLabel.text = @"当前进度";
//    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];

    [self.view addSubview:self.senderMessageView];
    [self.senderMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.height.equalTo(@50);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.senderMessageView.mas_top);
    }];

    
}
-(NSMutableArray *)reappStatusArray{
    
    if (!_reappStatusArray) {
        _reappStatusArray =[[NSMutableArray alloc]init];
    }
    return _reappStatusArray;
}
-(NSMutableDictionary *)reappDic{
    
    if (!_reappDic) {
        _reappDic =[[NSMutableDictionary alloc]init];
    }
    return _reappDic;
}
-(void)loadGetReappWithModel:(ReApp *)model{
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    GetReappRequest *getappReq = [GetReappRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            self.reappDic = responseDict[@"vm_reapp"];
            
            for (NSDictionary *d in responseDict[@"vm_reapp_status"]) {
                
                ReAppStatus *m = [[ReAppStatus alloc]initWithDictionary:d error:nil];
                
                [self.reappStatusArray addObject:m];
            }
               ReAppStatus*m=self.reappStatusArray.lastObject;
            if ([self.reappDic[@"vra_type"] intValue] == 1) {//充值
                if ([m.vrs_status isEqualToString:@"1"]) {
                    self.isShowMakeMoney=YES;
                }else{
                    self.isShowMakeMoney=NO;
                    
                }
             
            }else{//
                
                if ([m.vrs_status isEqualToString:@"2"]) {
                    self.isShowMakeMoney=YES;
                }else{
                    self.isShowMakeMoney=NO;
                    
                }
                
            }
           
            
            
            [self.tableView reloadData];
            
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = model.vra_id;
    [getappReq startRequest];
    
}

-(void)setModel:(ReApp *)model{
    
    
    _model= model;
}
-(UIView *)senderMessageView{
    
    if (!_senderMessageView) {
       _senderMessageView =[[UIView alloc]initWithFrame:CGRectMake(10, GCHeight-50,GCWidth-20 , 50)];
        _senderMessageView.backgroundColor =[UIColor whiteColor];
        
       self.senderTextField =[UITextField textFieldWithBackGroundColor:[UIColor whiteColor] withText:@"" withTextAlignment:NSTextAlignmentLeft withTextFont:15 withTextColor:[UIColor gc_colorWithHexString:@"#66666"] withPlaceholderString:@"请输入留言" withTextFieldDelegate:self withClearButtonMode:UITextFieldViewModeNever withSecurtTextEntry:NO withKeyboardTtype:UIKeyboardTypeDefault withReturnKeyType:  UIReturnKeyDefault withParentView:_senderMessageView];
        self.senderTextField.layer.cornerRadius=10.f;
        self.senderTextField.layer.borderColor=[UIColor gc_colorWithHexString:@"#666666"].CGColor;
        self.senderTextField.layer.borderWidth=2.f;
        self.senderTextField.layer.masksToBounds=YES;
        [_senderMessageView addSubview:self.senderTextField];
        self.senderTextField.frame=CGRectMake(10, 10, GCWidth-80, 35);
        UIButton *sendButton=[[UIButton alloc]init];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor gc_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [sendButton addTarget:sendButton action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        
        sendButton.frame=CGRectMake(GCWidth-60, 10, 50, 35);
        
        [_senderMessageView addSubview:sendButton];
    
    }
    
    return _senderMessageView;
}
-(void)sendMessage{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.isShowMakeMoney) {
        return 4;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if ([self.reappDic[@"vra_type"] intValue] == 1) {
            return 100;
        }else if ([self.reappDic[@"vra_type"] intValue] == 0){
            
             return 225;
            
        }
        
    
    }
    if (indexPath.section==1) {
        if (self.reappStatusArray.count==2) {
             return 125;
        }
        return 60;
    }
    if (indexPath.section==2) {
        if (self.isShowMakeMoney) {
            return 80;
        }
        return 40;
    }

        return 40;
  
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIView countBeforeWithIphone5Length:5];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.view.bounds;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.backgroundColor=RGBA(231, 234, 243, 1);

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        [_tableView registerClass:[newCurrentProgressSharersTableViewCell class] forCellReuseIdentifier:SharersCell];
        [_tableView registerClass:[newCurrentProgressApplicantsTableViewCell class] forCellReuseIdentifier:ApplicantsSharersCell];
        [_tableView registerClass:[newCurrentProgressTableViewCell class] forCellReuseIdentifier:ProgressCell];;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:fcell];
  
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if ([self.reappDic[@"vra_type"] intValue] == 1) {
            newCurrentProgressApplicantsTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ApplicantsSharersCell];
            cell.appDic=self.reappDic;
                    return cell;
            }else if ([self.reappDic[@"vra_type"] intValue] == 0){
            newCurrentProgressSharersTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SharersCell];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (self.reappStatusArray.count>0) {
                ReAppStatus *m=self.reappStatusArray.lastObject;
                if ([m.vrs_status isEqualToString:@"1"]) {
                    cell.isShow=YES;
                }else{
                      cell.isShow=NO;
                }
            cell.appDic=self.reappDic;
                
                __weak typeof(self) weakSelf=self;
                cell.cancleBlock = ^{
                    [weakSelf cancelOrder];
                };
            return cell;
            }
        }
  
    }
    if (indexPath.section==1) {
        newCurrentProgressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ProgressCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.appArray=self.reappStatusArray;
        return cell;
    }
    if (indexPath.section==2) {
        if (self.isShowMakeMoney) {
            newCurrentProgressMakeSureMoneyTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:MakeSureMoneyCell];
            
            
            
            if (!hotCell)
            {
                hotCell = [[newCurrentProgressMakeSureMoneyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MakeSureMoneyCell];
                
            }
            hotCell.backgroundColor=[UIColor clearColor];
            hotCell.selectionStyle=UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf=self;
            hotCell.makeSureBlock = ^{
                [weakSelf makeSureOrder];
                
            };
            hotCell.agreedBlock = ^{
                [weakSelf agreedInfo];
            };
            
            
            
            return hotCell;
        }else{
            UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:fcell];
            cell.backgroundColor =[UIColor whiteColor];
            cell.layer.cornerRadius=10.f;
            cell.layer.masksToBounds=YES;
            CGRect newFrame=cell.frame;
            newFrame.origin.y+=10;
            newFrame.origin.x+=10;
            newFrame.size.width-=20;
            cell.frame=newFrame;
            cell.textLabel.text=@"    留言";
            cell.textLabel.textColor=[UIColor blackColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        
    }
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:fcell];
    cell.backgroundColor =[UIColor whiteColor];
    cell.layer.cornerRadius=10.f;
    cell.layer.masksToBounds=YES;
    CGRect newFrame=cell.frame;
    newFrame.origin.y+=10;
    newFrame.origin.x+=10;
    newFrame.size.width-=20;
    cell.frame=newFrame;
    cell.textLabel.text=@"    留言";
    cell.textLabel.textColor=[UIColor blackColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)agreedInfo{

        UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
        self.shareCTView = [[ShareCTView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.shareCTView.delegate = self;
        [Windown addSubview:self.shareCTView];

  
    
    
}
-(void)makeSureOrder{
    
    if ([self.reappDic[@"vra_type"] intValue] == 1) {
        [self supreappnodeWithModel1:self.model];
    }else{
        
          [self supreappnodeWithModel:self.model];
    }
 
}
-(void)supreappnodeWithModel:(ReApp *)model{//充值
    __weak typeof(self) weakSelf=self;
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    SupreappNodeRequest *getappReq = [SupreappNodeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
             [ weakSelf loadGetReappWithModel: weakSelf.model];
            
               weakSelf.isShowMakeMoney=NO;
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = model.vra_id;
    getappReq.vrs_status = @"3";
    getappReq.vrs_info = @"";
    getappReq.vrs_pic = @"";
    
    [getappReq startRequest];
    
    
    ConfirmTransferMoneyViewController *confireVC = [[ConfirmTransferMoneyViewController alloc]init];
    confireVC.vra_id =model.vra_id;
    confireVC.vrs_status = @"2";
    [self.navigationController pushViewController:confireVC animated:YES];

}
-(void)supreappnodeWithModel1:(ReApp *)model{//提现
    __weak typeof(self) weakSelf=self;
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    SupreappNodeRequest *getappReq = [SupreappNodeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
               [weakSelf loadGetReappWithModel: weakSelf.model];
//            [self.navigationController popViewControllerAnimated:YES];
            weakSelf.isShowMakeMoney=NO;
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = model.vra_id;
    getappReq.vrs_status = @"2";
    getappReq.vrs_info = @"";
    getappReq.vrs_pic = @"";
    
    [getappReq startRequest];
}


-(void)cancelOrder{
    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    cancelOrderppRequest *getappReq = [cancelOrderppRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [MBProgressHUD gc_showSuccessMessage:[NSString stringWithFormat:@"%@",responseDict[@"result"][@"info"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                   [self.navigationController popViewControllerAnimated:NO];
            });
         
            
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = self.model.vra_id;
    [getappReq startRequest];
    
    
    
}
- (void)bottomPassBtnOnClick{
    [self.shareCTView removeFromSuperview];
    self.shareCTView=nil;
    
}
@end
