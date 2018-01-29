//
//  ValidCodeRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "ValidCodeRequest.h"
#import "ResultModel.h"

@implementation ValidCodeRequest

-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/system/valid";
}
- (NSDictionary *)requestArguments{
    
    return @{
             @"ub_phone":_ub_phone,
             @"vc_code":_vc_code
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
