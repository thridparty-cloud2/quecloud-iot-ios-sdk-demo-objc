//
//  QuecLogHelper.h
//  QuecLogKit
//
//  Created by quectel.steven on 2022/1/27.
//

#import <Foundation/Foundation.h>
#import "QuecLogConfig.h"

@interface QuecLogHelper : NSObject

+ (void)setupLogWithConfig:(QuecLogConfig *)config;

+ (void)closeLog;

+ (void)logWithLevel:(int)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message;

+ (void)logWithLevel:(int)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ...;

+ (BOOL)shouldLog:(int)level;

@end

#define __FILENAME__ (strrchr(__FILE__,'/')+1)

#define LogInternal(level, module, file, line, func, prefix, format, ...) \
do { \
    if ([QuecLogHelper shouldLog:level]) { \
        NSString *aMessage = [NSString stringWithFormat:@"%@%@", prefix, [NSString stringWithFormat:format, ##__VA_ARGS__, nil]]; \
        [QuecLogHelper logWithLevel:level moduleName:module fileName:file lineNumber:line funcName:func message:aMessage]; \
    } \
} while(0)




