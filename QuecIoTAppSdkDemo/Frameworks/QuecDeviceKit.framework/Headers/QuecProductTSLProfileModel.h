//
//  QuecProductTSLProfileModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/28.
//

#import <Foundation/Foundation.h>

@interface QuecProductTSLProfileModel : NSObject

// 产品key
@property (nonatomic, copy) NSString *productKey;
// 版本
@property (nonatomic, copy) NSString *version;
// tls版本
@property (nonatomic, copy) NSString *tslVersion;

@end

