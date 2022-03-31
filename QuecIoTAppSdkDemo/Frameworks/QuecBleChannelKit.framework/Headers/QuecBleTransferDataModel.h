//
//  QuecBleTransferDataModel.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/17.
//

#import <Foundation/Foundation.h>

@class QuecBleTransferDataModel;
@class QuecBleCommandModel;
@interface QuecBleTransferDataModel : NSObject

// cmd
@property (nonatomic, assign) NSInteger cmd;
// data
@property (nonatomic, strong) NSData *data;
// writeWithResponse
@property (nonatomic, assign) BOOL writeWithResponse;
// packageId
@property (nonatomic, assign) int packageId;

@end


