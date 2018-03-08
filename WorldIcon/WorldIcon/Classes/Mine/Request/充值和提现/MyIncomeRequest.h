//
//  MyIncomeRequest.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/28.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface MyIncomeRequest : GCBaseRequest
///用户ID
@property (nonatomic,copy)NSString *ub_id;
///页数
@property (nonatomic,copy)NSString *page;
@end
