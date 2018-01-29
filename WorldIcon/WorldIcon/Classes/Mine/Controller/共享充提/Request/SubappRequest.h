//
//  SubappRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/10/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface SubappRequest : GCBaseRequest

@property (nonatomic,strong)NSString *ub_id;
@property (nonatomic,strong)NSString *va_name;
@property (nonatomic,strong)NSString *va_khh;
@property (nonatomic,strong)NSString *va_yhzh;
@property (nonatomic,strong)NSString *va_sf;
@property (nonatomic,strong)NSString *va_cs;

@end
