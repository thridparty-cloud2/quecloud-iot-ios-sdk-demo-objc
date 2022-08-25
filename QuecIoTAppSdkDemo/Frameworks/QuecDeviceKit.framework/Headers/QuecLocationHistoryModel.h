//
//  QuecLocationHistoryModel.h
//  QuecDeviceKit
//
//  Created by quectel.tank on 2022/5/27.
//

#import <Foundation/Foundation.h>


@interface QuecLocationHistoryModel : NSObject
// 设备纬度。BD09
@property (nonatomic, copy) NSNumber *bdLat;
// 设备经度。BD09
@property (nonatomic, copy) NSNumber *bdLng;
// dk
@property (nonatomic, copy) NSString *deviceKey;
// 设备纬度。GCJ02
@property (nonatomic, copy) NSNumber *gcjLat;
// 设备经度。GCJ02
@property (nonatomic, copy) NSNumber *gcjLng;
// 水平精度因子。0.5-99.99
@property (nonatomic, copy) NSNumber *hdop;
// 轨迹ID
@property (nonatomic, copy) NSString *locateId;
// 定位方式（0：GNNS 1：LBS 2：手动标点）
@property (nonatomic, assign) NSInteger locateType;
//
@property (nonatomic, copy) NSString *locationTime;
// pk
@property (nonatomic, copy) NSString *productKey;
// 当前卫星数
@property (nonatomic, assign) NSInteger satellites;
// 最新定位时间（时间戳）
@property (nonatomic, assign) NSInteger tsLocateTime;
// 设备纬度。WGS84
@property (nonatomic, copy) NSNumber *wgsLat;
// 设备经度。WGS84
@property (nonatomic, copy) NSNumber *wgsLng;


@end

