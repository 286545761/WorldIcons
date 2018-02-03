//
//  ConfirmTransferMoneyViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/2.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ConfirmTransferMoneyViewController.h"
#import "ConfirmTransferMoneyView.h"
#import "SupreappNodeRequest.h"
@interface ConfirmTransferMoneyViewController ()
@property (nonatomic,strong)ConfirmTransferMoneyView *confirmView;
@end

@implementation ConfirmTransferMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"确认汇款";
    
    [self setUpMainView];
    
}
-(void)setUpMainView{

    self.confirmView = [[ConfirmTransferMoneyView alloc]initWithFrame:self.view.bounds];
    @weakify(self);
    self.confirmView.submitBlock = ^(){
        @strongify(self);
        [self supreappnode];
        
    };
    [self.view addSubview:self.confirmView];
    
}
-(void)supreappnode{

    [MBProgressHUD gc_showActivityMessageInWindow:@"提交中..."];
    
    SupreappNodeRequest *getappReq = [SupreappNodeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];

        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD gc_hiddenHUD];
    }];
   
    getappReq.ub_id = [UserManager getUID];
    getappReq.vra_id = self.vra_id;
    getappReq.vrs_pic = @"";
    getappReq.vrs_status = self.vrs_status;
    getappReq.vrs_info = [NSString stringWithFormat:@"%@%@",self.confirmView.hkjeLabel.field.text,self.confirmView.hktimeLabel.field.text];
    [getappReq startRequest];
    
}
@end
