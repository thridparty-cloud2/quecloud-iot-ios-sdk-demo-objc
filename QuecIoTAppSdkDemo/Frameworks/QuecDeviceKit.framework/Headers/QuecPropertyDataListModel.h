//
//  QuecPropertyDataListModel.h
//  QuecDeviceKit
//
//  Created by quectel.tank on 2022/5/27.
//

#import <Foundation/Foundation.h>

@interface QuecPropertyDataListModel : NSObject
// createTime
@property (nonatomic, copy) NSString *createTime;
// dk
@property (nonatomic, copy) NSString *deviceKey;
// pk
@property (nonatomic, copy) NSString *productKey;
// 属性标识符
@property (nonatomic, copy) NSString *propertyCode;
// 属性值
@property (nonatomic, copy) NSString *propertyValue;
// 记录时间
@property (nonatomic, assign) NSInteger tsCreateTime;

@end

