//
//  MBProgressHUD+GC.h
//  GCMBProgressHUD
//
//  Created by 陈潇 on 17/11/6.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (GC)

+ (void)gc_showSuccessMessage:(NSString *)Message;
+ (void)gc_showErrorMessage:(NSString *)Message;
+ (void)gc_showInfoMessage:(NSString *)Message;
+ (void)gc_showWarnMessage:(NSString *)Message;

+(void)gc_showTipMessageInWindow:(NSString *)message;
+(void)gc_showActivityMessageInWindow:(NSString *)message;
+(void)gc_showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;

+(void)gc_hiddenHUD;


@end
