//
//  QuecDeviceGroupInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/11/1.
//

#import <Foundation/Foundation.h>

@interface QuecDeviceGroupInfoModel : NSObject

// 名称
@property (nonatomic, copy) NSString *name;
// 地址
@property (nonatomic, copy) NSString *address;
// 联系人
@property (nonatomic, copy) NSString *contactPhoneList;
// 经纬度
@property (nonatomic, copy) NSString *coordinate;
// 坐标系
@property (nonatomic, copy) NSString *coordinateSystem;
// 说明
@property (nonatomic, copy) NSString *descrip;
// 管理员
@property (nonatomic, copy) NSString *manager;
// 管理员类型
@property (nonatomic, copy) NSString *managerType;
// 父设备组ID
@property (nonatomic, copy) NSString *parentId;
// 拓展字段
@property (nonatomic, copy) NSString *extend;
// 分组ID
@property (nonatomic, copy) NSString *dgid;
// 拥有者
@property (nonatomic, copy) NSString *owner;
// 添加时间
@property (nonatomic, copy) NSString *addTime;

@end

