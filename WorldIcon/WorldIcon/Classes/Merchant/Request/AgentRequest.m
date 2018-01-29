

//
//  AgentRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "AgentRequest.h"

@implementation AgentRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/agent/agent";
}
- (NSDictionary *)requestArguments{
    
    return @{
             @"ub_id":_ub_id,
             @"vm_agent_name":_vm_agent_name,
             @"vm_type":_vm_type,
             @"vm_name":_vm_name,
             @"vm_phone":_vm_phone,
             @"vm_province":_vm_province,
             @"vm_city":_vm_city,
             @"vm_district":_vm_district,
             @"vm_address":_vm_address,
             @"vm_introduce":_vm_introduce
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
