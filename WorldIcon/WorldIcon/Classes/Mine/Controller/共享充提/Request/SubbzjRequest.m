//
//  SubbzjRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "SubbzjRequest.h"
//提交保证金
@implementation SubbzjRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/gongx/supbzj";
}
- (NSDictionary *)requestArguments{
    
    return @{
             @"ub_id":_ub_id,
             @"vb_bzj":_vb_bzj,
             @"type":_type
//             @"vb_pic":_vb_pic,
//             @"vb_info":_vb_info
             
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
