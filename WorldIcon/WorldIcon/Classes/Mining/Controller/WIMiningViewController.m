//
//  WIMiningViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIMiningViewController.h"
#import "MyMachineViewController.h"
#import "MachineShopViewController.h"

@interface WIMiningViewController ()

@end

@implementation WIMiningViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"挖矿";

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
        *underLineW = kScreenWidth/2;
        *underLineH = 3;
        // 标题填充模式
        *underLineColor = [UIColor gc_colorWithHexString:@"#ff9900"];
    }];
    
}

#pragma mark ---- 添加所有子控制器
- (void)setUpAllViewController
{
    // 矿机商店
    MachineShopViewController *wordVc1 = [[MachineShopViewController alloc] init];
    wordVc1.title = @"矿机商店";
    [self addChildViewController:wordVc1];
    
    // 我的矿机
    MyMachineViewController *wordVc2 = [[MyMachineViewController alloc] init];
    wordVc2.title = @"我的矿机";
    [self addChildViewController:wordVc2];
}

@end
