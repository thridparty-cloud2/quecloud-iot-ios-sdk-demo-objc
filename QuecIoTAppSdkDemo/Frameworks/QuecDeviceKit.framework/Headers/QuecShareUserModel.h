//
//  QuecShareUserModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/29.
//

#import <Foundation/Foundation.h>
#import "QuecShareUserShareInfoModel.h"
#import "QuecShareUserInfoModel.h"

@interface QuecShareUserModel : NSObject

// 分享信息
@property (nonatomic, strong) QuecShareUserShareInfoModel *shareInfo;
// 用户信息
@property (nonatomic, strong) QuecShareUserInfoModel *userInfo;

@end


