//
//  BaseInfoViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BaseInfoViewController.h"
#import "BaseInfoView.h"
#import "ApplicatView.h"

#import "EditBaseInfoViewController.h"
#import "BaozhjinViewController.h"

#import "GetappRequest.h"

@interface BaseInfoViewController ()
@property (nonatomic,strong)NSDictionary *responseDict;
@end

@implementation BaseInfoViewController
- (NSDictionary *)responseDict{
    if (!_responseDict) {
        _responseDict = [NSDictionary dictionary];
    }
    return _responseDict;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadBaseInfo];

}
-(void)loadBaseInfoViewWithDic:(NSDictionary *)dic{

    BaseInfoView *baseInfoView = [[BaseInfoView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight) withDic:dic];
    
    baseInfoView.block = ^(NSInteger tag){
        
        if (tag == 2001) {//保证金
            
            BaozhjinViewController *baozhjinVC = [[BaozhjinViewController alloc]init];
            baozhjinVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:baozhjinVC animated:YES];
            
        }
        if (tag == 2002) {//个人信息
            
            EditBaseInfoViewController *editVC = [[EditBaseInfoViewController alloc]init];
            editVC.hidesBottomBarWhenPushed = YES;
            editVC.dic = self.responseDict;
            [self.navigationController pushViewController:editVC animated:YES];
            
        }
    };
    
    [self.view addSubview:baseInfoView];
    
}
-(void)loadBaseInfo{

    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    GetappRequest *getappReq = [GetappRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }else if ([model.code isEqualToString:@"10"]) {
            
            [MBProgressHUD gc_showSuccessMessage:@"加载成功"];
            
            self.responseDict = responseDict;
            
            [self loadBaseInfoViewWithDic:responseDict];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    
    [getappReq startRequest];

}
@end
