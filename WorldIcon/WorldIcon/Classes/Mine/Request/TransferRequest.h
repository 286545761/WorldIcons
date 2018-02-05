//
//  TransferRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface TransferRequest : GCBaseRequest
@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *ub_pay;
@property (nonatomic,copy)NSString *fee;
@property (nonatomic,copy)NSString *ub_id1;

@end
