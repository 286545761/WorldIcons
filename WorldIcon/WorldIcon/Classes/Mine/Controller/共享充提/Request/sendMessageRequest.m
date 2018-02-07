//
//  sendMessageRequest.m
//  WorldIcon
//
//  Created by 韩铭文 on 2018/2/6.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "sendMessageRequest.h"

@implementation sendMessageRequest
-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}

- (NSString *)requestURLPath{
    return @"/index.php/gongx/supreapp/addLeaveMessage";
}

- (NSDictionary *)requestArguments{

//    @property (nonatomic,strong)NSString *ub_id;
//    @property (nonatomic,strong)NSString *vra_id;
//    @property (nonatomic,strong)NSString *vc_context;
//    @property (nonatomic,strong)NSArray *vc_pic;
    return @{
             @"ub_id":_ub_id,
             @"vra_id":_vra_id,
             @"vc_context":_vc_context,
             @"vc_pic":@""
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
