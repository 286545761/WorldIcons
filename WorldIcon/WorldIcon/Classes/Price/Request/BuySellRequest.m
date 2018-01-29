//
//  BuySellRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "BuySellRequest.h"

@implementation BuySellRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/market/buysell";
}
- (NSDictionary *)requestArguments{
    
    return @{
             @"ub_id":_ub_id,
             @"page":_page,
             @"type":_type
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
