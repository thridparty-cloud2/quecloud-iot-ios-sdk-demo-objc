//
//  QuecBleReceiveModel.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/19.
//

#import <Foundation/Foundation.h>

@class QuecPayloadDataModel;

@interface QuecBleReceiveModel : NSObject

// cmd
@property (nonatomic, assign) int cmd;
// payload
@property (nonatomic, strong) NSArray<QuecPayloadDataModel *> *payload;
// packageId
@property (nonatomic, assign) int packageId;

@end

