//
//  UserManager.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
#pragma mark -- 保存ub_id
+(void)setUID:(NSString *)ub_id;
#pragma mark -- 获取ub_id
+(NSString *)getUID;

#pragma mark -- 保存OC 地址
+(void)setUOC:(NSString *)mdaddr;
#pragma mark -- 获取OC 地址
+(NSString *)getmdaddr;

#pragma mark -- 保存手机号
+(void)setPhone:(NSString *)phone;
#pragma mark -- 获取手机号
+(NSString *)getPhone;

#pragma mark -- 保存真实名字
+(void)setNickName:(NSString *)nickname;
#pragma mark -- 获取真实名字
+(NSString *)getNickName;


@end
