//
//  QuecCommandDecode.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/19.
//

#import <Foundation/Foundation.h>

@class QuecBleReceiveModel;
@interface QuecCommandDecode : NSObject

- (QuecBleReceiveModel *)decodeCommand:(NSData *)data;
- (void)clear;

@end

