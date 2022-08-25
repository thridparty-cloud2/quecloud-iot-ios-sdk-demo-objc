//
//  QuecDeviceService.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/9/29.
//

#import <Foundation/Foundation.h>
#import <QuecCommonKit/QuecCommonKit.h>
#import "QuecDeviceModel.h"
#import "QuecProductTSLModel.h"
#import "QuecProductTSLInfoModel.h"
#import "QuecShareUserModel.h"
#import "QuecDeviceGroupParamModel.h"
#import "QuecDeviceGroupInfoModel.h"
#import "QuecWebSocketDataModel.h"
#import "QuecDeviceOTAQueryModel.h"
#import "QuecDeviceOTAPlanModel.h"
#import "QuecWebSocketActionModel.h"
#import "QuecLocationHistoryModel.h"
#import "QuecPropertyDataListModel.h"
#import "QuecCornJobModel.h"


@protocol QuecDeviceServiceWebSocketDelegate <NSObject>

@optional
- (void)quecWebSocketDidOpen;
- (void)quecWebSocketDidCloseWithCode:(NSInteger)code reason:(NSString *)reason;
- (void)quecWebSocketDidReceiveMessageWithDataModel:(QuecWebSocketDataModel *)dataModel;
- (void)quecWebSocketDidFailWithError:(NSError *)error;

@end

@interface QuecDeviceService : NSObject

/**
 @return return a single instance
 */
+ (instancetype)sharedInstance;

// webSocket 是否开启
@property (nonatomic, assign) BOOL webSocketLogin;

/**
 获取设备列表
 
 @param pageNumber 页码
 @param pageSize 页大小
 @param success success block
 @param failure failure block
 */
- (void)getDeviceListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;
/**
 获取设备列表-根据设备名称搜索
 @param deviceName 设备名称
 @param pageNumber 页码
 @param pageSize 页大小
 @param success success block
 @param failure failure block
 */
- (void)getDeviceListByDeviceName:(NSString *)deviceName pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

/**
 通过SN绑定设备
 
 @param serialNumber 设备SN码
 @param productKey 产品key
 @param deviceName 设备名称
 @param success success block
 @param failure failure block
 */
- (void)bindDeviceBySerialNumber:(NSString *)serialNumber productKey:(NSString *)productKey deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 通过authCode绑定设备
 可用于wifi/wifi+蓝牙设备绑定
 
 @param authCode 设备authCode
 @param productKey 产品key
 @param deviceKey 设备key
 @param deviceName 设备名称
 @param success success block
 @param failure failure block
 */
- (void)bindDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 通过authCode + password绑定设备
 可用于蓝牙设备绑定
 
 @param authCode 设备authCode
 @param productKey 产品key
 @param deviceKey 设备key
 @param password 设备password
 @param deviceName 设备名称
 @param success success block
 @param failure failure block
 */
- (void)bindDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey password:(NSString *)password deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 设备解绑
 
 @param deviceKey device key
 @param productKey product key
 @param success success block
 @param failure failure block
 */
- (void)unbindDeviceWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 设备重命名
 
 @param deviceKey device key
 @param productKey product key
 @param success success block
 @param failure failure block
 */
- (void)updateDeviceName:(NSString *)deviceName productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 获取设备详情
 
 @param deviceKey device key
 @param productKey product key
 @param success success block
 @param failure failure block
 */
- (void)getDeviceInfoByDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(QuecDeviceModel *model))success failure:(QuecErrorBlock)failure;

/**
 获取设备物模型
 
 @param productKey 产品key
 @param success success block
 @param failure failure block
 */
- (void)getProductTSLWithProductKey:(NSString *)productKey success:(void(^)(QuecProductTSLModel *tslModel))success failure:(QuecErrorBlock)failure;

