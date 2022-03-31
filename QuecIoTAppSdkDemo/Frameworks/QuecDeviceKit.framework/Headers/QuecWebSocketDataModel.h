//
//  QuecWebSocketDataModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/11/8.
//

#import <Foundation/Foundation.h>

@interface QuecWebSocketDataModel : NSObject

// 指令,具体参考WebSocket数据透传消息格式定义-订阅
@property (nonatomic, copy) NSString *cmd;
// 数据,具体参考WebSocket数据透传消息格式定义-订阅
@property (nonatomic, strong) id data;

@end

