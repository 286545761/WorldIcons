//
//  DeleteRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface DeleteRequest : GCBaseRequest
@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *uc_khh;
@property (nonatomic,copy)NSString *uc_name;
@property (nonatomic,copy)NSString *action;
@property (nonatomic,copy)NSString *uc_addr;
@property (nonatomic,copy)NSString *uc_card;
@property (nonatomic,copy)NSString *uc_id;

@end
