//
//  SendCodeRequest.h
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"

@interface SendCodeRequest : GCBaseRequest
/*
 sid index captcha
 */

//@property (nonatomic,copy)NSString *sid;
//@property (nonatomic,copy)NSString *index;
@property (nonatomic,copy)NSString *captcha;


@end
