//
//  QuecBleFilterModel.h
//  QuecBleChannelKit
//
//  Created by quectel.steven on 2021/11/15.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    QuecBleFilterTypeMacMatch, // mac地址匹配
    QuecBleFilterTypeNamePredicate, // name正则匹配
} QuecBleFilterType;

@interface QuecBleFilterModel : NSObject

// ble mac
@property (nonatomic, copy) NSString *mac;
// name 正则规则
@property (nonatomic, copy) NSString *pattern;
// filter type
@property (nonatomic, assign) QuecBleFilterType filterType;


@end

