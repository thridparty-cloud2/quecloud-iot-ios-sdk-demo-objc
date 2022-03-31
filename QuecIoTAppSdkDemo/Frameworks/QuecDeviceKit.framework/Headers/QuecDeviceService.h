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

/**
 获取设备列表
 
 @param pageNumber 页码
 @param pageSize 页大小
 @param success success block
 @param failure failure block
 */
- (void)getDeviceListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

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
- (void)getDeviceBusinessAttributesWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey codeList:(NSString *)codeList type:(NSString *)type  success:(void (^)(QuecProductTSLInfoModel *))success failure:(QuecErrorBlock)failure;

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

@end

@interface QuecDeviceService (Control)

/**
 设备控制
 
 @param data 遵循tsl格式的json string 属性：[{"id":62,"value":99,"type":"INT","name":"温度(temp)"},{"id":63,"value":"true","type":"BOOL","name":"开关机状态(powerstate)"},{"id":64,"value":"0.0","type":"FLOAT","name":"容量(size)"},{"id":65,"value":"0.0","type":"DOUBLE","name":"当前容量(currentSize)"},{"id":66,"value":"0","type":"ENUM","name":"工作状态(state)"},{"id":67,"name":"当前工作状态","type":"TEXT","value":"1"},{"id":68,"value":1632758400000,"type":"DATE","name":"加热时间(hotTime)"},{"id":70,"name":"滤芯数组","type":"ARRAY","value":[{"id":0,"name":"","type":"STRUCT","value":[{"id":1,"name":"状态","type":"BOOL","value":"faulse"}]}]},{"id":69,"name":"特征值","type":"STRUCT","value":[{"id":1,"name":"名称","type":"TEXT","value":"${input_data}"},{"id":2,"name":"版本","type":"TEXT","value":"${input_data}"}]}]；服务：[{"id":74,"value":[{"id":62,"value":80,"type":"INT","name":"温度(temp)"},{"id":68,"value":1632758400000,"type":"DATE","name":"加热时间(hotTime)"}]}]

 @param deviceKey 设备key
 @param productKey 产品key
 @param type 类型 1：透传 2：属性 3：服务
 @param dataFormat 数据类型 1：Hex 2：Text（当type为透传时，需要指定 dataFormat）
 @param success success block
 @param failure failure block
 */
- (void)sendDataToDeviceByHttpWithData:(NSString *)data deviceKey:(NSString *)deviceKey productKey:(NSString *)productKey type:(NSInteger)type dataFormat:(NSInteger )dataFormat success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;


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
- (void)acceptShareByShareUserWithShareCode:(NSString *)shareCode success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

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
 @param success success block
 @param failure failure block
 */
- (void)getDeviceListWithDeviceGroupId:(NSString *)deviceGroupId deviceGroupName:(NSString *)deviceGroupName deviceKeyList:(NSString *)deviceKeyList productKey:(NSString *)productKey success:(void(^)(NSArray<NSDictionary *> *data, NSInteger total))success failure:(QuecErrorBlock)failure;

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

@end
