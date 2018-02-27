//
//  CardModel.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/*
 {
 "uc_addr" = "";
 "uc_card" = 6210676802168369354;
 "uc_id" = 37;
 "uc_khh" = "\U5176\U4ed6";
 "uc_name" = "\U9648\U6f47";
 "uc_status" = 1;
 "uc_ub_id" = 493;
 }
 */
@interface CardModel : JSONModel

@property (nonatomic,copy)NSString *uc_id;
@property (nonatomic,copy)NSString *uc_card;
@property (nonatomic,copy)NSString *uc_name;
@property (nonatomic,copy)NSString *uc_khh;
@property (nonatomic,copy)NSString *uc_addr;
@property (nonatomic,copy)NSString *uc_status;
@property (nonatomic,copy)NSString *uc_ub_id;
@property (nonatomic,copy)NSString *uc_type;

@end
