
//
//  DeleteRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/25.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "DeleteRequest.h"

@implementation DeleteRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/caiwu/bund";
}
- (NSDictionary *)requestArguments{
    
    return @{
             @"ub_id":_ub_id,
             @"uc_khh":_uc_khh,
             @"uc_name":_uc_name,
             @"uc_addr":_uc_addr,
             @"uc_card":_uc_card,
             @"uc_id":_uc_id,
             @"action":_action
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
