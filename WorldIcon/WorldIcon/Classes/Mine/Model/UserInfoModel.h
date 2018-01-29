//
//  UserInfoModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/14.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class UserBaseModel,UserDetailModel;
/*
 {
 result =     {
 code = 10;
 index = "";
 info = "\U8fd4\U56de\U7528\U6237\U4fe1\U606f";
 sid = "";
 };
 "user_base" =     {
 "ub_id" = 513;
 "ub_phone" = 18519191125;
 "ub_rdate" = "2017-11-07 16:52:02";
 "ub_si_id" = 1;
 "ub_tabename" = "user_base";
 };
 "user_detail" =     {
 "ud_address" = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02";
 "ud_amount" = "9,940.00";
 "ud_borth" = "1992-01-01";
 "ud_idcard" = 411522199111255713;
 "ud_md5addr" = b9272797dbaf5f0d5262558b8f6c49f6;
 "ud_name" = "\U9648\U6653";
 "ud_nickname" = "oc_1125";
 "ud_pay" = 0;
 "ud_photo_fileid" = "513_2017_11_07_335eee5d18c5a56c6662ec82425f47a9";
 "ud_sex" = 2;
 "user_type" = 1;
 };
 }

 */
@interface UserInfoModel : JSONModel

@property (nonatomic,copy)ResultModel *result;
@property (nonatomic,copy)UserBaseModel  *user_base;
@property (nonatomic,copy)UserDetailModel *user_detail;

@end
/*
 "user_base": {
 "ub_id": 482,
 "ub_phone": "13501303343",
 "ub_tabename": "user_base",
 "ub_si_id": 1,
 "ub_rdate": "2017-08-17 16:30:12"
 },
 */
@interface UserBaseModel : JSONModel

@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *ub_phone;
@property (nonatomic,copy)NSString *ub_tabename;
@property (nonatomic,copy)NSString *ub_si_id;
@property (nonatomic,copy)NSString *ub_rdate;

@end
/*
 "user_detail": {
 "ud_address" = "\U5317\U4eac\U5e02\U5317\U4eac\U5e02";
 "ud_amount" = "9,940.00";
 "ud_borth" = "1992-01-01";
 "ud_idcard" = 411522199111255713;
 "ud_md5addr" = b9272797dbaf5f0d5262558b8f6c49f6;
 "ud_name" = "\U9648\U6653";
 "ud_nickname" = "oc_1125";
 "ud_pay" = 0;
 "ud_photo_fileid" = "513_2017_11_07_335eee5d18c5a56c6662ec82425f47a9";
 "ud_sex" = 2;
 "user_type" = 1;
 }
 */
@interface UserDetailModel : JSONModel

@property (nonatomic,copy)NSString *ud_nickname;
@property (nonatomic,copy)NSString *ud_photo_fileid;
@property (nonatomic,copy)NSString *ud_amount;
@property (nonatomic,copy)NSString *ud_sex;
@property (nonatomic,copy)NSString *ud_borth;
@property (nonatomic,copy)NSString *ud_address;
@property (nonatomic,copy)NSString *ud_name;
@property (nonatomic,copy)NSString *ud_idcard;
@property (nonatomic,copy)NSString *ud_md5addr;
@property (nonatomic,copy)NSString *user_type;
@property (nonatomic,copy)NSString *ud_pay;

@end
