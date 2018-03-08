//
//  UserManager.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
#pragma mark -- 保存ub_id
+(void)setUID:(NSString *)ub_id{
    if (ub_id) {
        
        [UserDefaults setValue:ub_id forKey:USERID];
        
        [UserDefaults synchronize];
    }
}

#pragma mark -- 获取ub_id
+(NSString *)getUID{
    return  [UserDefaults valueForKey:USERID];
}

#pragma mark -- 保存sid
+(void)setSID:(NSString *)sid{
    if (sid) {
        [UserDefaults setValue:sid forKey:USESID];
        [UserDefaults synchronize];
    }
}

#pragma mark -- 获取sid
+(NSString *)getSID{
    return  [UserDefaults valueForKey:USESID];
}

#pragma mark -- 保存OC 地址
+(void)setUOC:(NSString *)mdaddr{
    if (mdaddr) {
        
        [UserDefaults setValue:mdaddr forKey:USEROC];
        
        [UserDefaults synchronize];
    }
}
#pragma mark -- 获取OC 地址
+(NSString *)getmdaddr{
    return  [UserDefaults valueForKey:USEROC];
}

#pragma mark -- 保存手机号
+(void)setPhone:(NSString *)phone{
    if (phone) {
        
        [UserDefaults setValue:phone forKey:USERPHONE];
        
        [UserDefaults synchronize];
    }
}
#pragma mark -- 获取手机号
+(NSString *)getPhone{
    return  [UserDefaults valueForKey:USERPHONE];
}

#pragma mark -- 保存真实名字
+(void)setNickName:(NSString *)nickname{
    if (nickname) {
        
        [UserDefaults setValue:nickname forKey:USERNAME];
        
        [UserDefaults synchronize];
    }

}
#pragma mark -- 获取真实名字
+(NSString *)getNickName{
    return  [UserDefaults valueForKey:USERNAME];

}
@end
