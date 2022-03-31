//
//  QuecFirmwareUpgradeInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2022/2/17.
//

#import <Foundation/Foundation.h>

@class QuecDeviceOTAComponentVersionModel;
@class QuecDeviceOTAComponentModel;
@class QuecDeviceOTAPlanInfoModel;
@interface QuecDeviceOTAPlanModel : NSObject

// 组件列表
@property (nonatomic, strong) NSArray<QuecDeviceOTAComponentModel *> *components;
@property (nonatomic, strong) QuecDeviceOTAPlanInfoModel *planInfo;

@end


@interface QuecDeviceOTAComponentVersionModel : NSObject

// 文件签名
@property (nonatomic, copy) NSString *fileSign;
// 文件大小
@property (nonatomic, assign) NSInteger fileSize;
// 文件url
@property (nonatomic, copy) NSString *fileUrl;
@property (nonatomic, assign) NSInteger sort;

@end

@interface QuecDeviceOTAComponentModel : NSObject

// 组件标识
@property (nonatomic, copy) NSString *componentNo;
// 组件类型
@property (nonatomic, assign) NSInteger componentType;
// 版本列表
@property (nonatomic, strong) NSArray<QuecDeviceOTAComponentVersionModel *> *componentVersions;
// 数据类型
@property (nonatomic, assign) NSInteger dataType;
// 数据信息
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) NSInteger sort;
// 资源版本
@property (nonatomic, copy) NSString *sourceVersion;
// 目标版本
@property (nonatomic, copy) NSString *targetVersion;

@end


@interface QuecDeviceOTAPlanInfoModel : NSObject

// 设备剩余电量百分比
@property (nonatomic, assign) NSInteger batteryLevelLimit;
// 设备最小信号量 dbM
@property (nonatomic, assign) NSInteger minSignalIntensity;
@property (nonatomic, assign) NSInteger planId;
// 所需磁盘空间，KB
@property (nonatomic, assign) NSInteger useSpace;

@end
