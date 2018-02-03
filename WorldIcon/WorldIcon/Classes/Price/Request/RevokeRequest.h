//
//  RevokeRequest.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/2.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface RevokeRequest : GCBaseRequest
@property (nonatomic,strong)NSString *ub_id;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *vsb_id;
@end
