//
//  GetCardRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface GetCardRequest : GCBaseRequest
@property (nonatomic,copy)NSString *ub_id;
/**
 *0  全部  1 银行卡 2 微信  3  支付宝 4 BTC
 */
@property(nonatomic,copy)NSString *type;

@end
