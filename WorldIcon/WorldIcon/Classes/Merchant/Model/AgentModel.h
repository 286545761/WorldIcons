//
//  AgentModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AgentModel : JSONModel
/*
 {
 "agent_id": 1,
 "vm_agent_name": "北京龙创科技有限公司",
 "vm_type": "it",
 "vm_name": "何成斌",
 "vm_phone": "13501303343",
 "vm_province": "北京",
 "vm_city": "北京",
 "vm_district": "昌平区",
 "vm_address": " 回龙观镇西半壁店村",
 "vm_introduce": "龙创信恒(北京)科技有限公司位于北京经济技术开发区,注册资金6000万元,主要从事节能节电、能源管理及节能咨询,是一家集研发、生产、销售、技术服务于一体的高新技术...",
 "vm_img_logo": "http://7xjtzw.com2.z0.glb.qiniucdn.com/o_1blsc2i39pje11eeak513re1bl91i.png",
 "vm_img_url": "http://7xjtzw.com2.z0.glb.qiniucdn.com/o_1blsc2i39pje11eeak513re1bl91i.png",
 "vm_status": 1,
 "vm_date": "2017-08-07 14:11:09",
 "ub_id": 213
 }
 */

@property (nonatomic,copy)NSString *agent_id;
@property (nonatomic,copy)NSString *vm_agent_name;
@property (nonatomic,copy)NSString *vm_type;
@property (nonatomic,copy)NSString *vm_name;
@property (nonatomic,copy)NSString *vm_phone;
@property (nonatomic,copy)NSString *vm_province;
@property (nonatomic,copy)NSString *vm_city;
@property (nonatomic,copy)NSString *vm_district;
@property (nonatomic,copy)NSString *vm_address;
@property (nonatomic,copy)NSString *vm_introduce;
@property (nonatomic,copy)NSString *vm_img_logo;
@property (nonatomic,copy)NSString *vm_img_url;
@property (nonatomic,copy)NSString *vm_status;
@property (nonatomic,copy)NSString *vm_date;
@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *vm_lat;
@property (nonatomic,copy)NSString *vm_long;
@property (nonatomic,copy)NSString *distance;

@end
