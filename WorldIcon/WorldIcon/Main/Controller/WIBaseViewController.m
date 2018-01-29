//
//  WIBaseViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIBaseViewController.h"

@interface WIBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WIBaseViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    UIImage *bgImage = [[UIImage imageNamed:@"navbar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    //配置导航栏背景色
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage gc_createImageWithColor:[UIColor gc_colorWithHexString:@"#b64700" alpha:0.5f]]];
    //状态栏文字白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor gc_colorWithHexString:@"#e6e8f3"];
    
//    [self configRightPop];
    
    [self configNavgationItem];
    
    [self configLeftBarButtonItem];

}
#pragma mark -- 配置navgationItem
-(void)configNavgationItem{
    
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont systemFontOfSize:18];
    
    if (self.title) {
        self.navLabel.text = self.title;
    }
    self.navigationItem.titleView = self.navLabel;
}
-(void)configLeftBarButtonItem{
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    
    if (viewcontrollers.count>1) {
    
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"后退箭头"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = left;
    
    }
}
#pragma mark -- 返回事件
- (void)backAction{
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    
    if (viewcontrollers.count>1) {
        
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    }
    
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}

//#pragma mark -- 配置右滑返回
//-(void)configRightPop{
//
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
//    [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
//    pan.delegate = self;
//    [self.navigationController.view addGestureRecognizer:pan];
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//
//}
//#pragma mark - 滑动开始会触发
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    //只有导航的根控制器不需要右滑的返回的功能。
//    return self.navigationController.viewControllers.count <= 1 ? NO : YES;
//}
@end
