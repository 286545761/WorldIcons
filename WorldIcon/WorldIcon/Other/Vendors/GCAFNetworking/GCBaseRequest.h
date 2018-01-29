//
//  GCBaseRequest.h
//  GCAFNetworking
//
//  Created by 陈潇 on 17/9/12.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCBaseRequestCallBack.h"

extern NSString * const GCNetworkDomin;//请求网络域名

///< HTTP Request method.
typedef NS_ENUM(NSInteger, GCRequestMethod) {
    GCRequestMethodGET = 0,
    GCRequestMethodPOST
};

///< Request serializer type.
typedef NS_ENUM(NSInteger, GCRequestSerializerType) {
    GCRequestSerializerTypeHTTP = 0,
    GCRequestSerializerTypeJSON
};

///< Response serializer type, which determines response serialization process and
///  the type of `responseObject`.
typedef NS_ENUM(NSInteger, GCResponseSerializerType) {
    GCResponseSerializerTypeHTTP = 0, ///< NSData
    GCResponseSerializerTypeJSON, ///< JSON
    GCResponseSerializerTypeXMLParser ///< NSXMLParser
};

@interface GCBaseRequest : NSObject

@property (nonatomic, assign) BOOL showHUD;

@property (nonatomic, copy) AFConstructingBodyBlock constructingBodyBlock;
@property (nonatomic, copy) AFURLSessionTaskProgressBlock resumableDownloadProgressBlock;
@property (nonatomic, copy) AFURLSessionTaskProgressBlock uploadProgress;

@property (nonatomic, copy) GCRequestSuccessBlock successBlock;
@property (nonatomic, copy) GCRequestFailureBlock failureBlock;
//@property (nonatomic, copy) GCRequestUploadSuccessBlock successUploadBlock;

- (instancetype)initWithSuccessBlock:(GCRequestSuccessBlock)successBlock
                        failureBlock:(GCRequestFailureBlock)failureBlock;
+ (instancetype)requestWithSuccessBlock:(GCRequestSuccessBlock)successBlock
                           failureBlock:(GCRequestFailureBlock)failureBlock;

- (void)startCompletionBlockWithSuccess:(GCRequestSuccessBlock)success
                                failure:(GCRequestFailureBlock)failure;

/**
 带进度的图片上传
 
 @param success 成功回调
 @param failure 失败回调
 @param uploadProgress 进度回调
 */
- (void)startUploadTaskWithSuccess:(GCRequestSuccessBlock)success
                           failure:(GCRequestFailureBlock)failure
                    uploadProgress:(AFURLSessionTaskProgressBlock)uploadProgress;

/**
 * @brief 公共方法，开始请求，不管是使用 block 回调还是 delegate 回调，都要调用此方法
 */
- (void)startRequest;

/**
 * @brief 请求参数，即URL入参
 *
 * @warning 必须重写
 */
- (NSDictionary *)requestArguments;

/**
 * @brief 请求URL路径
 *
 * @warning 必须重写
 */
- (NSString *)requestURLPath;
/**
 * @brief 请求方式 GET or POST
 *
 * @warning 按需重写
 */
- (GCRequestMethod)requestMethod; ///< 默认 GET 请求

/**
 * @brief 请求序列类型
 *
 * @warning 按需重写
 */
- (GCRequestSerializerType)requestSerializerType;

/**
 * @brief 响应序列类型
 *
 * @warning 按需重写
 */
- (GCResponseSerializerType)responseSerializerType;

/**
 * @brief 设置请求头
 *
 * @warning 按需重写
 */
- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary; ///< Additional HTTP request header field. HTTP 请求头配置，按需重写

/**
 * 处理请求返回的数据，字典转模型，利用jsonModel
 *
 * @param data 需要的数据
 * @param resCode 后台返回的错误码（代表各种情况）
 */
- (void)handleData:(id)data errCode:(NSInteger)resCode;

@end
