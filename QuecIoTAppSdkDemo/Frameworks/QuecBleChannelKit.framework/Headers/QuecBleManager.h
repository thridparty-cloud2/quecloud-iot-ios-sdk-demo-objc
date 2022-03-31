//
//  QuecBleManager.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/15.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "QuecBleFilterModel.h"
#import "QuecBleCommandModel.h"
#import "QuecPeripheralModel.h"
#import "QuecBleReceiveModel.h"


@protocol QuecBleManagerDelegate <NSObject>

@optional
- (void)centralDidUpdateState:(CBManagerState)state;
- (void)centralDidDiscoverPeripheral:(QuecPeripheralModel *)peripheral;
- (void)peripheralDidUpdateConnectState:(BOOL)connectState;
- (void)didReceivePeripheralData:(QuecBleReceiveModel *)data;

@end

@interface QuecBleManager : NSObject

// 系统蓝牙状态
@property (nonatomic, assign) CBManagerState state;
// ble 连接状态
@property (nonatomic, assign) BOOL isConnect;
// 指令回复超时时间, 默认是30s
@property (nonatomic, assign) NSInteger commandResponseTimeout;

/**
 @return return a single instance
 */
+ (instancetype)sharedInstance;

/**
 添加监听
 
 @param delegate listener
 */
- (void)addListener:(id<QuecBleManagerDelegate>)delegate;

/**
 移除监听
 
 @param delegate listener
 */
- (void)removeListener:(id<QuecBleManagerDelegate>)delegate;

/**
 开始扫描
 
 @param filter 过滤条件
 */
- (void)startScanWithFilier:(QuecBleFilterModel *)filter;

/**
 停止扫描
 */
- (void)stopScan;

/**
 连接外设
 
 @param peripheral 外设
 */
- (void)connectPeripheral:(QuecPeripheralModel *)peripheral;

/**
 断开连接
 
 @param peripheral 外设
 */
- (void)disconnectPeripheral:(QuecPeripheralModel *)peripheral;

/**
 发送指令
 
 @param command 指令数据
 @param completion 完成回调
 */
- (void)sendCommand:(QuecBleCommandModel *)command completion:(void(^)(BOOL timeout, QuecBleReceiveModel *response))completion;



@end

