//
//  cancelOrderppRequest.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/6.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface cancelOrderppRequest : GCBaseRequest
@property(nonatomic,copy)NSString * vra_id;
@property(nonatomic,copy)NSString * ub_id;

@end