/**
 获取设备业务属性值
 
 @param productKey 产品key
 @param deviceKey 设备key
 @param gatewayDk 网关设备的 Device Key
 @param gatewayPk 网关设备的 Product Key
 @param codeList 查询的属性标识符
 和查询类型配合使用，如果查询多个属性，使用英文逗号分隔
 @param type 查询类型
 1 查询设备基础属性
 2 查询物模型属性
 3 查询定位信息
 查询类型可以单选和多选，如果需要查询多个类型的属性值，使用英文逗号分隔
 @param success success block
 @param failure failure block
 */
- (void)getDeviceBusinessAttributesWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey gatewayPk:(NSString *)gatewayPk gatewayDk:(NSString *)gatewayDk codeList:(NSString *)codeList type:(NSString *)type  success:(void (^)(QuecProductTSLInfoModel *))success failure:(QuecErrorBlock)failure;

/**
 查询设备升级信息
 
 @param productKey 产品key
 @param deviceKey 设备key
 @param extraInfo 其他信息
 @param success success block
 @param failure failure block
 */
- (void)getFetchPlanWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey extraInfo:(QuecDeviceOTAQueryModel *)extraInfo success:(void(^)(QuecDeviceOTAPlanModel *planModel))success failure:(QuecErrorBlock)failure;

/**
 上报设备升级信息
 
 @param productKey 产品key
 @param deviceKey 设备key
 @param componentNo 升级固件标识
 @param reportStatus 升级状态 0 - 12
 @param success success block
 @param failure failure block
 */
- (void)reportDeviceUpgradeStatusWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey componentNo:(NSString *)componentNo reportStatus:(NSInteger)reportStatus success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 
 获取设备历史轨迹
 
 @param productKey 产品key
 @param deviceKey 设备key
 @param startTimestamp 开始时间（毫秒时间戳）
 @param endTimestamp 结束时间（毫秒时间戳）
 @param gatewayDk 网关设备的 Device Key
 @param gatewayPk 网关设备的 Product Key
 @param locateTypes 定位类型（默认查询所有类型的定位），查询多种定位时使用英文逗号分隔
    GNSS-全球导航卫星系统
    GPS-美国导航定位系统
    GL-俄罗斯格洛纳导航定位系统
    GA-欧盟伽利略卫星导航系统
    BD/PQ-中国导航定位系统
    LBS-基于通信运营商的基站定位系统
 @param success success block
 @param failure failure block
 */
- (void)getLocationHistoryWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey startTimestamp:(NSInteger)startTimestamp endTimestamp:(NSInteger)endTimestamp gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk locateTypes:(NSString *)locateTypes success:(void(^)(NSArray<QuecLocationHistoryModel *> *list))success failure:(QuecErrorBlock)failure;

/**
 获取设备属性图表列表
 
 @param productKey 产品key
 @param deviceKey 设备key
 @param startTimestamp 开始时间（毫秒时间戳）
 @param endTimestamp 结束时间（毫秒时间戳）
 @param attributeCode 物模型属性标识符，查询多个属性时使用英文逗号分隔
 @param gatewayDk 网关设备的 Device Key
 @param gatewayPk 网关设备的 Product Key
 @param countType 聚合类型（默认3）：1-最大值 2-最小值 3-平均值 4-差值
 @param timeGranularity 统计时间粒度（默认2）：1-月 2-日 3-小时 4-分钟 5-秒
 @param success success block
 @param failure failure block
 */
- (void)getPropertyChartListWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey startTimestamp:(NSInteger)startTimestamp endTimestamp:(NSInteger)endTimestamp attributeCode:(NSString *)attributeCode gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk countType:(NSInteger)countType timeGranularity:(NSInteger)timeGranularity success:(void(^)(NSArray *dataArray))success failure:(QuecErrorBlock)failure;

