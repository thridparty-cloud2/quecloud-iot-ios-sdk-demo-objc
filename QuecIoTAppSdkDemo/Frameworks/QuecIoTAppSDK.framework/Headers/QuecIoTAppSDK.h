//
//  QuecIoTAppSDK.h
//  QuecIoTAppSDK
//
//  Created by quectel.steven on 2022/2/9.
//

#import <Foundation/Foundation.h>


@class QuecIoTAppSDKConfig;
@interface QuecIoTAppSDK : NSObject

typedef NS_ENUM(NSUInteger, QuecCloudServiceType) { //云服务类型
    QuecCloudServiceTypeChina = 0, //国内
    QuecCloudServiceTypeEurope,    //欧洲
};

/**
 @return return a single instance
 */
+ (instancetype)sharedInstance;

/**
 初始化 SDK。
 该接口执行后，其他接口功能才能正常执行
 
 @param userDomain 用户域，DMP平台创建APP生成
 @param userDomainSecret // 用户域秘钥，DMP平台创建APP生成
 @param cloudServiceType 云服务类型，指定连接的云服务
 */
- (void)startWithUserDomain:(NSString *)userDomain userDomainSecret:(NSString *)userDomainSecret cloudServiceType:(QuecCloudServiceType)cloudServiceType;

/**
 Debug模式.
 在开发的过程中可以开启Debug模式，打印日志用于分析问题。
 
 @param debugMode  Debug模式
 */
- (void)setDebugMode:(BOOL)debugMode;

@end
