//
//  QuecCornJobModel.h
//  QuecDeviceKit
//
//  Created by quectel.tank on 2022/7/25.
//

#import <Foundation/Foundation.h>

@interface QuecCornTimersModel : NSObject

// 定时任务执行的命令，格式：物模型的 json 字符串
@property (nonatomic, copy) NSString *action;
// 延迟执行时间，单位为秒, 当 type = delay 时必填，单位为 s
@property (nonatomic, assign) NSInteger delay;
// 当 type 为 random 时必填，格式为 "HH:mm:ss"，如 "12:00:00"
@property (nonatomic, copy) NSString *endTime;
// 当 type 为 random 时必填，格式为 "HH:mm:ss"，如 "12:00:00"
@property (nonatomic, copy) NSString *startTime;
// 执行时间，格式为 HH:mm:ss, 当 type = once || day-repeat || custom-repeat || multi-section 时必填
@property (nonatomic, copy) NSString *time;

@end

@interface QuecCornJobModel : NSObject

// 产品key
@property (nonatomic, copy) NSString *productKey;
// 设备key
@property (nonatomic, copy) NSString *deviceKey;
// 规则唯一标识，修改规则实例信息时必填
@property (nonatomic, copy) NSString *ruleId;
// 定时任务类型，once: 执行一次，day-repeat: 每天重复，custom-repeat: 自定义重复，multi-section: 多段执行，random: 随机执行，delay: 延迟执行（倒计时）
@property (nonatomic, copy) NSString *type;
// 定时任务状态：false-停止（默认） true-启动
@property (nonatomic, assign) BOOL enabled;
// 周几执行：1-周一 2-周二 3-周三 4-周四 5-周五 6-周六 7-周日, 可以多选，传多个值时使用英文逗号分隔, 当 type = custom-repeat || multi-section || random 时必填
@property (nonatomic, copy) NSString *dayOfWeek;

@property (nonatomic, strong) NSArray<QuecCornTimersModel *> *timers;

@end


