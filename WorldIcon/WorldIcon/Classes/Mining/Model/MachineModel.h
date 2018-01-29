//
//  MachineModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/18.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MachineModel : JSONModel
/*
 {
 "mm_id": 9,
 "mm_ub_id": 482,
 "mm_cm_name": "挖掘机",
 "mm_cm_info": "学挖掘机到蓝翔",
 "mm_cm_value": "0.80",
 "mm_cm_jk": 123,
 "mm_cm_yk": 123,
 "mm_cm_tk": 123,
 "mm_cm_life": 213,
 "mm_date": 2017,
 "mm_status": 1,
 "mm_cm_jk1": null,
 "mm_cm_yk1": null,
 "mm_cm_tk1": null,
 "mm_cm_photo_fileid": "483_2017_08_25_f8b98f641fba4b5afbd8f4516dcabada"
 }
 */

@property (nonatomic,copy)NSString *mm_id;
@property (nonatomic,copy)NSString *mm_ub_id;
@property (nonatomic,copy)NSString *mm_cm_name;
@property (nonatomic,copy)NSString *mm_cm_info;
@property (nonatomic,copy)NSString *mm_cm_value;
@property (nonatomic,copy)NSString *mm_cm_jk;
@property (nonatomic,copy)NSString *mm_cm_yk;
@property (nonatomic,copy)NSString *mm_cm_tk;
@property (nonatomic,copy)NSString *mm_cm_life;
@property (nonatomic,copy)NSString *mm_date;
@property (nonatomic,copy)NSString *mm_status;
@property (nonatomic,copy)NSString *mm_cm_jk1;
@property (nonatomic,copy)NSString *mm_cm_yk1;
@property (nonatomic,copy)NSString *mm_cm_tk1;
@property (nonatomic,copy)NSString *mm_cm_photo_fileid;

@end
