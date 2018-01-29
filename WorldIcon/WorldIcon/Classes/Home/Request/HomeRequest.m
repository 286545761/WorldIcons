//
//  HomeRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/14.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "HomeRequest.h"

@implementation HomeRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodGET;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/index/index";
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
