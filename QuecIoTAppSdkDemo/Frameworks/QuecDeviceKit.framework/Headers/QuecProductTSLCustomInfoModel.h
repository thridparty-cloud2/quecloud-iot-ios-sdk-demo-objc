//
//  QuecProductTSLCustomInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>

@interface QuecProductTSLCustomInfoModel : NSObject

// 功能ID
@property (nonatomic, assign) NSInteger abId;
// 数据类型
@property (nonatomic, copy) NSString *dataType;
// 功能名称
@property (nonatomic, copy) NSString *name;
// 功能标识符
@property (nonatomic, copy) NSString *resourceCode;
// 功能值
@property (nonatomic, copy) NSString *resourceValue;
// 数据操作类型
@property (nonatomic, copy) NSString *subType;
// 功能类型
@property (nonatomic, copy) NSString *type;

@end

