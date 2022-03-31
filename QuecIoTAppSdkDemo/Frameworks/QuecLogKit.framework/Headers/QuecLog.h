//
//  QuecLog.h
//  QuecLogKit
//
//  Created by quectel.steven on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import "QuecLogConfig.h"
#import "QuecLogHelper.h"

#define QuecLogError(format, ...) LogInternal(4, "XLog", __FILENAME__, __LINE__, __FUNCTION__, @"[E]", format, ##__VA_ARGS__)
#define QuecLogWarn(format, ...) LogInternal(3, "XLog", __FILENAME__, __LINE__, __FUNCTION__, @"[W]", format, ##__VA_ARGS__)
#define QuecLogInfo(format, ...) LogInternal(2, "XLog", __FILENAME__, __LINE__, __FUNCTION__, @"[I]", format, ##__VA_ARGS__)
#define QuecLogDebug(format, ...) LogInternal(1, "XLog", __FILENAME__, __LINE__, __FUNCTION__, @"[D]", format, ##__VA_ARGS__)
#define QuecLogVerbose(format, ...) LogInternal(0, "XLog", __FILENAME__, __LINE__, __FUNCTION__, @"[V]", format, ##__VA_ARGS__)

@interface QuecLog : NSObject

// 初始化xlog
+ (void)setupLogWithConfig:(QuecLogConfig *)config;

// 关闭xlog
+ (void)closeLog;

@end

