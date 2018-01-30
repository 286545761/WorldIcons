//
//  GetCardRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/22.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GetCardRequest.h"

@implementation GetCardRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/caiwu/getcard";
}
- (NSDictionary *)requestArguments{
    
 
    if (_type) {
        return @{
                 @"ub_id":_ub_id,
                 @"uc_type":_type
                 };
        
    }
    return @{
             @"ub_id":_ub_id
             
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
