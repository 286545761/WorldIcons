//
//  RechargeWithdrawRequest.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/1/30.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "RechargeWithdrawRequest.h"

@implementation RechargeWithdrawRequest

-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}

- (NSString *)requestURLPath{
    return @"/index.php/gongx/supreapp";
}

- (NSDictionary *)requestArguments{
    return @{
             @"vra_fee":_vra_fee,
             @"vra_type":_vra_type,
             @"vra_zh_type":_vra_zh_type,
             @"vra_sxf":_vra_sxf,
             @"vra_rmb":_vra_rmb,
             @"uc_id":_uc_id
             };
}

- (GCRequestSerializerType)requestSerializerType{
    return GCRequestSerializerTypeJSON;
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
