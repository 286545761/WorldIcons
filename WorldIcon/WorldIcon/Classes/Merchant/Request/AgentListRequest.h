//
//  AgentListRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface AgentListRequest : GCBaseRequest
/*
 sid index ub_id uo_long uo_lat uo_high page vm_type vm_province vm_city vm_agent_name
 */
@property (nonatomic,copy)NSString    *ub_id;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,copy)NSString    *vm_type;
@property (nonatomic,copy)NSString    *vm_province;
@property (nonatomic,copy)NSString    *vm_city;
@property (nonatomic,copy)NSString    *vm_agent_name;

@end
