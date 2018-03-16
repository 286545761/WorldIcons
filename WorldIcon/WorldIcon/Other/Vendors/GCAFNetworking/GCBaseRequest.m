//
//  GCBaseRequest.m
//  GCAFNetworking
//
//  Created by 陈潇 on 17/9/12.
//  Copyright © 2017年 Geeks_Chen. All rights reserved.
//

#import "GCBaseRequest.h"
#import "Reachability.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

///< SSL证书名称，仅支持cer格式。本 Demo 没有导入HTTPS证书，如果有需要请导入自己的，HTTPS 证书验证的代码是正确的
#define kCertificateName @"httpsServerAuth"

#ifdef DEBUG //处于开发测试阶段

//NSString * const GCNetworkDomain = @"http://vm.lchtime.com";
NSString * const GCNetworkDomain = @"http://www.onlycoin.vip";

///< 关闭https SSL 验证
#define kOpenHttpsAuth NO

#else //处于发布正式阶段

//NSString * const GCNetworkDomain = @"http://vm.lchtime.com";
NSString * const GCNetworkDomain = @"http://www.onlycoin.vip";

///< 开启https SSL 验证
#define kOpenHttpsAuth YES

#endif

@interface GCBaseRequest ()
{
    NSInteger _page;
    NSString *_timestamp;
    NSTimeInterval _timeoutInterval;
    BOOL _networkIsError;
    AFHTTPSessionManager *_manager;
    NSURLSessionTask *_requestTask;
}
@end

@implementation GCBaseRequest
- (instancetype)init {
    self = [super init];
    if (self) {
        [self gc_initHttpSessionManager];
    }
    return self;
}
- (void)gc_initHttpSessionManager {
    _networkIsError = NO;
    _page = -1;
    _showHUD = NO;
    _timeoutInterval = 10.;
    _manager = [AFHTTPSessionManager manager];
    
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/html",nil];
//    if (kOpenHttpsAuth) {
//        [_manager setSecurityPolicy:[self customSecurityPolicy]];
//    }
}
- (instancetype)initWithSuccessBlock:(GCRequestSuccessBlock)successBlock
                        failureBlock:(GCRequestFailureBlock)failureBlock
{
    if (self = [self init]) {
        self.successBlock = successBlock;
        self.failureBlock = failureBlock;
        self.uploadProgress = nil;
    }
    return self;
    
}
+ (instancetype)requestWithSuccessBlock:(GCRequestSuccessBlock)successBlock failureBlock:(GCRequestFailureBlock)failureBlock {
    return [[[self class] alloc] initWithSuccessBlock:successBlock failureBlock:failureBlock];
}

- (void)startCompletionBlockWithSuccess:(GCRequestSuccessBlock)success failure:(GCRequestFailureBlock)failure {
    self.successBlock = success;
    self.failureBlock = failure;
    self.uploadProgress = nil;
}
- (void)startUploadTaskWithSuccess:(GCRequestSuccessBlock)success
                           failure:(GCRequestFailureBlock)failure
                    uploadProgress:(AFURLSessionTaskProgressBlock)uploadProgress
{
    self.successBlock = success;
    self.failureBlock = failure;
    self.uploadProgress = uploadProgress;
}

- (void)startRequest {
    
    _networkIsError = [[Reachability reachabilityWithHostName:@"www.baidu.com"] currentReachabilityStatus] == NotReachable ? YES : NO;
    if (_networkIsError) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD gc_hiddenHUD];
            [MBProgressHUD gc_showErrorMessage:NSLocalizedString(@"网络连接暂时不可用", @"")];
          
        });
        return;
    }
    
    //拼接请求路径
    [self constructURL];
    
    //AFN 已经很强大了，不用手动拼接 URL 参数，AFN 可以帮你处理好 url 入参
    [self constructSessionTask];
    
    if (self.showHUD) {
        [MBProgressHUD showHUDAddedTo:kAppWindow animated:YES];
    }
}
- (void)constructURL {
    _url = [NSString stringWithFormat:@"%@%@", kHosturl,[self requestURLPath]];
}

- (void)constructSessionTask {
    
    NSError * __autoreleasing requestSerializationError = nil;
    
    _requestTask = [self sessionTaskForError:&requestSerializationError];
    
    [_requestTask resume];
}
#warning 此处可以配置所有请求都需要的共同的参数
- (NSURLSessionTask *)sessionTaskForError:(NSError *__autoreleasing *)error {
    
    GCRequestMethod method = [self requestMethod];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self requestArguments]];
    
    //此处可以配置所有请求都需要的共同的参数，比如 token
