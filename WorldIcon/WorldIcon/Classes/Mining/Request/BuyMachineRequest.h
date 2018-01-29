//
//  BuyMachineRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface BuyMachineRequest : GCBaseRequest

@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *cm_id;
@property (nonatomic,copy)NSString *cm_value;
@property (nonatomic,copy)NSString *ud_pay;

@end
