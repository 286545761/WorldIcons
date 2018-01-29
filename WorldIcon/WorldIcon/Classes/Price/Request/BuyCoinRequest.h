//
//  BuyCoinRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface BuyCoinRequest : GCBaseRequest
@property (nonatomic,strong)NSString *ub_id;
@property (nonatomic,strong)NSString *vb_bc;
@property (nonatomic,strong)NSString *vb_b;
@end
