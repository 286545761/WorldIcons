//
//  MainTabbarController.m
//  Toon
//
//  Created by dgs on 13-12-16.
//  Copyright (c) 2013年 dgsmac rights reserved.
//
/**
 *  自定义Tabbar控制器,应用主框架
 *
 */
#import "MainTabbarController.h"
#import "BankCardAddViewController.h"
#import "TabBarItem.h"
#import "ATNavigationController.h"
#import "WIHomeViewController.h"
#import "WIPriceViewController.h"
#import "WIMiningViewController.h"
#import "WIMerchantViewController.h"
#import "WIMineViewController.h"
//两次提示的默认间隔
#define KTAB_BAR_HEIGHT          49
#define KGAP 5
#if DEMO_CALL == 1
//两次提示的默认间隔

@interface MainTabbarController ()
#else
@interface MainTabbarController ()
#endif
{
   
}
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (nonatomic,strong) UIImageView *baseBottomView;
@end

@implementation MainTabbarController

static MainTabbarController* homeTabBarController = nil;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [super viewDidLoad];
    self.tabBtnArray = [NSMutableArray array];

    self.titleArray = @[@"首页",@"行情",@"挖矿",@"商家",@"我的"];
    self.highlightedArr = @[@"home_high",@"market_high",@"mining",@"shopping_high",@"mine_high"];
    self.norArr = @[@"home",@"market",@"mining",@"shopping",@"mine"];
    
//    UIView *contentView;
//    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
//        contentView = [self.view.subviews objectAtIndex:1];
//    else
//        contentView = [self.view.subviews objectAtIndex:0];
//    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBar.frame.size.height);
//    self.tabBar.hidden = YES;
    
    //初始化底部导航条视图
    self.baseBottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight-KTAB_BAR_HEIGHT, kScreenWidth, KTAB_BAR_HEIGHT)];
    self.baseBottomView.tag = 999;
    
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
        if (@available(iOS 11.0, *)) {
            self.baseBottomView.frame = CGRectMake(0, kScreenHeight-KTAB_BAR_HEIGHT-20, kScreenWidth, KTAB_BAR_HEIGHT+20);
        }
    }else{
        self.baseBottomView.frame = CGRectMake(0, kScreenHeight-KTAB_BAR_HEIGHT, kScreenWidth, KTAB_BAR_HEIGHT);
    }
    
    
    //tabbar顶部划线
    CGRect rect = CGRectMake(0, 0, kScreenWidth, .5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor gc_colorWithHexString:@"#d8d8d8"].CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *lineImgv = [[UIImageView alloc] initWithFrame:rect];
    lineImgv.image = image;
    [_baseBottomView addSubview:lineImgv];
    self.baseBottomView.backgroundColor = [UIColor whiteColor];
    _baseBottomView.userInteractionEnabled = YES;
    
    //初始化底部tabbar按钮
    for (int i = 0; i < self.norArr.count; i++) {
        TabBarItem * item = [TabBarItem tabBarItemWithTitle:_titleArray[i] normalImage:_norArr[i] highlightedImage:self.highlightedArr[i]];
        if (i == 2) {
            TabBarItemButton * button = [[TabBarItemButton alloc] initWithFrame:CGRectMake(i * kScreenWidth/_norArr.count, -15, kScreenWidth/_norArr.count, KTAB_BAR_HEIGHT+20) item:item];
            [self.tabBtnArray addObject:button];
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [_baseBottomView addSubview:button];
        }else{
            TabBarItemButton * button = [[TabBarItemButton alloc] initWithFrame:CGRectMake(i * kScreenWidth/_norArr.count, KGAP, kScreenWidth/_norArr.count, KTAB_BAR_HEIGHT) item:item];
            [self.tabBtnArray addObject:button];
            button.tag = 1000 + i;
            [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [_baseBottomView addSubview:button];
        }
    }
//    UIImageView *addBtn = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_plus_normal"]];
//    addBtn.userInteractionEnabled = YES;
//    addBtn.contentMode = UIViewContentModeScaleAspectFit;
//    addBtn.adaptiveIphone5Frame = CGRectMake(320/2-31.5f, -25, 63, 60);
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addBtnAction)];
//    [addBtn addGestureRecognizer:tap];
    
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addBtn.adaptiveIphone5Frame = CGRectMake(320/2-31.5f, -25, 63, 60);
//    [addBtn setImage:[UIImage imageNamed:@"tabbar_plus_normal"] forState:(UIControlStateNormal)];
//    [addBtn setImage:[UIImage imageNamed:@"tabbar_plus_highlight"] forState:(UIControlStateSelected)];
//    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchDown];
//    [_baseBottomView addSubview:addBtn];
    
    [self.view addSubview:_baseBottomView];
    [self initMainViewController];
    [self selectButtonAtIndex:0];
    
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout: UIRectEdgeNone];
    }
}


