//
//  QuecProductTSLModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>
#import "QuecProductTSLProfileModel.h"
#import "QuecProductTSLPropertyModel.h"
#import "QuecProductTSLServiceModel.h"
#import "QuecProductTSLEventModel.h"

@interface QuecProductTSLModel : NSObject

// profile信息
@property (nonatomic, strong) QuecProductTSLProfileModel *profile;
// 属性，item 是 QuecProductTSLPropertyModel
@property (nonatomic, strong) NSArray<QuecProductTSLPropertyModel *> *properties;
// 服务，item 是 QuecProductTSLServiceModel
@property (nonatomic, strong) NSArray<QuecProductTSLServiceModel *> *services;
// 事件，item 是 QuecProductTSLEventModel
@property (nonatomic, strong) NSArray<QuecProductTSLEventModel *> *events;

@end

