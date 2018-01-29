//
//  ApplicationViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/6.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ApplicationViewController.h"
#import "BandCardViewController.h"
#import "WexinCardViewController.h"
#import "AlipayCardViewController.h"
@interface ApplicationViewController ()
@end

@implementation ApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLabel.text = @"共享者申请";

    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleHeight = 44;
        *titleScrollViewColor = [UIColor gc_colorWithHexString:@"#e6e8f3"];
        *norColor = [UIColor gc_colorWithHexString:@"#999999"];
        *selColor = [UIColor gc_colorWithHexString:@"#c96705"];
        // 设置标题字体
        *titleFont = [UIFont boldSystemFontOfSize:16];
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, CGFloat *underLineW, UIColor *__autoreleasing *underLineColor) {
        // 是否显示标签
        *isShowUnderLine = NO;
        *underLineW = kScreenWidth/4;
        *underLineH = 3;
        // 标题填充模式
        *underLineColor = [UIColor gc_colorWithHexString:@"#c96705"];
    }];
}

#pragma mark ---- 添加所有子控制器
- (void)setUpAllViewController{
    //银行卡
    BandCardViewController *wordVc2 = [[BandCardViewController alloc] init];
    wordVc2.title = @"银行卡";
    [self addChildViewController:wordVc2];
    
    // 微信
    WexinCardViewController *wordVc1 = [[WexinCardViewController alloc] init];
    wordVc1.title = @"微信";
    [self addChildViewController:wordVc1];
    
    // 支付宝
    AlipayCardViewController *wordVc4 = [[AlipayCardViewController alloc] init];
    wordVc4.title = @"支付宝";
    [self addChildViewController:wordVc4];;
}

@end
