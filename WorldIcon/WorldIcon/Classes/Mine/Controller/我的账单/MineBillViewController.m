//
//  MineBillViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MineBillViewController.h"

#import "OulibiViewController.h"
#import "MeiyuanViewController.h"

@interface MineBillViewController ()

@end

@implementation MineBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navLabel.text = @"我的账单";

    [self setUpAllViewController];
    
    self.titleMargin = 0;
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleHeight = 44;
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = [UIColor gc_colorWithHexString:@"#333333"];
        *selColor = kTitleColor;
        // 设置标题字体
        *titleFont = [UIFont systemFontOfSize:17];
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, CGFloat *underLineW, UIColor *__autoreleasing *underLineColor) {
        // 是否显示标签
        *isShowUnderLine = YES;
        *underLineW = kScreenWidth/2;
        *underLineH = 3;
        // 标题填充模式
        *underLineColor = kTitleColor;
    }];

}
#pragma mark ---- 添加所有子控制器
- (void)setUpAllViewController
{
 
    OulibiViewController *wordVc2 = [[OulibiViewController alloc] init];
    wordVc2.title = @"欧力币";
    [self addChildViewController:wordVc2];
    //朋友
    MeiyuanViewController *wordVc = [[MeiyuanViewController alloc] init];
    wordVc.title = @"美元";
    [self addChildViewController:wordVc];
    
}

@end
