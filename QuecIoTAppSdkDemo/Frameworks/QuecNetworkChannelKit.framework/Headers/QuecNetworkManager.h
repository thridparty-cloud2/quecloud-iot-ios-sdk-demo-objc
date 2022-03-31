//
//  QuecNetworkManager.h
//  QuecNetworkChannelKit
//
//  Created by quectel.steven on 2021/8/17.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, QuecNetworkRequestType) {
    QuecNetworkRequestTypeGET,
    QuecNetworkRequestTypePOST,
    QuecNetworkRequestTypePUT,
    QuecNetworkRequestTypeDELETE,
    QuecNetworkRequestTypeHEAD,
    QuecNetworkRequestTypePATCH
};

@protocol QuecNetworkInterceptProtocol <NSObject>

@required
- (NSInteger)interceptCode;
- (NSArray *)excludeUrls;
- (void)notifInterceptedWithCompletion:(void(^)(BOOL needResume))completion;

@end

@interface QuecNetworkManager : NSObject

// 超时时间，默认是30s
@property (nonatomic, assign) NSInteger timeoutInterval;

// 默认基础url
@property (nonatomic, copy) NSString *baseUrl;

// http header 只读，add请使用setHttpHeaderWithValue:key:
@property (readonly, nonatomic, copy) NSDictionary *httpHeaderFields;

// 接口请求成功code，默认是200
@property (nonatomic, assign) NSInteger successCodeIdentifier;

/**
 @return return a single instance
 */
+ (instancetype)sharedInstance;

/**
 @return networkEnable
 */
+ (BOOL)networkEnable;

/**
 set http header
 
 @param value http header value,如"application/json".
 @param key http header key,如"Content-Type".
 */
- (void)setHttpHeaderWithValue:(NSString *)value key:(NSString *)key;

/**
 start a request
 
 @param urlString request url.
 @param params 参数.
 @param requestType GET POST
 @param success success block
 @param failure failure block
 
 @return a NSURLSessionTask object
 */
- (NSURLSessionTask *)requestWithUrlString:(NSString *)urlString params:(NSDictionary *)params requestType:(QuecNetworkRequestType)requestType success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

/**
 start a request
 
 @param urlString request url.
 @param params 参数.
 @param headers http headers.
 @param httpBodyData 放入httpBody 中的data
 @param requestType GET POST
 @param success success block
 @param failure failure block
 
 @return a NSURLSessionTask object
 */
- (NSURLSessionTask *)requestWithUrlString:(NSString *)urlString                                                   params:(NSDictionary *)params
                                   headers:(NSDictionary *)headers
                              httpBodyData:(NSData *)httpBodyData
                               requestType:(QuecNetworkRequestType)requestType
                                   success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;


/**
 start a  upload request
 
 @param urlString request url.
 @param params 参数.
 @param data upload data
 @param name 和 data 关联的文件名称
 @param fileName 和 data 关联的文件名称
 @param mimeType data 类型，如 multipart/form-data，image/jpeg
 @param success success block
 @param failure failure block
 
 @return a NSURLSessionTask object
 */
- (NSURLSessionTask *)requestUploadDataWithUrlString:(NSString *)urlString params:(NSDictionary *)params data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

/**
 start a  download request
 
 @param urlString request url.
 @param filePath data 存储位置
 @param progress 下载进度
 @param success success block
 @param failure failure block
 
 @return a NSURLSessionTask object
 */
- (NSURLSessionTask *)requestDownLoadDataWithUrlString:(NSString *)urlString filePath:(NSString *)filePath progress:(void(^)(NSProgress *progress))progress success:(void(^)(NSString *fullFilePath))success failure:(void(^)(NSError *error))failure;

/**
 设置拦截器
 
 @param interceptor 拦截器对象.
 */
- (void)setInterceptor:(id <QuecNetworkInterceptProtocol>)interceptor;

/**
 获取当前网络状态
 
 @return AFNetworkReachabilityStatus
 */
- (AFNetworkReachabilityStatus)getNetworkStatus;

/**
 开启网络监听,开启监听以后，网络状态发生改变会发送通知 AFNetworkingReachabilityDidChangeNotification
 */
- (void)startMonitoring;

/**
 关闭网络监听
 */
- (void)stopMonitoring;

/**
 设置网络监听
 
 @param block 网络状态发生改变回调
 */
- (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block;

/**
 设置是否开启debug模式
 
 */
- (void)setDebugMode:(BOOL)debugMode;

@end

