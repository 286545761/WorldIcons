//
//  SubappRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/10/28.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "SubappRequest.h"
//申请成为共享充提者
@implementation SubappRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}
- (NSString *)requestURLPath{
    
    return @"/index.php/gongx/subapp";
}
- (NSDictionary *)requestArguments{
    
    return @{

                @"type":_type,
                @"ub_id":_ub_id,
                @"vm_application":@{
                
                    @"va_weixin":_va_weixin,
                    @"va_wx_zh":_va_weixin,
                    @"va_zhifubao":_va_zhifubao,
                    @"va_zf_zh":_va_zf_zh,
                    @"va_name":_va_name,
                    @"va_khh":_va_khh,
                    @"va_card":_va_card,
                     @"va_yhzh":_va_yhzh,
                     @"va_sf":_va_sf,
                     @"va_cs":_va_cs,
                    @"va_wx_name":_va_wx_name,
                    @"va_zf_name":_va_zf_name
                    }
             
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
