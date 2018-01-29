//
//  ForgotpwdRequest.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ForgotpwdRequest.h"

@implementation ForgotpwdRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/user/password";
    
}
- (NSDictionary *)requestArguments{
    return @{
             @"ub_phone":_ub_phone,
             @"ud_email":_ud_email,
             @"ud_type":_ud_type,
             @"ud_p1":_ud_p1,
             @"ud_a1":_ud_a1,
             @"ud_p2":_ud_p2,
             @"ud_a2":_ud_a2,
             @"ud_p3":_ud_p3,
             @"ud_a3":_ud_a3,
             };
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    return nil;
}
- (void)handleData:(id)data errCode:(NSInteger)errCode {
    NSDictionary *dict = (NSDictionary *)data;
    if (errCode == 0) {
        ResultModel *resultModel = [[ResultModel alloc] initWithDictionary:dict[@"result"] error:nil];
        ///< 方式1：block 回调
        if (self.successBlock) {
            self.successBlock(errCode, dict, resultModel);
        }
    }else{
        ///< block 回调
        if (self.successBlock) {
            self.successBlock(errCode, dict, nil);
        }
    }
}
@end
