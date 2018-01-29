//
//  SaveUserInfoRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface SaveUserInfoRequest : GCBaseRequest

@property (nonatomic,copy)NSString *ub_id;

@property (nonatomic,copy)NSDictionary *user_detail;

@end
