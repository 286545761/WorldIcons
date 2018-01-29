

//
//  MBProgressHUD+GC.m
//  GCMBProgressHUD
//
//  Created by 陈潇 on 17/11/6.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MBProgressHUD+GC.h"

@implementation MBProgressHUD (GC)

+ (void)gc_showSuccessMessage:(NSString *)Message{

    NSString *name =@"MBHUD_Success";
    [self gc_showCustomIconInWindow:name message:Message];
    
}
+ (void)gc_showErrorMessage:(NSString *)Message{

    NSString *name =@"MBHUD_Error";
    [self gc_showCustomIconInWindow:name message:Message];

}
+ (void)gc_showInfoMessage:(NSString *)Message{

    NSString *name =@"MBHUD_Info";
    [self gc_showCustomIconInWindow:name message:Message];
}
+ (void)gc_showWarnMessage:(NSString *)Message{
    
    NSString *name =@"MBHUD_Warn";
    [self gc_showCustomIconInWindow:name message:Message];

}

+(void)gc_showTipMessageInWindow:(NSString *)message{

    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message];
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:0.5];

}

+(void)gc_showActivityMessageInWindow:(NSString *)message{

    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message];
    hud.mode = MBProgressHUDModeIndeterminate;
//    [hud hide:YES afterDelay:0.5];

}

+(void)gc_showCustomIconInWindow:(NSString *)iconName message:(NSString *)message{

    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:YES afterDelay:1.0];

}


+(void)gc_hiddenHUD{

    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    
}

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message
{
    UIView  *view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText=message?message:@"加载中...";
    hud.labelFont=[UIFont systemFontOfSize:15];
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.backgroundColor = [UIColor grayColor];
    hud.alpha = 0.7;
    return hud;
}
#pragma mark -- 获取当前屏幕显示的VC
+(UIViewController *)getCurrentVC{

    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tempWindow in windows) {
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] firstObject];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return  result;
}

@end
