//
//  cancelOrderppRequest.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/6.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "cancelOrderppRequest.h"

@implementation cancelOrderppRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
//    /gongx/supreapp/cancelOrder
    return @"/gongx/supreapp/cancelOrder";
}
- (NSDictionary *)requestArguments{
    
    return @{
             @"vra_id":_vra_id,
             @"ub_id":_ub_id
   
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
