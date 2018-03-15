//
//  WIMineViewController.m
//  WorldIcon
//
//  Created by 陈潇 on 17/7/17.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "WIMineViewController.h"
#import "MineToolView.h"
#import "MineHeaderView.h"
#import "JPUSHService.h"
#import "ApplyGXCTVC.h"
#import "MineUserInfoViewController.h"
#import "MineMineralViewController.h"
#import "MineQrCodeViewController.h"
#import "MineMemberViewController.h"
#import "MineWalletViewController.h"
#import "MineBillViewController.h"
#import "MineBankCardViewController.h"
#import "MineSetPasswordViewController.h"
#import "LoginViewController.h"
#import "QRCodeScanningVC.h"

#import "GXCTViewController.h"
#import "HelpViewController.h"
#import "UserInfoRequest.h"
#import "XLAlertView.h"
#import "GetappRequest.h"
#import "MainTabbarController.h"
#import "inviteFriendView.h"
@interface WIMineViewController ()<MineToolViewDelegate,inviteBtnChooseViewDelegate>

@property (nonatomic,strong)MineHeaderView *headerView;
@property (nonatomic,strong)UserInfoModel  *userInfoModel;
@property (nonatomic,strong)NSDictionary *getappDic;
@property (nonatomic,strong)inviteFriendView *inviteFriend;
@end

@implementation WIMineViewController

-(NSDictionary *)getappDic{
    if (!_getappDic) {
        _getappDic = [NSDictionary dictionary];
    }
    return _getappDic;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [self loadUserInfoToNet];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage gc_createImageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage gc_createImageWithColor:[UIColor clearColor]]];
    //状态栏文字白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navLabel.text = @"我的";
    
    [self setUpMainUI];

    [self setUpRightBarButton];
    
    [self loadUserInfoToNet];
    
}
-(void)setUpMainUI{

    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginback"]];
    backImage.frame = self.view.bounds;
    [self.view addSubview:backImage];
    
    //====================用户信息 ==========================
    MineHeaderView *headerView = [MineHeaderView new];
    if (CGRectGetHeight([UIScreen mainScreen].bounds) == 812.0) {
        if (@available(iOS 11.0, *)) {
            headerView.frame = CGRectMake(0, 64+20, kScreenWidth, 95);
        }
    }else{
        headerView.frame = CGRectMake(0, 64, kScreenWidth, 95);
    }
    
    headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
    [singleTap setNumberOfTapsRequired:1];
    [headerView addGestureRecognizer:singleTap];
    
    //================ 主要内容 =====================
    MineToolView *contentView = [[MineToolView alloc] initWithFrame:CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, kScreenWidth, kScreenHeight-85-49-64)];
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    contentView.delegate = self;
}

#pragma mark -- 右侧退出登录
-(void)setUpRightBarButton{
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:(UIBarButtonItemStyleDone) target:self action:@selector(loginoutAction)];
    btn.tintColor = [UIColor whiteColor];
    [btn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn;
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"帮助" style:(UIBarButtonItemStyleDone) target:self action:@selector(helpAction)];
    leftbtn.tintColor = [UIColor whiteColor];
    [leftbtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftbtn;
}

-(void)helpAction{
    HelpViewController *help = [HelpViewController new];
    help.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:help animated:YES];
}

#pragma mark -- 获取用户详情
-(void)tapGesture{
    MineUserInfoViewController *userInfoVC = [[MineUserInfoViewController alloc]init];
    userInfoVC.hidesBottomBarWhenPushed = YES;
    userInfoVC.model = _userInfoModel;
    userInfoVC.seleteBlock = ^{
        [self loadUserInfoToNet];
    };
    [self.navigationController pushViewController:userInfoVC animated:YES];
//    userInfoVC.hidesBottomBarWhenPushed = NO;

}
#pragma mark -- MineHeaderView delegate方法
-(void)mineToolView:(MineToolView *)toolView didSelectedButton:(NSInteger)tag{

    if (tag == 2000) {//我的钱包
//        NSLog(@"2000我的钱包");
        MineWalletViewController *walletVC = [[MineWalletViewController alloc]init];
        walletVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:walletVC animated:YES];
//        walletVC.hidesBottomBarWhenPushed = NO;

    }
    if (tag == 2001) {//我的矿产
//        NSLog(@"2001我的矿产");
        MineMineralViewController *mineralVC = [[MineMineralViewController alloc]init];
        mineralVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mineralVC animated:YES];
        mineralVC.hidesBottomBarWhenPushed = NO;

    }
    if (tag == 2002) {//我的账单
//        NSLog(@"2002我的账单");
        MineBillViewController *billVC = [[MineBillViewController alloc]init];
        billVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:billVC animated:YES];
        billVC.hidesBottomBarWhenPushed = NO;
    }
    if (tag == 2003) {//密码设置
//        NSLog(@"2003密码设置");
        MineSetPasswordViewController *setpwdVC = [[MineSetPasswordViewController alloc]init];
        setpwdVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setpwdVC animated:YES];
//        setpwdVC.hidesBottomBarWhenPushed = NO;
    }
    if (tag == 2004) {//银行卡
//        NSLog(@"2004银行卡");

        MineBankCardViewController *bankCardVC = [[MineBankCardViewController alloc]init];
        bankCardVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bankCardVC animated:YES];
