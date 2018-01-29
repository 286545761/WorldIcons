//
//  BillRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/19.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface BillRequest : GCBaseRequest

@property (nonatomic,copy)NSString *ub_id;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,copy)NSString *type;

@end
