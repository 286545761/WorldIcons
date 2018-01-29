//
//  MainTabbarController.h
//  Toon
//
//  Created by dgs on 13-12-16.
//  Copyright (c) 2013年 dgsmac rights reserved.
//
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "TabBarItemButton.h"
//#import "BaseNaviViewController.h"

@interface MainTabbarController : UITabBarController<UINavigationControllerDelegate,UITabBarDelegate>{
}

- (void)setButtonIndex:(NSInteger)index;

@property (nonatomic, assign) BOOL tabbarHidden;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSMutableArray *tabBtnArray;
@property (nonatomic,strong) NSArray *norArr;
@property (nonatomic,strong) NSArray *highlightedArr;
@property (nonatomic, strong) TabBarItemButton *selectedBtn;
@property (nonatomic,strong) NSArray *titleArr;
@end

@interface UITabBarController (custom)
-(void)changeTablar:(NSDictionary *)notify;

- (void)selectButtonAtIndex:(NSInteger)index;
- (void)showTabBar;
- (void)hiddenTabBar;
- (void)hiddenTabBarVertical:(BOOL)flag;
- (void)setFindNewViewSegement:(int)index;
- (void)setNumber:(NSString *)number  withButtonIndex:(NSInteger)index;

- (void)pushActivityViewControl:(NSDictionary *)dict;

- (void)setButtonIndex:(NSInteger)index;

@property(nonatomic,assign)NSInteger come;

@end
