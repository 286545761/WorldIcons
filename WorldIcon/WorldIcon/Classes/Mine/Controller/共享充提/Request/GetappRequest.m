//
//  GetappRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GetappRequest.h"
//获取共享充提者基本信息
@implementation GetappRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodGET;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/gongx/getapp";
}
- (NSDictionary *)requestArguments{
    
    return @{
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
