//
//  QuecDeviceOTAStatusManager.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/12.
//

#import "QuecDeviceOTAStatusManager.h"
#import <QuecOTAUpgradeKit/QuecOTAUpgradeKit.h>
#import <QuecOTAUpgradeKit/QuecOTAPlanParamModel.h>
#import <QuecOTAUpgradeKit/QuecOTAComponetModel.h>
#import "QuecOTAPlanInfoModel.h"
#import <QuecCommonUtil/QuecCommonUtil.h>

static id _instance = nil;

@interface QuecDeviceOTAStatusManager()

@property (nonatomic, strong) NSMutableDictionary *deviceStatePool;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSMutableDictionary *delegates;
@property (nonatomic, strong) NSLock *delegatesLock;

@end

@implementation QuecDeviceOTAStatusManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _deviceStatePool = [NSMutableDictionary dictionary];
        _delegates = [NSMutableDictionary dictionary];
        _delegatesLock = [[NSLock alloc] init];
        [self addOTAStatusObserver];
    }
    return self;
}

- (void)addOTAStatusObserver {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(appBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)appBecomeActiveNotification {
    BOOL hasOTADevice = NO;
    for (QuecDeviceOTAStateModel *value  in self.deviceStatePool.allValues) {
        if (value.state == 1 || (value.state == 0 && value.userConfirmStatus == 1)) {
            hasOTADevice = YES;
            break;
        }
    }
    if (hasOTADevice && self.timer == nil) {
        [self startTimer];
    }

}

- (void)appDidEnterBackground {
    [self stopTimer];
}

- (void)addHandlerOTAState:(id)delegate listener:(void (^)(void))listener {
    [self.delegatesLock lock];
    NSString *className = NSStringFromClass([delegate class]);
    if (![self.delegates.allKeys containsObject:className]) {
        [self.delegates quec_safeSetObject:listener forKey:className];
    }
    [self.delegatesLock unlock];
}

- (void)removeHandlerOTAState:(id)delegate {
    [self.delegatesLock lock];
    NSString *className = NSStringFromClass([delegate class]);
    if ([self.delegates.allKeys containsObject:className]) {
        [self.delegates removeObjectForKey:className];
    }
    [self.delegatesLock unlock];
}

- (void)startTimer {
    if (self.deviceStatePool.allValues.count == 0) {
        return;
    }
    // 在global线程里创建一个时间源
    if (!self.timer) {
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    // 设定这个时间源是每秒循环一次，立即开始
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 3.0 * NSEC_PER_SEC, 10); // 10 is the leeway in seconds
    // 设定时间源的触发事件
    dispatch_source_set_event_handler(self.timer, ^{
        [self checkDeviceState];
    });
    // 启动时间源
    dispatch_resume(self.timer);
}

//停止定时器
- (void)stopTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)checkDeviceState {
    NSDictionary *statePool = self.deviceStatePool.copy;
    if (statePool.allValues.count == 0) {
        return;
    }
    NSArray *statePoolArray = statePool.allValues;
    
    NSMutableArray *paramsArray = [NSMutableArray array];
    for (QuecDeviceOTAStateModel *value in statePoolArray) {
        if (value.state != 2 && value.state != 3 && value.state != 4) {
            QuecOTAPlanParamModel *param = [[QuecOTAPlanParamModel alloc] init];
            param.pk = [value pk];
            param.dk = [value dk];
            param.planId = (int64_t)[value planId];
            [paramsArray addObject:param];
        }
    }
    
    [QuecHttpOTAService.sharedInstance getBatchUpgradeDetailsWithList:paramsArray success:^(NSArray<QuecOTAPlanModel *> *data) {
        
        for (QuecOTAPlanModel *item in data) {
            int deviceStatus = [item.deviceStatus intValue];
            /// -1 是无需升级的，直接显示已升级
            int deviceState = deviceStatus == -1 ? 2 : deviceStatus;
            int userConfirmStatus = item.userConfirmStatus;
            if (userConfirmStatus != 0) {
                if (deviceState == 3) {
                    [self writeDeviceStateWithProductKey:item.productKey deviceKey:item.deviceKey planId:[NSString stringWithFormat:@"%lld", item.planId] state:3 userConfirmStatus:1];
                } else if (deviceState == 2) {
                    [self otaDeviceSuccessWithPk:item.productKey dk:item.deviceKey planId:[NSString stringWithFormat:@"%lld", item.planId] index:0 statePoolArray:statePoolArray];
                } else {
                    [self writeStateWithProductKey:item.productKey deviceKey:item.deviceKey planId:[NSString stringWithFormat:@"%lld", item.planId] state:deviceState userConfirmStatus:userConfirmStatus upgradeProgress:item.upgradeProgress];
                }
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self uploadDeviceState];
        });
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)writeDeviceStateWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey planId:(NSString *)planId state:(int)state userConfirmStatus:(int)userConfirmStatus {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self writeStateWithProductKey:productKey deviceKey:deviceKey planId:planId state:state userConfirmStatus:userConfirmStatus upgradeProgress:0];
        
        BOOL hasOTADevice = NO;
        for (QuecDeviceOTAStateModel *value in self.deviceStatePool.allValues) {
            if (value.state == 1 || (value.state == 0 && value.userConfirmStatus == 1)) {
                hasOTADevice = YES;
                break;
            }
        }
        
        if (hasOTADevice && self.timer == nil) {
            [self startTimer];
        }
        
        if (!hasOTADevice) {
            [self stopTimer];
        }
    });
}

