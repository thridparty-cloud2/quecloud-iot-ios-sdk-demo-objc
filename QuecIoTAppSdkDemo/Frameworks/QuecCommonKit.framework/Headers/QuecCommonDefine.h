//
//  QuecCommonDefine.h
//  QuecCommonKit
//
//  Created by quectel.steven on 2021/9/24.
//

#ifndef QuecCommonDefine_h
#define QuecCommonDefine_h
#import <Foundation/Foundation.h>

typedef void(^QuecErrorBlock)(NSError *error);
typedef void(^QuecVoidBlock)(void);
typedef void (^QuecArrayBlock) (NSArray *array);
typedef void (^QuecDictionaryBlock) (NSDictionary *dictionary);
typedef void(^QuecBOOLBlock)(BOOL result);
typedef void(^QuecIntBlock)(int result);
typedef void(^QuecIDBlock)(id result);
typedef void(^QuecDataBlock)(NSData *result);
typedef void(^QuecStringBlock)(NSString *result);
typedef void(^QuecLongLongBlock)(long long result);

// 设备sdk token 过期 通知用户sdk刷新
extern NSString * const QuecWebSocketRefreshingToken;
// 用户sdk刷新token 回调设备sdk
extern NSString * const QuecWebSocketRefreshingTokenResponse;


#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif
