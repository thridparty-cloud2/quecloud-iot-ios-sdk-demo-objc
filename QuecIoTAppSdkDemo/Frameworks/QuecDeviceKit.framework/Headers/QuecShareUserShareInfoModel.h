//
//  QuecShareUserShareInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/29.
//

#import <Foundation/Foundation.h>

@interface QuecShareUserShareInfoModel : NSObject

// 分享时间
@property (nonatomic, copy) NSString *acceptTime;
// 分享失效时间
@property (nonatomic, copy) NSString *acceptingExpireAt;
//
@property (nonatomic, assign) NSInteger coverMark;
// 删除时间
@property (nonatomic, copy) NSString *deleteTime;
// 设备名称
@property (nonatomic, copy) NSString *deviceName;
// 设备key
@property (nonatomic, copy) NSString *dk;
// 所有者ID
@property (nonatomic, copy) NSString *ownerUid;
// 产品key
@property (nonatomic, copy) NSString *pk;
// 分享码
@property (nonatomic, copy) NSString *shareCode;
// 分享ID
@property (nonatomic, copy) NSString *shareId;
// 分享状态
@property (nonatomic, assign) NSInteger shareStatus;
// 分享时间
@property (nonatomic, copy) NSString *shareTime;
// 分享用户ID
@property (nonatomic, copy) NSString *shareUid;
// 分享失效时间
@property (nonatomic, copy) NSString *sharingExpireAt;
// 更新时间
@property (nonatomic, copy) NSString *updateTime;

@end

