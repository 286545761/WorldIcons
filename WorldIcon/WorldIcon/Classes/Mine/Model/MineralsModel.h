//
//  MineralsModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MineralsModel : JSONModel
/*
 "vm_func": {
 "vf_ub_id": 482,
 "vf_coin": 2124,
 "vf_jk": 1000,
 "vf_yk": 1000,
 "vf_tk": 1000
 }
 */

@property (nonatomic,copy)NSString *vf_ub_id;
@property (nonatomic,copy)NSString *vf_coin;
@property (nonatomic,copy)NSString *vf_jk;
@property (nonatomic,copy)NSString *vf_yk;
@property (nonatomic,copy)NSString *vf_tk;
//@property (nonatomic,copy)NSString *vf_k;

@end
