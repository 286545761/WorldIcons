//
//  RechargeWithdrawRequest.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface RechargeWithdrawRequest : GCBaseRequest
///充提金额单位是美元
@property (nonatomic,copy)NSString *vra_fee;
///充提的类型 0 充值  1 提现
@property (nonatomic,copy)NSString *vra_type;
///0 银行卡 1 微信 2 支付宝 3 BTC
@property (nonatomic,copy)NSString *vra_zh_type;
///手续费
@property (nonatomic,copy)NSString *vra_sxf;
///人民币
@property (nonatomic,copy)NSString *vra_rmb;
///银行卡ID
@property (nonatomic,copy)NSString *uc_id;
@end
