//
//  QuecProductTSLContentBaseModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>

@interface QuecProductTSLContentBaseModel : NSObject

// 标志符
@property (nonatomic, copy) NSString *code;
// 名称
@property (nonatomic, copy) NSString *name;
// 读写类型
@property (nonatomic, copy) NSString *subType;
// id
@property (nonatomic, assign) NSInteger itemId;
// 排序
@property (nonatomic, copy) NSString *sort;
// 类型
@property (nonatomic, copy) NSString *type;
// 描述
@property (nonatomic, copy) NSString *desc;

@end

