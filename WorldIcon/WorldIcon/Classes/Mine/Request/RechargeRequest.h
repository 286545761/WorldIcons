//
//  RechargeRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface RechargeRequest : GCBaseRequest

@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *uc_cz_date;//日期
@property (nonatomic,copy)NSString *uc_khh;//开户行
@property (nonatomic,copy)NSString *uc_name;//
@property (nonatomic,copy)NSString *uc_mount;//金额
@property (nonatomic,copy)NSString *uc_card;//卡号

@end
