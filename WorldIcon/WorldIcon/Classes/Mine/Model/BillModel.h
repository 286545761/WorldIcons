//
//  BillModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BillModel : JSONModel
/*
 {
 "co_date" = "2017-09-21 15:55:46";
 "co_dir" = "-1";
 "co_id" = 27;
 "co_info" = "\U652f\U4ed8";
 "co_num" = 1000;
 "co_ub_id" = 493;
 },
 */
@property (nonatomic,copy)NSString *co_date;
@property (nonatomic,copy)NSString *co_dir;
@property (nonatomic,copy)NSString *co_id;
@property (nonatomic,copy)NSString *co_info;
@property (nonatomic,copy)NSString *co_num;
@property (nonatomic,copy)NSString *co_ub_id;

@end
