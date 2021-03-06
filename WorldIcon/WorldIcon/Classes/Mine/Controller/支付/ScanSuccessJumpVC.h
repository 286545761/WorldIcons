//
//  ScanSuccessJumpVC.h
//  SGQRCodeExample
//
//  Created by Sorgle on 16/8/29.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "WIBaseViewController.h"

@interface ScanSuccessJumpVC : WIBaseViewController

/** 接收扫描的二维码信息 */
@property (nonatomic, copy) NSString *jump_URL;
/** 接收扫描的条形码信息 */
@property (nonatomic, copy) NSString *jump_bar_code;
@property (nonatomic, copy) NSString *payName;
@end
