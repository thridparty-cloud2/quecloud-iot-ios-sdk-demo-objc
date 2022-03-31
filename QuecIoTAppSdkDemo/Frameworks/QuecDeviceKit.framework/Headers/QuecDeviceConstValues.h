//
//  QuecDeviceConstValues.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>

// tsl
// 物模型属性 Bool类型
extern NSString * const QuecProductionTslDataTypeBOOL;
// 物模型属性 int类型
extern NSString * const QuecProductionTslDataTypeINT;
// 物模型属性 float类型
extern NSString * const QuecProductionTslDataTypeFLOAT;
// 物模型属性 double类型
extern NSString * const QuecProductionTslDataTypeDOUBLE;
// 物模型属性 枚举类型
extern NSString * const QuecProductionTslDataTypeENUM;
// 物模型属性 文本类型
extern NSString * const QuecProductionTslDataTypeTEXT;
// 物模型属性 date类型
extern NSString * const QuecProductionTslDataTypeDATE;
// 物模型属性 array类型
extern NSString * const QuecProductionTslDataTypeARRAY;
// 物模型属性 struct类型
extern NSString * const QuecProductionTslDataTypeSTRUCT;

// 物模型属性可读写
extern NSString * const QuecProductionTslSubTypeRW;
// 物模型属性只读
extern NSString * const QuecProductionTslSubTypeR;
// 物模型属性只写
extern NSString * const QuecProductionTslSubTypeW;


//websocket
// 登录
extern NSString * const QuecWebSocketCmdTypeLogin;
// 登录回复
extern NSString * const QuecWebSocketCmdTypeLogin_response;
// 订阅
extern NSString * const QuecWebSocketCmdTypeSubscribe;
// 订阅回复
extern NSString * const QuecWebSocketCmdTypeSubscribe_response;
// 取消订阅
extern NSString * const QuecWebSocketCmdTypeUnsubscribe;
// 取消订阅回复
extern NSString * const QuecWebSocketCmdTypeUnsubscribe_response;
// 物模型属性读写以及发送数据
extern NSString * const QuecWebSocketCmdTypeSend;
// 物模型属性读写以及发送数据回复
extern NSString * const QuecWebSocketCmdTypeSend_ack;
// 错误提示
extern NSString * const QuecWebSocketCmdTypeError;
// 设备上行信息
extern NSString * const QuecWebSocketCmdTypeMessage;

// 设备上下线信息
extern NSString * const QuecWebSocketMessageTypeONLINE;
// 设备和模组状态信息
extern NSString * const QuecWebSocketMessageTypeSTATUS;
// 透传产品--设备上行信息
extern NSString * const QuecWebSocketMessageTypeRAW_UPLINK;
// 物模型产品--设备上报属性信息
extern NSString * const QuecWebSocketMessageTypeMATTR_REPORT;
// 物模型产品--设备事件信息
extern NSString * const QuecWebSocketMessageTypeMEVENT_INFO;
// 物模型产品--设备事件告警
extern NSString * const QuecWebSocketMessageTypeMEVENT_WARN;
// 物模型产品--设备事件故障
extern NSString * const QuecWebSocketMessageTypeMEVENT_ERROR;
// 设备定位信息上报
extern NSString * const QuecWebSocketMessageTypeLOCATION_INFO_KV;
