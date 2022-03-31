//
//  QuecProductTSLResourceInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>

@interface QuecProductTSLResourceInfoModel : NSObject

// 创建时间
@property (nonatomic, copy) NSString *createTime;
// 设备id
@property (nonatomic, copy) NSString *deviceId;
// 设备key
@property (nonatomic, copy) NSString *deviceKey;
// 资源标识
@property (nonatomic, copy) NSString *resourceCode;
// 资源值
@property (nonatomic, copy) NSString *resourceValue;
// 更新时间
@property (nonatomic, copy) NSString *updateTime;

@end

