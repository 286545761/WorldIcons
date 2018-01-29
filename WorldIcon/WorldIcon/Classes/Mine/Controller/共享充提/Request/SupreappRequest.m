//
//  SupreappRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/11/2.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "SupreappRequest.h"

@implementation SupreappRequest

-(GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}

- (NSString *)requestURLPath{
    return @"/index.php/gongx/supreapp";
}

- (NSDictionary *)requestArguments{
    /*
     @property (nonatomic,strong)NSString *ub_id;
     @property (nonatomic,strong)NSString *vra_fee;
     @property (nonatomic,strong)NSString *uc_id;
     @property (nonatomic,strong)NSString *vra_type;
     */
    return @{
             @"ub_id":_ub_id,
             @"vra_fee":_vra_fee,
             @"uc_id":_uc_id,
             @"vra_type":_vra_type,
             @"vra_zh_type":_vra_zh_type
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
