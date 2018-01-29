//
//  LoginRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/14.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface LoginRequest : GCBaseRequest
/*
 sid index ub_phone vc_code ud_pwd uo_long uo_lat uo_high
 */

@property (nonatomic,copy)NSString *ub_phone;
@property (nonatomic,copy)NSString *ud_pwd;


@end
