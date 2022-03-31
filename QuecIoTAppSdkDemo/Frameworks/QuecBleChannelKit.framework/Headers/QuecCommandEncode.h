//
//  QuecCommandEncode.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/17.
//

#import <Foundation/Foundation.h>

@class QuecBleCommandModel;
@interface QuecCommandEncode : NSObject

- (NSData *)encodeCommond:(QuecBleCommandModel *)commond packageId:(int)packageId;

@end