//        NSString *token = @"";
//        if (VALID_STRING([OBGlobal global].userInfo.token)) {
//            token = [OBGlobal global].userInfo.token;
//        }
//        [params setObject:token forKey:kRequestToken];
    
    [params setValue:[UserManager getSID] forKey:@"sid"];
    [params setObject:@"" forKey:@"index"];
    [params setValue:@"0" forKey:@"uo_high"];
    [params setValue:@"0" forKey:@"uo_lat"];
    [params setValue:@"0" forKey:@"uo_long"];
    // 检测请求的合法性
    [iConsole info:@"I:请求:%@,参数:%@", _url, params];
    AFConstructingBodyBlock constructingBodyBlock = [self constructingBodyBlock];
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializer];
    
    switch (method) {
        case GCRequestMethodGET: {
            return [self dataTaskWithHTTPMethod:@"GET"
                              requestSerializer:requestSerializer
                                      URLString:_url
                                     parameters:params
                                 uploadProgress:nil
                               downloadProgress:nil
                      constructingBodyWithBlock:nil
                                          error:error];
        } break;
        case GCRequestMethodPOST: {
            return [self dataTaskWithHTTPMethod:@"POST"
                              requestSerializer:requestSerializer
                                      URLString:_url
                                     parameters:params
                                 uploadProgress:self.uploadProgress
                               downloadProgress:nil
                      constructingBodyWithBlock:constructingBodyBlock
                                          error:error];
        } break;
    }
}
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)param
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData>formData))block
                                           error:(NSError * _Nullable __autoreleasing *)error
{
    NSMutableURLRequest *request = nil;

    if (block) {
        request = [requestSerializer multipartFormRequestWithMethod:method URLString:URLString parameters:param constructingBodyWithBlock:block error:error];
    } else {
        request = [requestSerializer requestWithMethod:method URLString:URLString parameters:param error:error];
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [_manager dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        //AFN 返回的数据responseObject已经是字典了，不必再用NSJSONSerialization解析了
        [self handleRequestResult:dataTask response:response responseObject:responseObject error:error];
        if (error == nil) {
            [iConsole info:@"I:成功:%@,响应:%@ ", response.URL, responseObject];
        }
    }];
    
    if ([method isEqualToString:@"GET"]) {
        GCLog(@"GET-->url:%@", dataTask.currentRequest.URL.absoluteString);
    } else {
        GCLog(@"POST-->url:%@", dataTask.currentRequest.URL.absoluteString);
    }
    
    return dataTask;
}
#pragma mark -- 处理请求结果
- (void)handleRequestResult:(NSURLSessionDataTask *)dataTask
                   response:(NSURLResponse *)response
             responseObject:(id)responseObject
                      error:(NSError *)error
{
    ///< 当前处于开发模式、模拟器环境下,才显示 HTTP 返回的状态码,方便调试
#ifdef DEBUG //处于开发阶段
#if TARGET_IPHONE_SIMULATOR
    //iPhone Simulator
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSInteger statusCode = res.statusCode;
    NSString *status_str = [NSHTTPURLResponse localizedStringForStatusCode:res.statusCode];
    
//    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"HTTP状态码:%ld-->状态码描述：%@", statusCode, status_str]];
    
#endif
#endif
    
    if (error) {
        
        NSString *errString = error.localizedFailureReason;
        GCLog(@"+_+_+%@+_+_+%@", error, errString);
        
        if (error.code == -1011) {//请求超时情况的处理
            NSData *data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
            errString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GCLog(@"_+_+%@+_+%@", data, errString);
        }
        
        _showHUD = YES;
        if (self.failureBlock) {
            self.failureBlock(error);
        }
        
        if (_showHUD) {

            [MBProgressHUD gc_showErrorMessage:@"网络连接失败"];
        } else {
            [MBProgressHUD gc_hiddenHUD];
        }
        _showHUD = NO;
    }
    else {
        //分页处理数据
        id json = [self preHandleData:responseObject error:error];
        if (json) {
            if ([json isKindOfClass:[NSString class]]) {
                BOOL showStatus = YES;
                if (showStatus) {//可能是账号在其他设备登陆的
                    [MBProgressHUD gc_showErrorMessage:json];
//                    [SVProgressHUD showErrorWithStatus:json];
                    _showHUD = NO;
                }
            }
            else {
                NSDictionary *jsonDict = (NSDictionary *)json;
                id resultData = [jsonDict objectForKey:@"data"];
                NSInteger errorCode = [[jsonDict objectForKey:@"error"] integerValue];
                GCLog(@"jsonData:%@", jsonDict);
                if (jsonDict) {
                    [self handleData:jsonDict errCode:0];
                } else {
                    GCLog(@"服务器返回数据为null");
                }
            }
        }
        
        if (_showHUD) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD gc_hiddenHUD];
//                [SVProgressHUD dismiss];
            });
            _showHUD = NO;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self clearCompletionBlock];
    });
}
#pragma mark-- 分页处理
- (id)preHandleData:(id)data error:(NSError *)error {
    if (error) {
        return error.localizedFailureReason;
    }
    
    NSDictionary *jsonDict = (NSDictionary *)data;
    NSInteger errorCode = [[jsonDict objectForKey:@"error"] integerValue];
    if (errorCode == 0) {
        NSDictionary *resultData = [jsonDict objectForKey:@"data"];
        if (VALID_DICTIONARY(resultData)) {
            NSInteger page = [[resultData objectForKey:@"page"] integerValue];
            NSInteger total = [[resultData objectForKey:@"total"] integerValue];
            NSInteger rowsperpage = [[resultData objectForKey:@"rowsperpage"] integerValue];
            if (page * rowsperpage < total) {
                _page = page + 1;
                [self startRequest];
            }
        }
        return jsonDict;
    }
    else if (errorCode == 1002) {//参数验证失败
        return jsonDict;
    } else {
        return jsonDict;
    }
}
#pragma mark -- 置空回调Block
- (void)clearCompletionBlock {
    self.successBlock = nil;
    self.failureBlock = nil;
}
#pragma mark -- 请求序列化
- (AFHTTPRequestSerializer *)requestSerializer {
    AFHTTPRequestSerializer *requestSerializer = nil;
    switch ([self requestSerializerType]) {
        case GCRequestSerializerTypeHTTP: {
            requestSerializer = [AFHTTPRequestSerializer serializer];
        } break;
        case GCRequestSerializerTypeJSON: {
            requestSerializer = [AFJSONRequestSerializer serializer];
        } break;
    }
    
    requestSerializer.timeoutInterval = [self requestTimeoutInterval];
    requestSerializer.allowsCellularAccess = [self allowsCellularAccess];
    
    //api needs to add custom value to HTTPHeaderField
    NSDictionary<NSString *, NSString *> *headerFieldValueDict = [self requestHeaderFieldValueDictionary];
    if (headerFieldValueDict != nil) {
        for (NSString *key in headerFieldValueDict.allKeys) {
            NSString *value = headerFieldValueDict[key];
            [requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    
    return requestSerializer;
}
#pragma mark -- 配置请求超时时间
- (NSTimeInterval)requestTimeoutInterval {
    return _timeoutInterval;
}
#pragma mark -- 配置是否允许使用蜂窝网络
- (BOOL)allowsCellularAccess {
    return YES;
}
#pragma mark -- 配置请求头部
- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    return nil;
}
#pragma mark -- 配置默认请求方式
- (GCRequestMethod)requestMethod {
    return GCRequestMethodGET;
}
#pragma mark -- 配置默认序列化方式
- (GCRequestSerializerType)requestSerializerType {
    return GCRequestSerializerTypeHTTP;
}
#pragma mark -- 配置请求参数
- (NSDictionary *)requestArguments {
    NSAssert([self isMemberOfClass:[GCBaseRequest class]], @"子类必须实现requestArguments");
    return nil;
}
#pragma mark -- 配置请求路径
- (NSString *)requestURLPath {
    NSAssert([self isMemberOfClass:[GCBaseRequest class]], @"子类必须实现requestURLPath");
    return nil;
}
#pragma mark -- 请求数据的处理
- (void)handleData:(id)data errCode:(NSInteger)errCode {
    NSAssert([self isMemberOfClass:[GCBaseRequest class]], @"子类必须实现handleData:data errCode:errCode");
}
#pragma mark -- 上传图片需要的配置
- (AFConstructingBodyBlock)constructingBodyBlock {
    return nil;
}




/**
 *  新增的方法，用来验证https证书
 *
 *  @return 证书模式的SecurityPolicy，AFSecurityPolicy有3种安全验证方式
 *          具体看头文件的枚举
 */
- (AFSecurityPolicy *)customSecurityPolicy {
    //先导入证书到项目
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kCertificateName ofType:@"cer" inDirectory:@"HttpsServerAuth.bundle"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    NSLog(@"%@--%@", cerPath, cerData);
    
    //AFSSLPinningModeCertificate使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //GeoTrust Global CA
    //    Google Internet Authority G2
    //        *.google.com
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证，因为整个证书链一一比对是完全没有必要（请查看源代码）；
    //    securityPolicy.validatesCertificateChain = NO;
    
    NSSet *cerDataSet = [NSSet setWithArray:@[cerData]];
    securityPolicy.pinnedCertificates = cerDataSet;
    
    return securityPolicy;
}
-(NSString*)ObjectTojsonString:(id)object
{
    NSString *jsonString = [[NSString alloc]init];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted                                                         error:&error];
    
    if (!jsonData) {
        
        NSLog(@"error: %@", error);
        
    } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
