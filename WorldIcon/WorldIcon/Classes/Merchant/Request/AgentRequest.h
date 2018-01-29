//
//  AgentRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface AgentRequest : GCBaseRequest
/*
 sid index ub_id uo_long uo_lat uo_high vm_agent_name vm_type vm_name vm_phone vm_province vm_city vm_district vm_address vm_introduce
 */
@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *vm_agent_name;
@property (nonatomic,copy)NSString *vm_type;
@property (nonatomic,copy)NSString *vm_name;
@property (nonatomic,copy)NSString *vm_phone;
@property (nonatomic,copy)NSString *vm_province;
@property (nonatomic,copy)NSString *vm_city;
@property (nonatomic,copy)NSString *vm_district;
@property (nonatomic,copy)NSString *vm_address;
@property (nonatomic,copy)NSString *vm_introduce;

@end
