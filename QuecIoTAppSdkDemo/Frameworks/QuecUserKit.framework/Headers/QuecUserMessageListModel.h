//
//  QuecUserMessageListModel.h
//  QuecUserKit
//
//  Created by quectel.tank on 2022/6/22.
//

#import <Foundation/Foundation.h>

@interface QuecUserMessageListModel : NSObject

@property (nonatomic, copy) NSString *msgId;
// 消息类型  1-设备通知  2-设备告警  3-设备故障  4-系统消息
@property (nonatomic, assign) NSInteger msgType;
// 是否已读
@property (nonatomic, assign) BOOL isRead;
// 标题
@property (nonatomic, copy) NSString *title;
// 内容
@property (nonatomic, copy) NSString *content;
// Product Key
@property (nonatomic, copy) NSString *pk;
// Device Key
@property (nonatomic, copy) NSString *dk;
// 添加时间
@property (nonatomic, assign) NSUInteger addTime;
// 阅读时间
@property (nonatomic, assign) NSUInteger readTime;


@end

