//
//  QuecProductTSLServiceModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import "QuecProductTSLContentBaseModel.h"

@interface QuecProductTSLServiceModel : QuecProductTSLContentBaseModel

// 服务输入项，描述服务输入的数据
@property (nonatomic, copy) NSDictionary *inputData;
// 服务输出项，描述服务输出的数据
@property (nonatomic, copy) NSDictionary *outputData;

@end

