//
//  QuecProductTSLEventModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import "QuecProductTSLContentBaseModel.h"

@interface QuecProductTSLEventModel : QuecProductTSLContentBaseModel

// 事件输出项，描述事件输出的具体事项
@property (nonatomic, copy) NSDictionary *outputData;

@end

