//
//  SupreappNodeRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface SupreappNodeRequest : GCBaseRequest

@property (nonatomic,strong)NSString *vra_id;
@property (nonatomic,strong)NSString *ub_id;
@property (nonatomic,strong)NSString *vrs_status;
@property (nonatomic,strong)NSString *vrs_pic;
@property (nonatomic,strong)NSString *vrs_info;


@end
