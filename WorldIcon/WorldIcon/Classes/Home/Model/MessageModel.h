//
//  MessageModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/21.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageModel : JSONModel
/*
 info = 2;
 "order_status" = 1;
 status = 1;
 type = 2;
 "ub_id" = 510;
 "vm_date" = "2017-11-06 12:51:32";
 "vm_info_content" = "Geeks_Chen\U786e\U8ba4\U6536\U6b3e";
 "vm_info_title" = "\U6b27\U529b\U5e01\U6d88\U606f\U63d0\U793a";
 "vra_id" = 145;

 */

@property (nonatomic,copy)NSString *info;
@property (nonatomic,copy)NSString *order_status;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *vra_id;
@property (nonatomic,copy)NSString *vm_date;
@property (nonatomic,copy)NSString *vm_info_content;
@property (nonatomic,copy)NSString *vm_info_title;

@end
