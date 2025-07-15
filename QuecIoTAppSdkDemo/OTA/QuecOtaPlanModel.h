//
//  QuecOtaPlanModel.h
//  QuecIoTAppSdkDemo
//
//  Created by quectel.tank on 4/27/25.
//

#import <Foundation/Foundation.h>
#import <QuecOTAUpgradeKit/QuecOTAUpgradeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuecOtaPlanModel : NSObject

@property (nonatomic, strong) QuecOtaPlanInfoModel *planInfoModel;

@property (nonatomic, assign) QuecOTAState state;

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) NSString *dk;
@property (nonatomic, copy) NSString *pk;

@property (nonatomic, assign) long long planId;

@end

NS_ASSUME_NONNULL_END