/**
 
 获取设备属性环比统计数据
 
 @param productKey 产品key
 @param deviceKey 设备key
 @param currentTimestamp 当前时间（毫秒时间戳
 @param attributeCode 物模型属性标识符，查询多个属性时使用英文逗号分隔
 @param gatewayDk 网关设备的 Device Key
 @param gatewayPk 网关设备的 Product Key
 @param countType 聚合类型（默认3）：1-最大值 2-最小值 3-平均值 4-差值
 @param timeGranularities 统计时间粒度，查询多个粒度时使用英文逗号分隔（默认1）：1-日 2-周 3-月 4-年
 @param success success block
 @param failure failure block
 */
- (void)getPropertyStatisticsPathWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey currentTimestamp:(NSInteger)currentTimestamp attributeCode:(NSString *)attributeCode gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk countType:(NSInteger)countType timeGranularities:(NSString *)timeGranularities success:(void(^)(NSArray *dataArray))success failure:(QuecErrorBlock)failure;

/**
 
 获取设备属性数据列表
 
 @param productKey 产品key
 @param deviceKey 设备key
 @param startTimestamp 开始时间（毫秒时间戳）
 @param endTimestamp 结束时间（毫秒时间戳）
 @param attributeCode 物模型属性标识符，查询多个属性时使用英文逗号分隔
 @param gatewayDk 网关设备的 Device Key
 @param gatewayPk 网关设备的 Product Key
 @param pageNumber 当前页，默认为第 1 页
 @param pageSize 页大小，默认为 10 条
 @param success success block
 @param failure failure block
 */
- (void)getPropertyDataListWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey startTimestamp:(NSInteger)startTimestamp endTimestamp:(NSInteger)endTimestamp attributeCode:(NSString *)attributeCode gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecPropertyDataListModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

@end

@interface QuecDeviceService (Control)

/**
 设备批量控制
 
 @param data 遵循tsl格式的json string
 @param deviceList 设备列表 [{"pkdk":{"deviceKey":"", "productKey":""}}]
 @param type 类型 1：透传 2：属性 3：服务
 @param dataFormat 数据类型 1：Hex 2：Text（当type为透传时，需要指定 dataFormat）
 @param success success block
 @param failure failure block
 */
- (void)sendDataToDevicesByHttpWithData:(NSString *)data deviceList:(NSArray *)deviceList type:(NSInteger)type dataFormat:(NSInteger )dataFormat success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

@end

@interface QuecDeviceService (WebSocket)


/**
 获取websocket是否开启
 
 @return return BOOL
 */
- (BOOL)isWebSocketOpen;

/**
 打开websocket
 */
- (void)openWebSocket;

/**
 关闭websocket
 */
- (void)closeWebSocket;

/**
 获取设备业务属性值
 
 @param dataModel 发送数据，需要在delegate的websocketDidOpen回调之后才能调用
 */
- (void)sendDataToDeviceByWebSocketWithDataModel:(QuecWebSocketDataModel *)dataModel;


/**
 订阅设备
 
 @param list 订阅设备列表，订阅结果QuecDeviceServiceWebSocketDelegate返回
 */
- (void)subscribeDevicesWithList:(NSArray<QuecWebSocketActionModel *> *)list;

/**
 取消订阅设备
 
 @param list 取消订阅设备列表，取消订阅结果QuecDeviceServiceWebSocketDelegate返回
 */
- (void)unSubscribeDevicesWithList:(NSArray<QuecWebSocketActionModel *> *)list;


/**
 设备websocket回调
 
 @param delegate 遵循QuecDeviceServiceWebSocketDelegate的对象
 */
- (void)setWebScoketDelegate:(id<QuecDeviceServiceWebSocketDelegate>)delegate;

@end

@interface QuecDeviceService (Share)

/**
 通过分享码查询设备信息
 
 @param shareCode 分享码
 @param success success block
 @param failure failure block
 */
- (void)getDeviceInfoByShareCode:(NSString *)shareCode success:(void(^)(QuecDeviceModel *deviceModel))success failure:(QuecErrorBlock)failure;

