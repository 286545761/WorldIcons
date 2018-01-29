//
//  GCBaseRequestCallBack.h
//  GCAFNetworking
//
//  Created by 陈潇 on 17/9/12.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCBaseRequest;

@protocol AFMultipartFormData;

typedef void(^AFConstructingBodyBlock)(id<AFMultipartFormData> data);
typedef void(^AFURLSessionTaskProgressBlock)(NSProgress *progress);

/*!
 *   AFN 请求封装的Block回调
 */
typedef void(^GCRequestSuccessBlock)(NSInteger errCode, NSDictionary *responseDict, ResultModel *model);
typedef void(^GCRequestUploadSuccessBlock)(NSInteger errCode, NSDictionary *responseDict, NSDictionary *dic);
typedef void(^GCRequestFailureBlock)(NSError *error);
