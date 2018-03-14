//
//  RegisterRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/13.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "RegisterRequest.h"
#import "ResultModel.h"
@implementation RegisterRequest

-(GCRequestMethod)requestMethod{
    return GCRequestMethodGET;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/user/reg";
}
- (NSDictionary *)requestArguments{
    
    return @{
             @"ub_phone":_ub_phone,
             @"ud_pwd":_ud_pwd,
             @"ub_id":_ub_id,
             @"tjr_phone":_tjr_phone,
             @"ud_ol_status":_ud_ol_status
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
