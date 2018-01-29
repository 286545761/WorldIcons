//
//  BankCardAddViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BankCardAddViewController.h"
#import "BindAliViewController.h"
#import "BindWechatViewController.h"
#import "BindBankCardViewController.h"
#import "BindBTCViewController.h"
#import "EntrustViewController.h"
#import "HistoryViewController.h"
@interface BankCardAddViewController ()



@end

@implementation BankCardAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navLabel.text = @"行情";
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleHeight = 44;
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = [UIColor gc_colorWithHexString:@"#666666"];
        *selColor = [UIColor gc_colorWithHexString:@"#c96705"];
        // 设置标题字体
        *titleFont = [UIFont boldSystemFontOfSize:15];
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, CGFloat *underLineW, UIColor *__autoreleasing *underLineColor) {
        // 是否显示标签
        *isShowUnderLine = YES;
        *underLineW = kScreenWidth/5;
        *underLineH = 3;
        // 标题填充模式
        *underLineColor = [UIColor gc_colorWithHexString:@"#c96705"];
    }];

  
}
-(void)setUpAllViewController{

    // 行情
    BindAliViewController *vc1 = [[BindAliViewController alloc] init];
    vc1.title = @"行情";
    [self addChildViewController:vc1];
    
    // 委托
    BindWechatViewController *vc2 = [[BindWechatViewController alloc] init];
    vc2.title = @"委托";
    [self addChildViewController:vc2];
    
    // k线
    BindBankCardViewController *vc3 = [[BindBankCardViewController alloc] init];
    vc3.title = @"k线";
    [self addChildViewController:vc3];

    // 日线
    BindBTCViewController *vc4 = [[BindBTCViewController alloc] init];
    vc4.title = @"日线";
    [self addChildViewController:vc4];
    
    // 记录
    HistoryViewController *vc5 = [HistoryViewController new];
    vc5.title = @"记录";
    [self addChildViewController:vc5];
    
}

@end
