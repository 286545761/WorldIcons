//
//  ForgotpwdRequest.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface ForgotpwdRequest : GCBaseRequest
@property (nonatomic,copy)NSString *ub_phone;
@property (nonatomic,copy)NSString *ud_email;
@property (nonatomic,copy)NSString *ud_type;
@property (nonatomic,copy)NSString *ud_p1;
@property (nonatomic,copy)NSString *ud_a1;
@property (nonatomic,copy)NSString *ud_p2;
@property (nonatomic,copy)NSString *ud_a2;
@property (nonatomic,copy)NSString *ud_p3;
@property (nonatomic,copy)NSString *ud_a3;
@end
