//
//  QuecWebSocketActionModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2022/2/18.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, QuecWebSocketOptionsMessageType) {
    QuecWebSocketOptionsMessageTypeALL = 1 << 0, // 所有类型
    QuecWebSocketOptionsMessageTypeONLINE = 1 << 1, // 设备上下线信息
    QuecWebSocketOptionsMessageTypeSTATUS = 1 << 2, // 设备和模组状态信息
    QuecWebSocketOptionsMessageTypeRAWUPLINK    = 1 << 3, // 透传产品--设备上行信息
    QuecWebSocketOptionsMessageTypeMATTRREPORT   = 1 << 4, // 物模型产品--设备上报属性信息
    QuecWebSocketOptionsMessageTypeMEVENTINFO  = 1 << 5, // 物模型产品--设备事件信息
    QuecWebSocketOptionsMessageTypeMEVENTWARN = 1 << 6, // 物模型产品--设备事件告警
    QuecWebSocketOptionsMessageTypeMEVENTERROR  = 1 << 7, //   物模型产品--设备事件故障
    QuecWebSocketOptionsMessageTypeLOCATIONINFOKV = 1 << 8, // 设备定位信息上报
};

@interface QuecWebSocketActionModel : NSObject

// 产品productKey
@property (nonatomic, copy) NSString *productKey;
// 设备DeviceKey
@property (nonatomic, copy) NSString *deviceKey;
// 消息类型,取消订阅是可不填
@property (nonatomic, assign) QuecWebSocketOptionsMessageType messageType;

@end

