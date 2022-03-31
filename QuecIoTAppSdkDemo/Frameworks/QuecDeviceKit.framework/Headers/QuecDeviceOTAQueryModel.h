//
//  QuecFirmwareUpgradeQueryModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2022/2/17.
//

#import <Foundation/Foundation.h>

@class QuecDeviceOTAQueryMCUInfoModel;
@interface QuecDeviceOTAQueryModel : NSObject

// 设备剩余电量百分比
@property (nonatomic, assign) NSInteger batteryLevelLimit;
// 固件信息
@property (nonatomic, copy) NSArray<QuecDeviceOTAQueryMCUInfoModel *> *mcuVersions;
// 设备最小信号量 dbM
@property (nonatomic, assign) NSInteger minSignalIntensity;
// 模组版本
@property (nonatomic, copy) NSString *moduleVersion;
// 升级时间时间戳，默认为当前时间戳
@property (nonatomic, assign) NSInteger upgradeTime;
// 所需磁盘空间，KB
@property (nonatomic, assign) NSInteger useSpace;

@end

@interface QuecDeviceOTAQueryMCUInfoModel : NSObject
// 升级组件标识
@property (nonatomic, copy) NSString *componentNo;
// 升级组件版本
@property (nonatomic, copy) NSString *version;
@end
