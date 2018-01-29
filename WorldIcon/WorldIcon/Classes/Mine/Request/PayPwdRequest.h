//
//  PayPwdRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface PayPwdRequest : GCBaseRequest

@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *action;
@property (nonatomic,copy)NSString *ud_pay;
@property (nonatomic,copy)NSString *ud_pwd;

@end
