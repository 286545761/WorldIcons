//
//  MachinesModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MachinesModel : JSONModel
/*
 {
 "cm_id" = 15;
 "cm_info" = "\U4f20\U52a8\U673a\U6784\U901a\U8fc7\U6db2\U538b\U6cf5\U5c06\U53d1\U52a8\U673a\U7684\U52a8\U529b\U4f20\U9012\U7ed9\U6db2\U538b\U9a6c\U8fbe\U3001\U6db2\U538b\U7f38\U7b49\U6267\U884c\U5143\U4ef6\Uff0c\U63a8\U52a8\U5de5\U4f5c\U88c5\U7f6e\U52a8\U4f5c\Uff0c\U4ece\U800c\U5b8c\U6210\U5404\U79cd\U4f5c\U4e1a\U3002";
 "cm_jk" = 10000;
 "cm_life" = 300;
 "cm_name" = "5G\U6316\U6398";
 "cm_photo_fileid" = 0;
 "cm_status" = 1;
 "cm_tk" = 7500;
 "cm_value" = 5000;
 "cm_yk" = 5000;
 }
 */
@property (nonatomic,copy)NSString *cm_id;
@property (nonatomic,copy)NSString *cm_info;
@property (nonatomic,copy)NSString *cm_life;
@property (nonatomic,copy)NSString *cm_name;
@property (nonatomic,copy)NSString *cm_photo_fileid;
@property (nonatomic,copy)NSString *cm_status;
@property (nonatomic,copy)NSString *cm_value;
@property (nonatomic,copy)NSString *cm_jk;
@property (nonatomic,copy)NSString *cm_tk;
@property (nonatomic,copy)NSString *cm_yk;

@end
