//
//  QRCodeScanningVC.m
//  SGQRCodeExample
//
//  Created by apple on 17/3/21.
//  Copyright © 2017年 JP_lee. All rights reserved.
//

#import "QRCodeScanningVC.h"
#import "ScanSuccessJumpVC.h"

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
    } else{ // 扫描结果为条形码
        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
        string = [tool customSecureStr:string];
        jumpVC.jump_bar_code = string;
        [self.navigationController pushViewController:jumpVC animated:YES];
    }
}

- (void)dealloc {
    SGQRCodeLog(@"QRCodeScanningVC - dealloc");
    [SGQRCodeNotificationCenter removeObserver:self];
}

@end
