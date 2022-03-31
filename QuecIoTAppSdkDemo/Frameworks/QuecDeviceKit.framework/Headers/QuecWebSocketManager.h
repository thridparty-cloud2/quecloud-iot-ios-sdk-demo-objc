//
//  QuecWebSocketManager.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/9/29.
//

#import <Foundation/Foundation.h>

@protocol QuecWebSocketDelegate <NSObject>

- (void)quecWebSocketDidOpen;
- (void)quecWebSocketDidCloseWithCode:(NSInteger)code reason:(NSString *)reason;
- (void)quecWebSocketDidReceiveMessageWithString:(NSString *)string;
- (void)quecWebSocketDidReceiveMessageWithData:(NSData *)data;
- (void)quecWebSocketDidFailWithError:(NSError *)error;

@end

@interface QuecWebSocketManager : NSObject

@property (nonatomic, weak) id<QuecWebSocketDelegate> delegate;
// 心跳时间, 默认是40s
@property (nonatomic, assign) NSInteger heartInterval;
// 断开以后是否重连，默认true
@property (nonatomic ,assign) BOOL isReConnectAfterClosed;
// webSocket 是否开启
@property (nonatomic, assign) BOOL webSocketDidOpen;

/**
 @return return a single instance
 */
+ (instancetype)sharedInstance;

// Open with this
- (void)open;

// Close it with this
- (void)close;

// Send a Data
- (void)sendData:(NSData *)data;

// Send a UTF8 String
- (void)sendString:(NSString *)string;

@end



