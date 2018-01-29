//
//  SupreappRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/11/2.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface SupreappRequest : GCBaseRequest

@property (nonatomic,strong)NSString *ub_id;
@property (nonatomic,strong)NSString *vra_fee;
@property (nonatomic,strong)NSString *uc_id;
@property (nonatomic,strong)NSString *vra_type;
@property (nonatomic,strong)NSString *vra_zh_type;
@end