/**
 更改分享设备名称
 
 @param deviceName 设备名称
 @param shareCode 分享码
 @param success success block
 @param failure failure block
 */
- (void)updateDeviceNameByShareUserWithDeviceName:(NSString *)deviceName shareCode:(NSString *)shareCode success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 获取设备分享人列表
 
 @param deviceKey 设备名称
 @param productKey 产品key
 @param success success block
 @param failure failure block
 */
- (void)getDeviceShareUserListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(NSArray<QuecShareUserModel *> *list))success failure:(QuecErrorBlock)failure;

/**
 分享人取消分享
 
 @param shareCode 分享码
 @param success success block
 @param failure failure block
 */
- (void)unShareDeviceByOwnerWithShareCode:(NSString *)shareCode success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 被分享人取消分享
 
 @param shareCode 分享码
 @param success success block
 @param failure failure block
 */
- (void)unShareDeviceByShareUserWithShareCode:(NSString *)shareCode success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 被分享人接受分享
 
 @param shareCode 分享码
 @param success success block
 @param failure failure block
 */
- (void)acceptShareByShareUserWithShareCode:(NSString *)shareCode deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 分享人设置分享信息
 
 @param deviceKey 设备key
 @param productKey 产品key
 @param acceptingExpireTime 分享二维码种子失效时间 时间戳（毫秒），表示该分享在此时间戳时间内没有使用，会失效
 @param coverMark 覆盖标志:1 直接覆盖上条有效分享（默认）（覆盖原有的分享码）；2 直接添加，允许多条并存；3 只有分享时间延长了，才允许覆盖上条分享
 @param isSharingAlwaysValid 设备是否永久有效
 @param sharingExpireTime 设备使用到期时间 时间戳（毫秒），表示该分享的设备，被分享人可以使用的时间，isSharingAlwaysValid为YES时该参数无效
 @param success success block
 @param failure failure block
 */
- (void)setShareInfoByOwnerWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey acceptingExpireTime:(NSInteger)acceptingExpireTime coverMark:(NSInteger)coverMark
    isSharingAlwaysValid:(BOOL)isSharingAlwaysValid
    sharingExpireTime:(NSInteger)sharingExpireTime success:(void(^)(NSString *shareCode))success failure:(QuecErrorBlock)failure;

@end


@interface QuecDeviceService (Group)

/**
 获取分组列表
 
 @param pageNumber 页码
 @param pageSize 页数据数量
 @param success success block
 @param failure failure block
 */
