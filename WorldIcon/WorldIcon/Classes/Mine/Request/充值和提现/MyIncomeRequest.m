//
//  MyIncomeRequest.m
//  WorldIcon
//
//  Created by 郭飞燕 on 2018/2/28.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "MyIncomeRequest.h"

@implementation MyIncomeRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}

- (NSString *)requestURLPath{
    return @"/index.php/user/Income";
}

- (NSDictionary *)requestArguments{
    return @{
             @"ub_id":_ub_id,
             @"page":_page
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
