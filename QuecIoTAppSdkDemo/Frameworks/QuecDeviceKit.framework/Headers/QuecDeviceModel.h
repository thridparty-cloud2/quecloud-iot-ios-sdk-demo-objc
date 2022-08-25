//
//  QuecDeviceModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/26.
//

#import <Foundation/Foundation.h>

@interface QuecDeviceModel : NSObject

// 访问类型：0-直连设备 1-网关设备 2-网关子设备
@property (nonatomic, copy) NSString *accessType;
// 激活时间
@property (nonatomic, copy) NSString *activeTime;
// 授权key
@property (nonatomic, copy) NSString *authKey;
// 设备绑定时间
@property (nonatomic, copy) NSString *deviceBindTime;
// 设备绑定时间戳
@property (nonatomic, assign) NSInteger deviceBindTimeTs;
// 设备创建时间
@property (nonatomic, copy) NSString *deviceCreateTime;
// 设备创建时间戳
@property (nonatomic, assign) NSInteger deviceCreateTimeTs;
// 设备key
@property (nonatomic, copy) NSString *deviceKey;
// 设备名称
@property (nonatomic, copy) NSString *deviceName;
// 设备状态
@property (nonatomic, copy) NSString *deviceStatus;
// 设备类型：1 自有设备、 2 分享来的设备
@property (nonatomic, assign) NSInteger deviceType;
// 失效时间
@property (nonatomic, copy) NSString *invaildTime;
// 失效时间戳
@property (nonatomic, assign) NSInteger invaildTimeTs;
// 最后上线时间
@property (nonatomic, copy) NSString *lastConnTime;
// 最后上线时间戳
@property (nonatomic, assign) NSInteger lastConnTimeTs;
// 支持的定位内容
@property (nonatomic, copy) NSString *locateType;
// 分享人用户ID，来自谁的分享
@property (nonatomic, copy) NSString *ownerUid;
// 已绑定用户手机号
@property (nonatomic, copy) NSString *phone;
// 产品key
@property (nonatomic, copy) NSString *productKey;
// 产品名称
@property (nonatomic, copy) NSString *productName;
// 接入时间
@property (nonatomic, copy) NSString *protocol;
// 分享码
@property (nonatomic, copy) NSString *shareCode;
// 已绑定用户ID
@property (nonatomic, copy) NSString *uid;
// 已绑定用户昵称
@property (nonatomic, copy) NSString *userName;
// 设备绑定是否认证：0 未认证 1 已认证
@property (nonatomic, copy) NSString *verified;
// 信号强度
@property (nonatomic, copy) NSString *signalStrength;
// 绑定状态：1 正常 2 失效
@property (nonatomic, assign) NSInteger status;
// 离线时间
@property (nonatomic, copy) NSString *lastOfflineTime;
// 离线时间戳
@property (nonatomic, assign) NSInteger lastOfflineTimeTs;
// btPwd
@property (nonatomic, copy) NSString *btPwd;
// 绑定类型
@property (nonatomic, copy) NSString *bindType;
// authCode
@property (nonatomic, copy) NSString *authCode;
// 产品logo
@property (nonatomic, copy) NSString *logoImage;
// sn
@property (nonatomic, copy) NSString *sn;

@end

