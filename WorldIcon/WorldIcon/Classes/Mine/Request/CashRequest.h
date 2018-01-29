//
//  CashRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface CashRequest : GCBaseRequest

@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *ut_card;
@property (nonatomic,copy)NSString *ut_mount;
@property (nonatomic,copy)NSString *ud_pay;
@property (nonatomic,copy)NSString *ut_name;
@property (nonatomic,copy)NSString *ut_khh;

@end
