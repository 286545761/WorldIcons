//
//  GXCTViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/23.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GXCTViewController.h"
#import "ApplicatView.h"
#import "SendMsgView.h"
#import "WaitView.h"
#import "RechargeRecordViewController.h"
#import "BaseInfoViewController.h"
#import "LobbyViewController.h"
#import "MyOrderViewController.h"
#import "CTRecordViewController.h"
#import "newBaseInfoViewController.h"

#import "ApplicationViewController.h"

@interface GXCTViewController ()

@end

@implementation GXCTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"共享充提";
    
    switch ([self.getappDic[@"vm_status"] integerValue]) {
        case 0://申请
            break;
        case 1://等待审核
            break;
        case 2://成为共享充提者
             [self test3];
            break;
            
        default:
            break;
    }
}

-(void)test3{
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleHeight = 44;
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = [UIColor gc_colorWithHexString:@"#666666"];
        *selColor = [UIColor gc_colorWithHexString:@"#ff9900"];
        // 设置标题字体
        *titleFont = [UIFont systemFontOfSize:15];
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, CGFloat *underLineW, UIColor *__autoreleasing *underLineColor) {
        // 是否显示标签
        *isShowUnderLine = YES;
        *underLineW = kScreenWidth/4;
        *underLineH = 3;
        // 标题填充模式
        *underLineColor = [UIColor gc_colorWithHexString:@"#ff9900"];
    }];

}
#pragma mark ---- 添加所有子控制器
- (void)setUpAllViewController
{
//    基本信息
   newBaseInfoViewController *wordVc2 = [[newBaseInfoViewController alloc] init];
    wordVc2.title = @"基本信息";
    [self addChildViewController:wordVc2];
//  BaseInfoViewController *wordVc2 = [[ BaseInfoViewController alloc] init];
//    wordVc2.title = @"基本信息";
//    [self addChildViewController:wordVc2];
    
    // 接单大厅
    LobbyViewController *wordVc1 = [[LobbyViewController alloc] init];
    wordVc1.title = @"接单大厅";
    [self addChildViewController:wordVc1];
    // 我的接单
    MyOrderViewController *wordVc4 = [[MyOrderViewController alloc] init];
    wordVc4.title = @"我的接单";
    [self addChildViewController:wordVc4];
    // 充值记录
    CTRecordViewController *wordVc3 = [[CTRecordViewController alloc] init];
    wordVc3.title = @"充提记录";
    [self addChildViewController:wordVc3];
    
}
@end
