//
//  QuecLogConfig.h
//  QuecLogKit
//
//  Created by quectel.steven on 2022/1/26.
//

#import <Foundation/Foundation.h>

@interface QuecLogConfig : NSObject

typedef NS_ENUM(int, QuecLogAppenderMode) {
    QuecLogAppenderModeAsync = 0, //异步
    QuecLogAppenderModeSync = 1,  //同步
};

typedef NS_ENUM(int, QuecLogLevel) {
    QuecLogLevelAll = 0,
    QuecLogLevelVerbose = 0,
    QuecLogLevelDebug,
    QuecLogLevelInfo,
    QuecLogLevelWarn,
    QuecLogLevelError,
    QuecLogLevelFatal,
    QuecLogLevelNone,
};

typedef NS_ENUM(int, QuecLogComprassMode) {
    QuecLogComprassModeZlib = 0, //zlib
    QuecLogComprassModeZstd = 1, //zstd
};

// 记录模式
@property (nonatomic, assign) QuecLogAppenderMode mode;
// 记录日志的最低级别
@property (nonatomic, assign) QuecLogLevel level;
// 压缩模式
@property (nonatomic, assign) QuecLogComprassMode comprassMode;
// 日志文件夹路径
@property (nonatomic, copy) NSString *logdir;
// 日志文件名前缀
@property (nonatomic, copy) NSString *nameprefix;
// 加密公钥
@property (nonatomic, copy) NSString *pub_key;
// Zstd 压缩级别 1-9
@property (nonatomic, assign) int compress_level;
// 缓存日志文件夹路径
@property (nonatomic, copy) NSString *cachedir;
// 缓存日志天数
@property (nonatomic, assign) int cache_days;
// 是否开启控制台打印
@property (nonatomic, assign) BOOL consoleLogOpen;

@end

