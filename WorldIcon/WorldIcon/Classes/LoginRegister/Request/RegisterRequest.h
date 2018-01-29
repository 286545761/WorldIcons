//
//  RegisterRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface RegisterRequest : GCBaseRequest
/*
 sid index ub_phone ud_pwd vc_code ud_ol_status ub_id ud_nickname
 */
//@property (nonatomic,copy)NSString *sid;
//@property (nonatomic,copy)NSString *index;
@property (nonatomic,copy)NSString *ub_phone;
@property (nonatomic,copy)NSString *ud_pwd;
@property (nonatomic,copy)NSString *vc_code;
@property (nonatomic,copy)NSString *ud_ol_status;
@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *ud_nickname;

@end
