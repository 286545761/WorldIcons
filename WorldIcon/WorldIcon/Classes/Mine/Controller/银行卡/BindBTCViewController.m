//
//  BindBTCViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/9.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BindBTCViewController.h"
#import "InputView.h"

@interface BindBTCViewController ()

@property (nonatomic,strong)InputView *khhLabel;
@property (nonatomic,strong)InputView *hyflLabel;

@end

@implementation BindBTCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setUpCustomView];
    
}
-(void)setUpCustomView{
    
    //商家名称
    InputView *khhLabel = [[InputView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 35) withTitle:@"BTC地址" withPlaceholder:@"请输入BTC地址"];
    khhLabel.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:khhLabel];
    self.khhLabel = khhLabel;
    //卡号
//    InputView *hyflLabel = [[InputView alloc]initWithFrame:CGRectMake(10, 65, kScreenWidth-20, 35) withTitle:@"BTC地址" withPlaceholder:@"请输入BTC地址"];
//    hyflLabel.titleLabel.textAlignment = NSTextAlignmentRight;
//    [self.view addSubview:hyflLabel];
//    self.hyflLabel = hyflLabel;
    
    UIButton *addAliBtn = [UIButton gc_initButtonWithBackgroundColor:[UIColor gc_colorWithHexString:@"#ff9900"] withTitle:@"提交" withRadius:(35.5*0.5)];
    addAliBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addAliBtn addTarget:self action:@selector(addAliAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAliBtn];
    
    [addAliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kRatioX6(25));
        make.right.mas_equalTo(self.view).offset(-kRatioX6(25));
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.khhLabel.mas_bottom).offset(kRatioY6(40));
    }];
    
}

@end