- (void)writeStateWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey planId:(NSString *)planId state:(int)state userConfirmStatus:(int)userConfirmStatus upgradeProgress:(CGFloat)upgradeProgress {
    
    QuecDeviceOTAStateModel *stateModel = [[QuecDeviceOTAStateModel alloc] init];
    stateModel.state = state;
    stateModel.userConfirmStatus = userConfirmStatus;
    stateModel.pk = productKey;
    stateModel.dk = deviceKey;
    stateModel.planId = planId;
    stateModel.upgradeProgress = upgradeProgress;
    
    [self.deviceStatePool quec_safeSetObject:stateModel forKey:quec_deviceId(productKey, deviceKey)];
}

- (void)otaDeviceSuccessWithPk:(NSString *)pk dk:(NSString *)dk planId:(NSString *)planId index:(NSInteger)index statePoolArray:(NSArray<QuecDeviceOTAStateModel *> *)statePoolArray {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self autoUpgradeSwitchWithProductKey:pk deviceKey:dk completion:^(BOOL isAuto, NSError *error) {
            if (error) {
                [self writeDeviceStateWithProductKey:pk deviceKey:dk planId:planId state:2 userConfirmStatus:0];
                return;
            }
            
            if (!isAuto) {
                [self writeDeviceStateWithProductKey:pk deviceKey:dk planId:planId state:2 userConfirmStatus:0];
                return;
            }
            
            [self fetchDeviceOTAPlanWithPk:pk deviceKey:dk completion:^(QuecOTAPlanInfoModel * _Nullable model, NSError * _Nullable error) {
                
                if (!model) {
                    [self writeDeviceStateWithProductKey:pk deviceKey:dk planId:planId state:2 userConfirmStatus:0];
                    return;
                }
                
                [self writeDeviceStateWithProductKey:model.pk deviceKey:model.dk planId:model.planId state:1 userConfirmStatus:0];
                
            }];

        }];
        
    });
}

- (void)autoUpgradeSwitchWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey completion:(void (^)(BOOL isAuto, NSError *error))completion {
    [QuecHttpOTAService.sharedInstance autoUpgradeSwitch:productKey deviceKey:deviceKey success:^(BOOL isAuto) {
        if (completion) {
            completion(isAuto, nil);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(NO, error);
        }
    }];
}

- (void)fetchDeviceOTAPlanWithPk:(NSString *)pk deviceKey:(NSString *)dk completion:(void (^)(QuecOTAPlanInfoModel * _Nullable model, NSError * _Nullable error))completion {
    if (!dk) {
        if (completion) {
            completion(nil, nil);
        }
        return;
    }
    
    [QuecHttpOTAService.sharedInstance checkDeviceOTAPlan:pk deviceKey:dk success:^(QuecOTAPlanModel *model) {
        if (!model) {
            if (completion) {
                completion(nil, nil);
            }
            return;
        }
        
        QuecOTAPlanInfoModel *otaModel = [[QuecOTAPlanInfoModel alloc] init];
        otaModel.dk = dk;
        otaModel.pk = pk;
        otaModel.versionInfo = model.versionInfo;
        otaModel.planName = model.planName;
        int otaStatus = 0;
        if (model.deviceStatus) {
            otaStatus = [model.deviceStatus intValue] == 0 && model.userConfirmStatus == 1 ? 1 : [model.deviceStatus intValue];
        }
        otaModel.otaStatus = otaStatus;
        otaModel.planId = [NSString stringWithFormat:@"%lld", model.planId];
        
        NSMutableArray *comArray = [NSMutableArray array];
        for (QuecOTAComponetModel *com in model.comVerList) {
            QuecComOTAPlanModel *comPlan = [[QuecComOTAPlanModel alloc] init];
            comPlan.comName = com.comType == 0 ? @"模组" : @"MCU";
            comPlan.comTargetVerion = com.tver;
            [comArray addObject:comPlan];
        }
        otaModel.comArray = comArray;
        
        if (completion) {
            completion(otaModel, nil);
        }
    } failure:^(NSError *error) {
        NSError *err = error ?: [NSError errorWithDomain:@"" code:-1 userInfo:nil];
        if (completion) {
            completion(nil, err);
        }
    }];
    
}

- (void)uploadDeviceState {
    for (NSString *classNameKey in self.delegates.allKeys) {
        quec_async_on_main(^{
            void (^block)(void) = [self.delegates quec_safeObjectForKey:classNameKey];
            if (block) {
                block();
            }
        });
    }
}

- (void)cleanFailAndSuccessState {
    NSDictionary *statePool = self.deviceStatePool.copy;
    if (statePool.allKeys.count == 0) {
        return;
    }
    NSArray *statePoolArray = statePool.allValues;
    for (QuecDeviceOTAStateModel *value in statePoolArray) {
        if (value.state == 3 || value.state == 2 || value.state == 4) {
            [self.deviceStatePool removeObjectForKey:quec_deviceId(value.pk, value.dk)];
        }
    }
}

- (int)readDeviceStateWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey planId:(NSString *)planId {
    QuecDeviceOTAStateModel *stateModel = [self.deviceStatePool quec_safeObjectForKey:quec_deviceId(productKey, deviceKey)];
    if (!stateModel) {
        return 0;
    }
        
    return (stateModel.userConfirmStatus == 1 && stateModel.state == 0) ? 1 : stateModel.state;
}

- (float)readDeviceUpdateProgressWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey {
    QuecDeviceOTAStateModel *stateModel = [self.deviceStatePool quec_safeObjectForKey:quec_deviceId(productKey, deviceKey)];
    if (!stateModel) {
        return 0.0;
    }
    
    if (stateModel.state == 1) {
        return stateModel.upgradeProgress;
    }
        
    return 0.0;
}

@end

@implementation QuecDeviceOTAStateModel

@end
