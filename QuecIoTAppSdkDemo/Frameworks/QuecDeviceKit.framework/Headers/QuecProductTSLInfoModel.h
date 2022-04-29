//
//  QuecProductTSLInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>
#import "QuecProductTSLCustomInfoModel.h"
#import "QuecProductTSLLocateInfoModel.h"
#import "QuecProductTSLResourceInfoModel.h"

@interface QuecProductTSLInfoModel : NSObject

// 自定义物模型数据上报列表
@property (nonatomic, strong) NSArray<QuecProductTSLCustomInfoModel *> *customizeTslInfo;
// 定位信息
@property (nonatomic, strong) QuecProductTSLLocateInfoModel *deviceLocateInfo;
// 资源物模型数据
@property (nonatomic, strong) NSArray<QuecProductTSLResourceInfoModel *> *tslResourcesInfo;

@end


