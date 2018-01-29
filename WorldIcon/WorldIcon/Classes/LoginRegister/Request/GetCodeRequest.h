//
//  GetCodeRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface GetCodeRequest : GCBaseRequest
/*
 sid index ub_phone
 */
@property (nonatomic,copy)NSString *ub_phone;

@end
