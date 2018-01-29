//
//  UserPhotoRequest.m
//  WorldIcon
//
//  Created by 陈潇 on 17/9/15.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "UserPhotoRequest.h"
#import "AFNetworking.h"

@implementation UserPhotoRequest

- (GCRequestMethod)requestMethod{
    return GCRequestMethodPOST;
}

- (NSString *)requestURLPath {
    return @"/index.php/system/upload";
}

- (NSDictionary *)requestArguments {
    return @{

             };
}

- (AFConstructingBodyBlock)constructingBodyBlock {
    
    @weakify(self);
    
    void (^bodyBlock)(id<AFMultipartFormData> formData) = ^(id<AFMultipartFormData> formData) {
        
        @strongify(self);
        
        NSAssert(self.images.count != 0, @"上传内容没有包括图片"); ///< 断言，防止图片数组为空
        
        NSInteger imgIndex = 0;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        
        for (UIImage *img in self.images) {
            
            NSString *fileName = [NSString stringWithFormat:@"%@%@.png", dateString, @(imgIndex)];
            NSData *imgData = UIImageJPEGRepresentation(img, 0.5);

            [formData appendPartWithFileData:imgData name:@"image[]" fileName:fileName mimeType:@"image/jpeg"];
            
            imgIndex++;
        }
        //添加附加参数
        [formData appendPartWithFormData:[[UserManager getUID] dataUsingEncoding:NSUTF8StringEncoding] name:@"ub_id"];
        
//        ///< 注意：两种方式传参 --> 2.通过 body 体传
//        NSString *token = @"51d8ab705465128b27bd5cffa944db81";
//        NSString *uid = @"1160";
        //直接拼接参数 注意 参数 要和服务端的字段一致
//        [formData appendPartWithFormData:[token dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
//        [formData appendPartWithFormData:[uid dataUsingEncoding:NSUTF8StringEncoding] name:@"uid"];
        
        //        if (self.avatar) {
        //            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //            // 设置日期格式
        //            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        //            NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //
        //            [formData appendPartWithFileData:self.avatar name:@"file" fileName:fileName mimeType:@"image/png"];
        //
        //            ///< 注意：两种方式传参 --> 2.通过 body 体传
        //            NSString *token = @"12d2eae5d0ec3b8b3d965f388127ddfd";
        //            NSString *uid = @"1181";
        //            //直接拼接参数 注意 参数 要和服务端的字段一致
        //            [formData appendPartWithFormData:[token dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
        //            [formData appendPartWithFormData:[uid dataUsingEncoding:NSUTF8StringEncoding] name:@"uid"];
        //        }
    };
    
    return bodyBlock;
}

- (void)handleData:(id)data errCode:(NSInteger)errCode {
    
    NSDictionary *dict = (NSDictionary *)data;

    if ([dict[@"result"][@"code"] isEqualToString:@"10"]) {
        if (self.successBlock) {
            self.successBlock(errCode,dict,nil);
        }
    }else{
        GCLog(@"图片fileID为空");
    }
}
@end
