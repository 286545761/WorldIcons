//
//  GXCTModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/30.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/*
 "vra_id": 55,
 "vra_sq_name": "oc_2972",
 "vra_gx_ub_id": 0,
 "vra_fee": 1000,
 "vra_type": 1,
 "vra_date": "2017-10-27 16:06:15",
 "vra_status": 0
 */
@interface GXCTModel : JSONModel

@property (nonatomic,strong)NSString *vra_id;
@property (nonatomic,strong)NSString *vra_sq_name;
@property (nonatomic,strong)NSString *vra_gx_ub_id;
@property (nonatomic,strong)NSString *vra_fee;
@property (nonatomic,strong)NSString *vra_type;
@property (nonatomic,strong)NSString *vra_date;
@property (nonatomic,strong)NSString *vra_status;

@end
@interface VMGongxModel : JSONModel

@property (nonatomic,strong)NSString *vra_date;
@property (nonatomic,strong)NSString *vra_fee;
@property (nonatomic,strong)NSString *vra_type;

@end

@interface ReAppStatus : JSONModel
/*
 "vrs_status": 1,
 "vrs_info": "oc_1125\u5df2\u63a5\u5355",
 "vrs_date": "2017-10-31",
 "vrs_time": "13:31:55",
 "vrs_action": "oc_1125"
 */
@property (nonatomic,strong)NSString *vrs_status;
@property (nonatomic,strong)NSString *vrs_info;
@property (nonatomic,strong)NSString *vrs_date;
@property (nonatomic,strong)NSString *vrs_time;
@property (nonatomic,strong)NSString *vrs_action;

@end

@interface ReApp : JSONModel

/*
 "vm_reapp": [
 {
 "vra_id": 105,
 "vra_sq_name": "oc_1125",
 "vra_gx_ub_id": 509,
 "vra_fee": 0,
 "vra_type": 0,
 "vra_date": "2017-11-02 13:13:38",
 "vra_status": 1
 }
 ]
 */
@property (nonatomic,strong)NSString *vra_id;
@property (nonatomic,strong)NSString *vra_sq_name;
@property (nonatomic,strong)NSString *vra_gx_ub_id;
@property (nonatomic,strong)NSString *vra_fee;
@property (nonatomic,strong)NSString *vra_type;
@property (nonatomic,strong)NSString *vra_date;
@property (nonatomic,strong)NSString *vra_status;

@end

