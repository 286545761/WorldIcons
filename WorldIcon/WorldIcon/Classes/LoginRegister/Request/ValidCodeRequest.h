//
//  ValidCodeRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface ValidCodeRequest : GCBaseRequest
/*
 sid index vc_code ub_phone
 */

//@property (nonatomic,copy)NSString *sid;
//@property (nonatomic,copy)NSString *index;
@property (nonatomic,copy)NSString *vc_code;
@property (nonatomic,copy)NSString *ub_phone;

@end