- (void)getDeviceGroupListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize extra:(QuecDeviceGroupParamModel *)infoModel success:(void(^)(NSArray<QuecDeviceGroupInfoModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

/**
 添加设备分组
 
 @param groupInfoModel 分组信息
 @param success success block
 @param failure failure block
 */
- (void)addDeviceGroupWithInfo:(QuecDeviceGroupParamModel *)groupInfoModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;


/**
 修改设备组
 
 @param deviceGroupId 分组id
 @param infoModel 分组信息
 @param success success block
 @param failure failure block
 */
- (void)updateDeviceGroupInfoWithDeviceGroupId:(NSString *)deviceGroupId infoModel:(QuecDeviceGroupParamModel *)infoModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 删除设备组
 
 @param deviceGroupId 分组id
 @param success success block
 @param failure failure block
 */
- (void)deleteDeviceGroupWithDeviceGroupId:(NSString *)deviceGroupId success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;


/**
 获取分组详情
 
 @param deviceGroupId 分组id
 @param success success block
 @param failure failure block
 */
- (void)getDeviceGroupInfoWithDeviceGroupId:(NSString *)deviceGroupId success:(void(^)(QuecDeviceGroupInfoModel *model))success failure:(QuecErrorBlock)failure;


/**
 获取分组设备列表
 
 @param deviceGroupId 分组id
 @param deviceGroupName 分组名称
 @param deviceKeyList  device key列表，多个device key，使用英文逗号分隔
 @param productKey 产品key
 @param pageNumber 当前页，默认为第 1 页
 @param pageSize 页大小，默认为 10 条
 @param success success block
 @param failure failure block
 */
- (void)getDeviceListWithDeviceGroupId:(NSString *)deviceGroupId deviceGroupName:(NSString *)deviceGroupName deviceKeyList:(NSString *)deviceKeyList productKey:(NSString *)productKey pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void (^)(NSArray<NSDictionary *> *, NSInteger))success failure:(void (^)(NSError *))failure;

/**
 设备添加到设备组中
 
 @param deviceGroupId 分组id
 @param deviceList 设备列表，示例：[{"dk": "string","pk": "string"}]
 @param success success block
 @param failure failure block
 */
- (void)addDeviceToGroupWithDeviceGroupId:(NSString *)deviceGroupId deviceList:(NSArray *)deviceList success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

/**
 删除分组中的设备
 
 @param deviceGroupId 分组id
 @param deviceList 设备列表，示例：[{"dk": "string","pk": "string"}]
 @param success success block
 @param failure failure block
 */
- (void)deleteDeviceFromGroupWithDeviceGroupId:(NSString *)deviceGroupId deviceList:(NSArray *)deviceList success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

/**
 查询设备分组列表
 
 @param deviceKey 设备key
 @param productKey 产品key
 @param success success block
 @param failure failure block
 */
- (void)getDeviceGroupListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(NSArray<QuecDeviceGroupInfoModel *> *list))success failure:(QuecErrorBlock)failure;
/**
 查询网关设备下子设备列表
 @param deviceKey 网关设备deviceKey
 @param productKey 网关设备productKey
 @param pageNumber 页码
 @param pageSize 页大小
 @param success success block
 @param failure failure block
 */
- (void)getGatewayDeviceChildListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

/**
 查询不在设备组内的设备列表
 @param pageNumber 页码
 @param pageSize 页大小
 @param success success block
 @param failure failure block
 */
- (void)getDeviceListByNotInDeviceGroupWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize groupId:(NSString *)groupId success:(void(^)(NSArray <QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

/**
 创建定时任务
 @param cornJobModel QuecCornJobModel
 @param success success block
 @param failure failure block
 */
- (void)addCornJobWithCornJobModel:(QuecCornJobModel *)cornJobModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**
 修改定时任务
 @param cornJobModel QuecCornJobModel
 @param success success block
 @param failure failure block
 */
- (void)setCronJobWithCornJobModel:(QuecCornJobModel *)cornJobModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

/**

 查询设备下定时任务列表
 @param productKey 产品key
 @param deviceKey 设备key
 @param type 定时任务类型，once: 执行一次，day-repeat: 每天重复，custom-repeat: 自定义重复，multi-section: 多段执行，random: 随机执行，delay: 延迟执行（倒计时）
 @param pageNumber 分页页码，默认: 1
 @param pageSize 分页大小，默认: 10
 @param success success block
 @param failure failure block
 */
- (void)getCronJobListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey type:(NSString *)type pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecCornJobModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

/**

 查询定时任务详情
 @param ruleId 定时任务ID
 @param success success block
 @param failure failure block
 */
- (void)getCronJobInfoWithRuleId:(NSString *)ruleId success:(void(^)(QuecCornJobModel *))success failure:(QuecErrorBlock)failure;

/**
 批量删除定时任务
 @param params  {ruleIdList:[String 定时任务ID数组]}
 @param success success block
 @param failure failure block
 */
- (void)batchDeleteCronJobWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

/**
 查询产品下定时任务限制数
 @param productKey 产品key
 @param success success block
 @param failure failure block
 */
- (void)getProductCornJobLimitWithProductKey:(NSString *)productKey success:(void(^)(NSInteger limit))success failure:(QuecErrorBlock)failure;

@end