- (BOOL)prefersStatusBarHidden{
    return NO;
}


#pragma mark - 初始化tabbar控制视图
- (void)initMainViewController
{
    //首页
    WIHomeViewController *homeVC = [[WIHomeViewController alloc]init];
    ATNavigationController * homeNav = [[ATNavigationController alloc] initWithRootViewController:homeVC];
    homeNav.delegate = self;
    
    //行情
    BankCardAddViewController *priceVC = [[BankCardAddViewController alloc]init];
    ATNavigationController * priceNav = [[ATNavigationController alloc] initWithRootViewController:priceVC];
    priceNav.delegate = self;
    
    //挖矿
    WIMiningViewController *miningVC = [[WIMiningViewController alloc]init];
    ATNavigationController * miningNav = [[ATNavigationController alloc] initWithRootViewController:miningVC];
    miningNav.delegate = self;
    
    //商家
    WIMerchantViewController *merchantVC = [[WIMerchantViewController alloc]init];
    ATNavigationController * merchantNav = [[ATNavigationController alloc] initWithRootViewController:merchantVC];
    merchantNav.delegate = self;
    
    //我的
    WIMineViewController *mineVC = [[WIMineViewController alloc]init];
    ATNavigationController * mineNav = [[ATNavigationController alloc] initWithRootViewController:mineVC];
    mineNav.delegate = self;
    self.viewControllers = @[homeNav,priceNav,miningNav,merchantNav,mineNav];
}

- (void)setNumber:(NSString *)number  withButtonIndex:(NSInteger)index;
{
    TabBarItemButton * button = self.tabBtnArray[index];
    [button setNum:number];
}

- (void)setNumberButtonIndex:(NSInteger)index;
{
    TabBarItemButton * button = self.tabBtnArray[index];
    button.pointView.hidden = NO;
}

- (void)setButtonIndex:(NSInteger)index;
{
    TabBarItemButton * button = self.tabBtnArray[index];
    button.pointView.hidden = YES;
}

#pragma mark - 设置tabbar选中index
- (void)selectButtonAtIndex:(NSInteger)index
{
    // 1 将上次选中的RXTabBarItemButton设置为未选中状态
    for (TabBarItemButton *button in self.tabBtnArray) {
        button.selected = NO;
    }
    // 2 将选中的RXTabBarItemButton设置为选中状态
    if (index < self.tabBtnArray.count){
        TabBarItemButton * button = self.tabBtnArray[index];
        button.selected = YES;
        // 3 保存选中的RXTabBarItemButton
        self.selectedBtn = button;
        
        // 4 保存选中index
        self.selectedIndex = index;
    }else{
        //        self.selectedBtn = nil;
    }
}


#pragma mark - tabbarItemButton点击事件
- (void)buttonClickAction:(TabBarItemButton *)clickButton
{
    if (self.selectedBtn == clickButton) {
        return;
    }else{
        [self selectButtonAtIndex:clickButton.tag - 1000];
    }
}


#pragma mark - 显示tabbar
-(void)showTabBar
{
    self.tabBar.hidden = YES;
//    _tabbarHidden = TRUE;
    self.baseBottomView.hidden = NO;
}

#pragma mark - 隐藏tabbar
-(void)hiddenTabBar
{
    self.tabBar.hidden = YES;
//    _tabbarHidden = TRUE;
    self.baseBottomView.hidden = YES;
}

+ (MainTabbarController *)sharedHomeTabBarController
{
    return homeTabBarController;
}

#pragma UINavigationControllerDelegate - Method
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count>1) {
        [self hiddenTabBar];
//        id viewController = navigationController.topViewController;
//        AQKCBaseViewController * controller = nil;
//        if ([viewController isKindOfClass:[AQKCBaseViewController class]]) {
//            controller = viewController;
//            [controller setTabRithBarItem];
//        }
    }else {
        [self showTabBar];
//        [self requsetCartCount];
    }
}



-(BOOL)shouldAutorotate{
//    ATNavigationController *nav = (ATNavigationController *)self.selectedViewController;
//    if ([nav.presentedViewController isKindOfClass:[NSClassFromString(@"DetailViewController") class]]) {
//        DetailViewController * de = (DetailViewController *)nav.presentedViewController;
//        return de.wmPlayer.shouldAutorotat;
//    }
//    if ([nav.topViewController isKindOfClass:[NSClassFromString(@"DetailViewController") class]]) {
//        DetailViewController *de = (DetailViewController *)nav.topViewController;
//        return de.wmPlayer.shouldAutorotat;
//    }
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
