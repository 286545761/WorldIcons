//
//  ResetRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface ResetRequest : GCBaseRequest

@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,copy)NSString *ud_pwd;
@property (nonatomic,copy)NSString *anew_pwd;

@end
