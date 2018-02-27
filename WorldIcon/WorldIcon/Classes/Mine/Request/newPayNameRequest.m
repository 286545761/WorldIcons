//
//  newPayNameRequest.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/8.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "newPayNameRequest.h"

@implementation newPayNameRequest
- (NSString *)requestURLPath{
    
    return @"/index.php/user/view";
}
- (NSDictionary *)requestArguments{
    
    return @{
     
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
