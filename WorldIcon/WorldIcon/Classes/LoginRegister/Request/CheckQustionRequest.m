//
//  CheckQustionRequest.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2017/12/26.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "CheckQustionRequest.h"

@implementation CheckQustionRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/user/check";
    
}
- (NSDictionary *)requestArguments{
    return @{
             @"ub_phone":_ub_phone,
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
