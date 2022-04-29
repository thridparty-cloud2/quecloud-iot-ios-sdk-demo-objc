//
//  QuecProductTSLPropertyModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import "QuecProductTSLContentBaseModel.h"
#import "QuecProductTSLSpecModel.h"
@interface QuecProductTSLPropertyModel : QuecProductTSLContentBaseModel

// spces
@property (nonatomic, strong) id specs;
// format specs
@property (nonatomic, strong) NSArray<QuecProductTSLSpecModel *> *formatSpecs;
// 数据类型
@property (nonatomic, copy) NSString *dataType;
// 属性值
@property (nonatomic, strong) id attributeValue;

@end

