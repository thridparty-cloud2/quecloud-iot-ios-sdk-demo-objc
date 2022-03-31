//
//  QuecProductTSLLocateInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>

@interface QuecProductTSLLocateInfoModel : NSObject

// 创建时间
@property (nonatomic, copy) NSString *createTime;
// 设备key
@property (nonatomic, copy) NSString *deviceKey;
// 水平精度因子
@property (nonatomic, copy) NSString *hdop;
// 纬度
@property (nonatomic, copy) NSString *lat;
// 经度
@property (nonatomic, copy) NSString *lng;
// 纬度半球 N/S
@property (nonatomic, copy) NSString *latType;
// 经度半球 W/E
@property (nonatomic, copy) NSString *lngType;
// 原始数据
@property (nonatomic, copy) NSString *locateRaw;
// 差分定位/非差分定位
@property (nonatomic, copy) NSString *locateStatus;
// 定为时间
@property (nonatomic, copy) NSString *locateTime;
// 定位类型
@property (nonatomic, copy) NSString *locateType;
// 产品key
@property (nonatomic, copy) NSString *productKey;
// 当前卫星数
@property (nonatomic, copy) NSString *satellites;

@end


