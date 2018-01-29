//
//  MainTabbarViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "WIHomeViewController.h"
#import "WIPriceViewController.h"
#import "WIMiningViewController.h"
#import "WIMerchantViewController.h"
#import "WIMineViewController.h"

@interface MainTabbarViewController ()<UITabBarDelegate>

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //首页
    WIHomeViewController *homeVC = [[WIHomeViewController alloc]init];
    [self gc_addChildControllerB:homeVC title:@"首页" tag:1200 iconNormal:@"home" iconSelected:@"home_high"];
     //行情
    WIPriceViewController *priceVC = [[WIPriceViewController alloc]init];
    [self gc_addChildControllerB:priceVC title:@"行情" tag:1201 iconNormal:@"market" iconSelected:@"market_high"];
    //挖矿
    WIMiningViewController *miningVC = [[WIMiningViewController alloc]init];
    [self gc_addChildControllerB:miningVC title:@"挖矿" tag:1202 iconNormal:@"mining" iconSelected:@"mining"];
    //商家
    WIMerchantViewController *merchantVC = [[WIMerchantViewController alloc]init];
    [self gc_addChildControllerB:merchantVC title:@"商家" tag:1203 iconNormal:@"shopping" iconSelected:@"shopping_high"];
    //我的
    WIMineViewController *mineVC = [[WIMineViewController alloc]init];
    [self gc_addChildControllerB:mineVC title:@"我的" tag:1204 iconNormal:@"mine" iconSelected:@"mine_high"];
    
    /**
     *  默认选择第一个页面
     */
    self.selectedIndex = 0;
    
}
- (void)selectHomePage{
    
    self.selectedIndex = 1;
}

- (void)gc_addChildControllerB:(UIViewController *)viewController title:(NSString *)title tag:(NSInteger)tag iconNormal:(NSString *)iconNormal iconSelected:(NSString *)iconSelected{
    
    UINavigationController *NVC = [[UINavigationController alloc]initWithRootViewController:viewController];
    NVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[self keepPictureColorWithPictureName:iconNormal] selectedImage:[self keepPictureColorWithPictureName:iconSelected]];
    NVC.tabBarItem.tag = tag;
    
    [self gc_setSelectedIndexFontAndColorA:NVC];
    [self gc_setNormalIndexFontAndColorA:NVC];
    
    [self addChildViewController:NVC];
    
}
/**
 *  保持图片原有颜色，停止渲染
 *
 *  @param name 图片名称
 *
 *  @return image
 */
- (UIImage *)keepPictureColorWithPictureName:(NSString *)name{
    
    UIImage *image = [UIImage imageNamed:name];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

/**
 设置tabbar选中字体的样式和颜色 样式A
 
 @param navc navc控制器
 */
- (void)gc_setSelectedIndexFontAndColorA:(UINavigationController *)navc{
    
    [navc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor gc_colorWithHexString:@"#e1ad34"],NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:10]} forState:UIControlStateSelected];
    
}

/**
 设置tabbar默认字体的样式和颜色  样式A
 
 @param navc navc控制器
 */
- (void)gc_setNormalIndexFontAndColorA:(UINavigationController *)navc{
    
    [navc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor gc_colorWithHexString:@"#858a90"],NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:10]} forState:UIControlStateNormal];
}

/**
 选中tabbar触发的方法
 
 @param tabBar 管理tabbar的控制器
 @param item 点击的tabbar
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
 
    if([item.title isEqualToString:@"首页"]){
        
        
    }

    if([item.title isEqualToString:@"行情"]){
        
        
    }

    if([item.title isEqualToString:@"挖矿"]){
        
        
    }

    if([item.title isEqualToString:@"商家"]){
        
        
    }
    if([item.title isEqualToString:@"我的"]){
        
        WIMineViewController *mineVC = [[WIMineViewController alloc]init];
        [mineVC loadUserInfoToNet];
        
    }

    
}
#pragma mark

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    LJLog(@"item name = %@", item.title);
//}
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{//每次点击都会执行的方法
//    
//    if([viewController.tabBarItem.title isEqualToString:@"我的"]){
//        
//        WIMineViewController *mineVC = (WIMineViewController *)viewController;
//        [mineVC loadUserInfoToNet];
//        
//    }
//    if([viewController.tabBarItem.title isEqualToString:@"商家"]){
//        
//        
//        
//    }
//    
//    return YES;
//}

@end
