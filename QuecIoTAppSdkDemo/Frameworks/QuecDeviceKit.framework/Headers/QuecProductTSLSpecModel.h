//
//  QuecProductTSLSpecModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>

@interface QuecProductTSLSpecModel : NSObject

// specs
@property (nonatomic, strong) id specs;
// format specs
@property (nonatomic, strong) NSArray<QuecProductTSLSpecModel *> *formatSpecs;
// 数据类型
@property (nonatomic, copy) NSString *dataType;
// 名称
@property (nonatomic, copy) NSString *name;
// value值
@property (nonatomic, copy) NSString *value;
// id
@property (nonatomic, copy) NSString *itemId;
// 单位
@property (nonatomic, copy) NSString *unit;
// 最小值
@property (nonatomic, copy) NSString *min;
// 最大值
@property (nonatomic, copy) NSString *max;
// 步长
@property (nonatomic, copy) NSString *step;
// 文本长度
@property (nonatomic, copy) NSString *length;
// 数组大小
@property (nonatomic, copy) NSString *size;
// 属性值
@property (nonatomic, strong) id attributeValue;
// code
@property (nonatomic, copy) NSString *code;


@end