//        bankCardVC.hidesBottomBarWhenPushed = NO;

    }
    if (tag == 2005) {//我的二维码
//        NSLog(@"2005我的二维码");
        MineQrCodeViewController *qrCodeVC = [[MineQrCodeViewController alloc]init];
        qrCodeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qrCodeVC animated:YES];
        qrCodeVC.hidesBottomBarWhenPushed = NO;
        
    }
    if (tag == 2006) {//支付
//        NSLog(@"2006支付");
        // 1、 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (device) {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusNotDetermined) {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        });
                        SGQRCodeLog(@"当前线程 - - %@", [NSThread currentThread]);
                        // 用户第一次同意了访问相机权限
                        SGQRCodeLog(@"用户第一次同意了访问相机权限");
                    } else {
                        // 用户第一次拒绝了访问相机权限
                        SGQRCodeLog(@"用户第一次拒绝了访问相机权限");
                    }
                }];
            } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
                QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 相机] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                
            } else if (status == AVAuthorizationStatusRestricted) {
                NSLog(@"因为系统原因, 无法访问相册");
            }
        } else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
        }

    }
    if (tag == 2007) {//共享充提

        [self getAppRequest];
       
    }
    if (tag == 2008) {//邀请好友
//        NSLog(@"2008邀请好友");
        UIWindow *Windown = [UIApplication sharedApplication].keyWindow;
        self.inviteFriend = [[inviteFriendView alloc]initWithModel:nil];
        self.inviteFriend.frame = self.view.bounds;
        self.inviteFriend.delegate = self;
        [Windown addSubview:self.inviteFriend];
    }
}

- (void)bottomPassBtnOnClick{
    [self.inviteFriend removeFromSuperview];
}

-(void)loadUserInfoToNet{

    [MBProgressHUD gc_showActivityMessageInWindow:@"加载中..."];

    UserInfoRequest *userInfoReq = [UserInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
            
        }else if ([model.code isEqualToString:@"10"]) {

            [MBProgressHUD gc_hiddenHUD];

            UserInfoModel *m = [[UserInfoModel alloc]initWithDictionary:responseDict error:nil];
            
            // 保存OC地址
            [UserManager setUOC:m.user_detail.ud_md5addr];
            [UserManager setPhone:[NSString stringWithFormat:@"%@",responseDict[@"user_base"][@"ub_phone"]]];
            //保存真实名字
            [UserManager setNickName:m.user_detail.ud_nickname];
            
            self.headerView.userInfoModel = m;
            
            _userInfoModel = m;
            
            if ([m.user_detail.user_type isEqualToString:@"1"]) {//普通用户
                
                [JPUSHService setTags:nil alias:[NSString stringWithFormat:@"%@",_userInfoModel.user_base.ub_id] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    //设置极光别名完成
                    
                }];
            }
            if ([m.user_detail.user_type isEqualToString:@"2"]) {//共享者
                
                NSMutableSet *set1 = [[NSMutableSet alloc] initWithObjects:@"oc_shared",nil];
                
                [JPUSHService setTags:set1 alias:[NSString stringWithFormat:@"%@",_userInfoModel.user_base.ub_id]fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    //设置极光别名完成
                    
                }];
            }
            
        }else if([model.code isEqualToString:@"20"]) {
            
            [MBProgressHUD gc_showErrorMessage:model.info];
            
        }else{
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    
    } failureBlock:^(NSError *error) {
    
        [MBProgressHUD gc_hiddenHUD];

        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    
    userInfoReq.ub_id = [UserManager getUID];
    userInfoReq.ub_phone = @"";
    userInfoReq.type = @"2";
    [userInfoReq startRequest];
    
}

#pragma mark -- 退出登录
-(void)loginoutAction{

    XLAlertView *xlAlertView = [[XLAlertView alloc] initWithMessage:@"您确定要退出当前账户吗?" sureBtn:@"确认" cancleBtn:@"取消"];
    xlAlertView.resultIndex = ^(NSInteger index){
        //回调---处理一系列动作
        if (index == 1) {//取消
         
            
        }
        
        if (index == 2) {//确定
            
            [UserManager setUID:@""];
            
            UINavigationController *loginVC = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
            kAppWindow.rootViewController =loginVC;
        
        }
    };
    
    [xlAlertView showXLAlertView];
}
#pragma mark --- 获取当前用户是否为共享充提者
-(void)getAppRequest{
    
    [MBProgressHUD gc_showActivityMessageInWindow:@"验证中..."];

    GetappRequest *getappReq = [GetappRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, ResultModel *model) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        if ([model.code isEqualToString:@"01"]) {
            
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];

        }else if ([model.code isEqualToString:@"10"]) {
            self.getappDic = responseDict;
            if ([self.getappDic[@"vm_status"] integerValue] != 2) {
                ApplyGXCTVC *Apply = [ApplyGXCTVC new];
                Apply.hidesBottomBarWhenPushed = YES;
                Apply.getappDic = self.getappDic;
                [self.navigationController pushViewController:Apply animated:YES];
            }else{
                GXCTViewController *memberVC = [[GXCTViewController alloc]init];
                memberVC.hidesBottomBarWhenPushed = YES;
                memberVC.getappDic = self.getappDic;
                [self.navigationController pushViewController:memberVC animated:YES];
            }
        }else if([model.code isEqualToString:@"20"]) {
            [MBProgressHUD gc_showErrorMessage:model.info];
        }else{
            [MBProgressHUD gc_showErrorMessage:@"网络繁忙，请稍后再试!"];
        }
    } failureBlock:^(NSError *error) {
        
        [MBProgressHUD gc_hiddenHUD];
        
        [MBProgressHUD gc_showErrorMessage:@"网络错误"];
    }];
    
    getappReq.ub_id = [UserManager getUID];
    
    [getappReq startRequest];
    
}
@end
