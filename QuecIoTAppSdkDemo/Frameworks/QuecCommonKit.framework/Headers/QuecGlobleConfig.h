//
//  QuecGlobleConfig.h
//  QuecUserKit
//
//  Created by quectel.steven on 2021/9/1.
//

#import <Foundation/Foundation.h>

@interface QuecGlobleConfig : NSObject

//用户域
@property (nonatomic, copy) NSString *userDomain;
//用户域秘钥
@property (nonatomic, copy) NSString *userDomainSecret;
//域名
@property (nonatomic, copy) NSString *baseUrl;
//websocket域名
@property (nonatomic, copy) NSString *webSocketUrl;
//企业短信签名ID
@property (nonatomic, copy) NSString *ssid;
//企业重置密码短信模板ID
@property (nonatomic, copy) NSString *resetPswStid;
//企业登录短信模板ID
@property (nonatomic, copy) NSString *loginStid;
//企业注册短信模板ID
@property (nonatomic, copy) NSString *registerStid;

/**
 @return return a single instance
 */
+ (QuecGlobleConfig *)sharedInstance;

/**
 @return userDomain
 */
+ (NSString *)getUserDomain;

/**
 @return userDomainSecret
 */
+ (NSString *)getUserDomainSecret;

/**
 @return return baseUrl
 */
+ (NSString *)getBaseUrl;

/**
 @return return websocketUrl
 */
+ (NSString *)getWebSocketUrl;

/**
 @return ssid
 */
+ (NSString *)getSsid;

/**
 @return resetPswStid
 */
+ (NSString *)getResetPswStid;

/**
 @return loginStid
 */
+ (NSString *)getLoginStid;

/**
 @return registerStid
 */
+ (NSString *)getRegisterStid;

@end

