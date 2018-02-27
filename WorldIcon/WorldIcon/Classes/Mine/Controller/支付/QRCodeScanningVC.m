//
//  QRCodeScanningVC.m
//  SGQRCodeExample
//
//  Created by apple on 17/3/21.
//  Copyright © 2017年 JP_lee. All rights reserved.
//

#import "QRCodeScanningVC.h"
#import "ScanSuccessJumpVC.h"
#import "UserInfoRequest.h"

@interface QRCodeScanningVC ()

@end

@implementation QRCodeScanningVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"支付";
    
    // 注册观察者
    [SGQRCodeNotificationCenter addObserver:self selector:@selector(SGQRCodeInformationFromeScanning:) name:SGQRCodeInformationFromeScanning object:nil];
}

- (void)SGQRCodeInformationFromeScanning:(NSNotification *)noti {
    SGQRCodeLog(@"noti - - %@", noti);
    NSString *string = noti.object;
    
    if ([string hasPrefix:@"http"] || ![string containsString:@"_"]) {
        [MBProgressHUD gc_showErrorMessage:@"请扫描对方oc地址！"];
        return;
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.jump_URL = string;
//        [self.navigationController pushViewController:jumpVC animated:YES];
//        [self loadNameWith:string];
    }
//    else{ // 扫描结果为条形码
        [self loadNameWith:[tool customSecureStr:string]];
//
//    }
}
-(void)loadNameWith:(NSString *)codeSttring{
    //    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];
    
    
    NSArray *array = [codeSttring componentsSeparatedByString:@"_"];
    NSString *codeID;
    if (array.count == 2) {

    codeID=array[1];
    }
    
    
    UserInfoRequest *userInfoReq = [UserInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        //        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {
            
            //            [MBProgressHUD gc_hiddenHUD];
            //
            
            //
            
            ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
            jumpVC.payName=[NSString stringWithFormat:@"%@",responseDict[@"user_detail"][@"ud_nickname"]];
            jumpVC.jump_bar_code = codeSttring;
            [self.navigationController pushViewController:jumpVC animated:YES];
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
        
    } failureBlock:^(NSError *error) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    
    userInfoReq.ub_id =codeID;
    userInfoReq.ub_phone = @"";
    userInfoReq.type = @"1";
    [userInfoReq startRequest];
    
    
    
}

- (void)dealloc {
    SGQRCodeLog(@"QRCodeScanningVC - dealloc");
    [SGQRCodeNotificationCenter removeObserver:self];
}

@end
