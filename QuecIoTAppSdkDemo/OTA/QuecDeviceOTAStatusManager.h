//
//  QuecDeviceOTAStatusManager.h
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuecDeviceOTAStatusManager : NSObject

/**
 @return return a single instance
 */
+ (instancetype)sharedInstance;

- (void)addHandlerOTAState:(id)delegate listener:(void (^)(void))listener;

- (void)removeHandlerOTAState:(id)delegate;

- (int)readDeviceStateWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey planId:(NSString *)planId;

- (float)readDeviceUpdateProgressWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey;

- (void)cleanFailAndSuccessState;

@end

@interface QuecDeviceOTAStateModel : NSObject

@property (nonatomic, assign)int state;
@property (nonatomic, assign)float progress;
@property (nonatomic, copy)NSString *dk;
@property (nonatomic, copy)NSString *pk;
@property (nonatomic, assign)int userConfirmStatus;// 用户确认升级
@property (nonatomic, assign)float upgradeProgress;// 升级进度
@property (nonatomic, copy)NSString *planId;

@end


NS_ASSUME_NONNULL_END
