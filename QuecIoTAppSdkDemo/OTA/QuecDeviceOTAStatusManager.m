//
//  QuecDeviceOTAStatusManager.m
//  QuecIoTAppSdkDemo
//
//  Created by Leo Xue(薛昭) on 2024/11/12.
//

#import "QuecDeviceOTAStatusManager.h"

static id _instance = nil;

@interface QuecDeviceOTAStatusManager()

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
        
    }
    return self;
}

@end
