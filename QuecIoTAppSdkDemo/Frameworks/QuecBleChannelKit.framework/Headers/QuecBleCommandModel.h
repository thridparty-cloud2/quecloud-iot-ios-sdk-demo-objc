//
//  QuecBleSendCommandModel.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/16.
//

#import <Foundation/Foundation.h>

@class QuecPayloadDataModel;

@interface QuecBleCommandModel : NSObject
// cmd
@property (nonatomic, assign) int cmd;
// payload
@property (nonatomic, strong) NSArray<QuecPayloadDataModel *> *payload;
// writeWithResponse or writeWithoutResponse
@property (nonatomic, assign) BOOL writeWithResponse;

+ (instancetype)getCommadnWithCommand:(int)command payload:(NSArray *)payload writeWithResponse:(BOOL)writeWithResponse;

@end
