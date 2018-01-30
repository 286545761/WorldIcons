//
//  SubappRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface SubappRequest : GCBaseRequest

@property (nonatomic,strong)NSString *ub_id;
@property (nonatomic,strong)NSString *va_name;
@property (nonatomic,strong)NSString *va_khh;
@property (nonatomic,strong)NSString *va_yhzh;
@property (nonatomic,strong)NSString *va_sf;
@property (nonatomic,strong)NSString *va_cs;
/**
 *<##>
 */
@property(nonatomic,copy)NSString *va_card;
/**
 *
 */
@property(nonatomic,copy)NSString *va_weixin;
/**
 *
 */
@property(nonatomic,copy)NSString *va_wx_name;
/**
 *<##>
 */
@property(nonatomic,copy)NSString *va_wx_zh;
@property(nonatomic,copy)NSString *va_zhifubao;
/**
 *
 */
@property(nonatomic,copy)NSString *va_zf_name;
/**
 *<##>
 */
@property(nonatomic,copy)NSString *va_zf_zh;






/**
 *<##>
 */
@property(nonatomic,copy)NSString *type;
/**
 *
 */


@end
