//
//  ShareStateModel.h
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ShareStateModel : JSONModel
///充值订单(0-待接单 1-接单处理 2-处理成功 3-处理失败)
@property (nonatomic,copy)NSString<Optional> *vra_status;
///汇率
@property (nonatomic,copy)NSString<Optional> *vra_ratio;
///手续费
@property (nonatomic,copy)NSString<Optional> *vra_sxf;
///共享订单号
@property (nonatomic,copy)NSString<Optional> *vra_id;
@property (nonatomic,copy)NSString<Optional> *vra_order_status;
@end
