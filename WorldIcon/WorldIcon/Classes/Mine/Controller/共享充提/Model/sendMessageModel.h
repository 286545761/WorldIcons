//
//  sendMessageModel.h
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/6.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface sendMessageModel :JSONModel
@property(nonatomic,copy)NSString *vc_date;
@property(nonatomic,copy)NSString *ud_nickname;
@property(nonatomic,copy)NSString *vc_context;
@property(nonatomic,assign)NSString *vc_vra_id;
@property(nonatomic,assign)NSString *vc_id;
@property(nonatomic,assign)NSString *vc_ub_id;
@property(nonatomic,assign)NSString<Optional> *leftOrRight;
@end
