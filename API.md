
### IoT SDK API简介

#### QuecIoTAppSDK

#### 初始化SDK
```
//该接口执行后，其他接口功能才能正常执行

typedef NS_ENUM(NSUInteger, QuecCloudServiceType) { //云服务类型
    QuecCloudServiceTypeChina = 0, //国内
    QuecCloudServiceTypeEurope,    //欧洲
};

- (void)startWithUserDomain:(NSString *)userDomain userDomainSecret:(NSString *)userDomainSecret cloudServiceType:(QuecCloudServiceType)cloudServiceType;
```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| userDomain |	是|用户域，DMP平台创建APP生成	| 
| userDomainSecret |	是|用户域秘钥，DMP平台创建APP生成	| 
| cloudServiceType |	是|云服务类型，指定连接的云服务| 

#### 更改debug模式

```
//在开发的过程中可以开启Debug模式，打印日志用于分析问题。
- (void)setDebugMode:(BOOL)debugMode;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| debugMode |	是|更改debug状态	| 


#### 账户管理相关（QuecUserService）
####  设置token过期回调
```
- (void)setTokenInvalidCallBack:(void(^)(void))callBack;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| callBack |	否|token过期回调| 

####  获取token
```
- (NSString *)getToken;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 

#### 获取国家列表
```
- (void)getNationalityListWithSuccess:(void(^)(NSArray *list))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 获取时区列表

```
- (void)getTimezoneListWithSuccess:(void(^)(NSArray *list))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 获取语言列表

```
- (void)getLanguageListWithSuccess:(void(^)(NSArray *list))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 查询手机号是否已注册

```
- (void)queryPhoneIsRegister:(NSString *)phone internationalCode:(NSString *)internationalCode success:(void(^)(BOOL isRegister))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| phone |	是|手机号码| 
| internationalCode |	否|国际代码，默认为国内| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 邮箱密码登录

```
- (void)loginByEmail:(NSString *)email password:(NSString *)password success:(void(^)())success failure:(void(^)(NSError *error))failure;

```
|参数|	是否必传|说明|	
| --- | --- | --- | 
| email |	是|邮箱| 
| password |	是|密码| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 邮箱密码注册

```
- (void)registerByEmail:(NSString *)email code:(NSString *) code password:(NSString *)password nationality:(NSInterger) nationality lang:(NSInterger)lang timezone:(NSInterger) timezone success:(void(^)())success failure:(void(^)(NSError *error))failure;

```
|参数|	是否必传|说明|	
| --- | --- | --- | 
| email |	是|邮箱| 
| code |	是|验证码| 
| password |	是|密码| 
| nationality |	否|国家| 
| lang |	否|语言| 
| timezone |	否|时区| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 发送邮箱验证码

```
- (void)sendVerifyCodeByEmail:(NSString *)email type:(NSInteger)type success:(void(^)())success failure:(void(^)(NSError *error))failure;

```
|参数|	是否必传|说明|	
| --- | --- | --- | 
| email |	是|邮箱| 
| type |是|类型, 1: 注册验证码, 2: 密码重置验证码| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 手机号密码登录

```
- (void)loginByPhone:(NSString *)phone password:(NSString *)password internationalCode:(NSString *)internationalCode  success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| phone |	是|手机号码| 
| internationalCode |	否|国际代码，默认为国内| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 手机号验证码登录

```
- (void)loginWithMobile:(NSString *)mobile code:(NSString *) code internationalCode:(NSString *)internationalCode  success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| mobile |	是|手机号	| 
| password |	是|密码	| 
| internationalCode |	否|国际代码，默认为国内	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 手机号密码注册

```
- (void)registerByPhone:(NSString *)phone code:(NSString *) code password:(NSString *)password internationalCode:(NSString *)internationalCode nationality:(NSInterger) nationality lang:(NSInterger)lang timezone:(NSInterger) timezone success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| phone |	是|手机号| 
| code |	是|验证码| 
| password |	是|密码| 
| internationalCode |	否|国际代码，默认为国内| 
| nationality |	否|国家| 
| lang |	否|语言| 
| timezone |	否|时区| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 发送手机验证码

```
- (void)sendVerifyCodeByPhone:(NSString *)phone
            internationalCode:(NSString *)internationalCode
                         type:(NSInteger)type
                         ssid:(NSString *)ssid
                         stid:(NSString *)stid
            success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```
|参数|	是否必传|说明|	
| --- | --- | --- | 
| phone |	是|手机号| 
| internationalCode |是|国际代码| 
| type |是|类型, 1: 注册验证码, 2: 密码重置验证码, 3: 登录验证码代码| 
| ssid |是|短信签名ID，DMP创建，不传使用系统默认| 
| stid |是|短信模板ID，DMP创建，不传使用系统默认| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 验证国际手机号格式

```
- (void)validateInternationalPhone:(NSString *)phone internationalCode:(NSString *)internationalCode success:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

```
|参数|	是否必传|说明|	
| --- | --- | --- | 
| phone |	是|手机号| 
| internationalCode |是|国际代码| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 验证短信验证码

```
- (void)validateSmsCode:(NSString *)phone smsCode:(NSString *)smsCode internationalCode:(NSString *)internationalCode type:(NSInteger)type success:(void(^)())success failure:(void(^)(NSError *error))failure;

```
|参数|	是否必传|说明|	
| --- | --- | --- | 
| phone |	是|手机号| 
| smsCode |	是|验证码| 
| internationalCode |	否|国际代码| 
| type |否|验证码验证后是否失效，1：失效 2：不失效，默认 1| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 


#### 修改手机号

```
- (void)updatePhone:(NSString *)newPhone newInternationalCode:(NSString *)newInternationalCode newPhoneCode:(NSString *)newPhoneCode oldPhone:(NSString *)oldPhone oldInternationalCode:(NSString *)oldInternationalCode oldPhoneCode:(NSString *)oldPhoneCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| newPhone |	是|新手机号码| 
| newInternationalCode |	是|新手机号码国际代码| 
| newPhoneCode |	是|新手机号码接收到的验证码| 
| oldPhone |	是|原手机号码| 
| oldInternationalCode |	是|原手机号码国际代码| 
| oldPhoneCode |	是|原手机号码接收到的验证码| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 修改用户地址

```
- (void)updateUserAddress:(NSString *)address success:(void(^)(void))success failure:(void(^)(NSError *error))failure;


```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| address |	否| 地址 | 
| headImage |	否|头像| 
| lang |	否|语言| 
| nationality |	否|国家| 
| nikeName |	否|昵称| 
| sex |	否|性别 0：男 1：女 2：保密|
| timezone |	否|时区|  
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


#### 修改用户头像

```
- (void)updateUserHeadIcon:(UIImage *)headImage success:(void(^)(void))success failure:(void(^)(NSError *error))failure;


```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| headImage |	是|头像| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


#### 修改语言

```
- (void)updateLangWithLangId:(NSInteger)langId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;


```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| langId |	是|语言Id|  
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 修改用户昵称

```
- (void)updateUserNickName:(NSString *)nikeName success:(void(^)(void))success failure:(void(^)(NSError *error))failure;


```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| nikeName |	是|昵称|  
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 修改用户性别

```
- (void)updateUserSex:(NSInteger)sex success:(void(^)(void))success failure:(void(^)(NSError *error))failure;


```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| sex |	是|性别 0：男 1：女 2：保密|  
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 修改用户时区

```
- (void)updateUserTimeZoneWithTimeZoneId:(NSInteger)timeZoneId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| timeZoneId |	是|时区Id|  
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 修改用户国家

```
- (void)updateUserNationLityWithNationalityId:(NSInteger)nationalityId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| nationalityId |	是|国家Id|  
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 修改密码

```
- (void)updatePassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| newPassword |	是| 新密码 | 
| oldPassword |	是|原密码|  
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 删除用户

```
- (void)deleteUser:(NSInterger)type success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| type |	否| 删除类型：1- 立即删除 2- 7天后删除，默认为 7 天后删除 |
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 用户信息读取

```
- (void)getUserInfoWithSuccess:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 用户退出登录

```
- (void)logoutWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 用户通过手机号+验证码重置密码

```
- (void)resetPasswordByPhone:(NSString *)phone code:(NSString *)code internationalCode:(NSString *)internationalCode password:(NSString *)password success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| code |	是|验证码	|
| phone |	否|手机号码	|
| internationalCode |	否|国际代码，配合手机号码使用，默认为国内	|
| password |	否|用户重置的密码，如果不输入默认为 12345678求成功回调	|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 用户通过邮箱+验证码重置密码

```
- (void)resetPasswordByEmail:(NSString *)email code:(NSString *)code internationalCode:(NSString *)internationalCode password:(NSString *)password success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| code |	是|验证码	|
| email |	否|邮箱	|
| internationalCode |	否|国际代码，配合手机号码使用，默认为国内	|
| password |	否|用户重置的密码，如果不输入默认为 12345678求成功回调	|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 设备相关（QuecDeviceService）

#### 获取设备列表
```
- (void)getDeviceListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecDeviceModel *> *list, NSInteger total)) success failure:(QuecErrorBlock)failure;
```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| pageNumber |	否|当前页，默认为第 1 页	| 
| pageSize |	否|页大小，默认为 10 条	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 通过SN绑定设备

```
- (void)bindDeviceBySerialNumber:(NSString *)serialNumber productKey:(NSString *)productKey deviceName:(NSString *)deviceName success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| serialNumber |	是|设备SN	| 
| productKey |	是|product key|
| deviceName |	否|设备名称	|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 通过authCode绑定设备（可用于wifi/wifi+蓝牙设备绑定）

```
- (void)bindDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| authCode |	是|设备authCode	| 
| productKey |	是|product key	| 
| deviceKey |	是|device key|
| deviceName |	否|设备名称	|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

####  通过authCode + password绑定设备（可用于蓝牙设备绑定）

```
- (void)bindDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey password:(NSString *)password deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| authCode |	是|设备authCode	| 
| productKey |	是|product key	| 
| deviceKey |	是|device key|
| password |	是|设备password|
| deviceName |	否|设备名称	|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 


#### 设备解除绑定

```
- (void)unbindDeviceWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceKey |	是|device key	| 
| productKey |	是|product key|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 更改设备名称

```
- (void)updateDeviceName:(NSString *)deviceName productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceName |	是|设备名称	| 
| productKey |	是|product key|
| deviceKey |	是|device key|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 通过DK+PK查询设备信息

```
- (void)getDeviceInfoByDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(QuecDeviceModel *deviceModel))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceKey |	是|device key|
| productKey |	是|product key|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 查询设备升级信息

```
- (void)getFetchPlanWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey extraInfo:(QuecDeviceOTAQueryModel *)extraInfo success:(void(^)(QuecDeviceOTAPlanModel *planModel))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| productKey |	是|product key|
| deviceKey |	是|device key|
| extraInfo |	否| QuecDeviceOTAQueryModel类型，其他信息|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 上报设备升级信息

```
- (void)reportDeviceUpgradeStatusWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey componentNo:(NSString *)componentNo reportStatus:(NSInteger)reportStatus success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| productKey |	是|product key|
| deviceKey |	是|device key|
| componentNo |	是| 升级组件标识|
| reportStatus |	是| 升级状态 0 - 12|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 获取物模型TSL

```
- (void)getProductTSLWithProductKey:(NSString *)productKey success:(void(^)(QuecProductTSLModel *tslModel))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| productKey |	是|product key|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 获取设备业务属性

```
- (void)getDeviceBusinessAttributesWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey gatewayPk:(NSString *)gatewayPk gatewayDk:(NSString *)gatewayDk codeList:(NSString *)codeList type:(NSString *)type  success:(void (^)(QuecProductTSLInfoModel *))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| productKey |	是|product key|
| deviceKey |	是|device key|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 设备控制

```
- (void)sendDataToDeviceByHttpWithData:(NSString *)data deviceKey:(NSString *)deviceKey productKey:(NSString *)productKey type:(NSInteger)type dataFormat:(NSString *) dataFormat success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| data |	是|遵循tsl格式的json string ， 如：[{"id":62,"value":99,"type":"INT","name":"XXX"}]
| type |	是|类型 1：透传 2：属性 3：服务|
| deviceKey |	是|device key|
| productKey |	是|product key|
| dataFormat |	否| 数据类型 1：Hex 2：Text （当 type 为透传时，需要指定 dataFormat）|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 设备批量控制

```
- (void)sendDataToDevicesByHttpWithData:(NSString *)data deviceList:(NSArray *)deviceList type:(NSInteger)type dataFormat:(NSInteger )dataFormat success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| data |	是|遵循tsl格式的json string ，遵循tsl格式的json string ， 如：[{"id":62,"value":99,"type":"INT","name":"XXX"}]| type |	是|类型 1：透传 2：属性 3：服务|
| deviceList |	是|设备列表, [{"pkdk":{"deviceKey":"", "productKey":""}}]| 
| dataFormat |	否| 数据类型 1：Hex 2：Text （当 type 为透传时，需要指定 dataFormat）|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|  

#### 获取websocket是否开启

```
- (BOOL)isWebSocketOpen

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| |	| | 


#### 开启websocket

```
- (void)openWebSocket

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| |	| | 

#### 关闭WebSocket

```
- (void)clodseWebSocket

```

|参数|	是否必传|说明|	
| --- | --- | --- | 


#### 发送数据

```
- (void)sendDataToDeviceByWebSocketWithDataModel:(QuecWebSocketDataModel *)dataModel;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| dataModel |	是|指令数据 | 

#### 订阅设备（订阅结果QuecDeviceServiceWebSocketDelegate返回）

```
- (void)subscribeDevicesWithList:(NSArray<QuecWebSocketActionModel *> *)list;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| list |	是|设备数据 | 

#### 取消订阅设备（取消订阅结果QuecDeviceServiceWebSocketDelegate返回）

```
- (void)unSubscribeDevicesWithList:(NSArray<QuecWebSocketActionModel *> *)list;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| list |	是|设备数据 | 


#### 通过分享码查询设备信息

```
- (void)getDeviceInfoByShareCode:(NSString *)shareCode success:(void(^)(QuecDeviceModel *deviceModel))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| shareCode |	是|分享码|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 更改分享设备名称

```
- (void)updateDeviceNameByShareUserWithDeviceName:(NSString *)deviceName shareCode:(NSString *)shareCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceName |	是|设备名称	| 
| shareCode |	是|分享码|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 获取设备分享人列表

```
- (void)getDeviceShareUserListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(NSArray <QuecShareUserModel *> *list))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceName |	是|设备名称	| 
| productKey |	是|product key|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 分享人取消分享

```
- (void)unShareDeviceByOwnerWithShareCode:(NSString *)shareCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| shareCode |	是|分享码	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 被分享人取消分享

```
- (void)unShareDeviceByShareUserWithShareCode:(NSString *)shareCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| shareCode |	是|分享码	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 被分享人接受分享

```
- (void)acceptShareByShareUserWithShareCode:(NSString *)shareCode deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| shareCode |	是|分享码	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 分享人设置分享信息

```
- (void)setShareInfoByOwnerWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey acceptingExpireTime:(NSInteger) acceptingExpireTime coverMark:(NSInteger)coverMark isSharingAlwaysValid:(BOOL)isSharingAlwaysValid sharingExpireTime:(NSInteger)sharingExpireTime success:(void(^)(NSString *shareCode))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| acceptingExpireTime |	是|分享二维码种子失效时间 时间戳（毫秒），表示该分享在此时间戳时间内没有使用，会失效	| 
| productKey |	是|product key	| 
| deviceKey |	是|device key	| 
| coverMark |	否|覆盖标志:1 直接覆盖上条有效分享（默认）（覆盖原有的分享码）；2 直接添加，允许多条并存；3 只有分享时间延长了，才允许覆盖上条分享	| 
| isSharingAlwaysValid |	否|设备是否永久有效	| 
| sharingExpireTime |	否|设备使用到期时间 时间戳（毫秒），表示该分享的设备，被分享人可以使用的时间，isSharingAlwaysValid为YES时该参数无效	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 添加设备组
```
- (void)addDeviceGroupWithInfo:(QuecDeviceGroupParamModel *)groupInfoModel success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| groupInfoModel |	是| 分组信息	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


#### 设备添加到设备组中
```
- (void)addDeviceToGroupWithDeviceGroupId:(NSString *)deviceGroupId deviceList:(NSArray *)deviceList success:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceGroupId |	是| 设备组ID	| 
| deviceList |	是| 设备列表，示例：[{"dk": "string","pk": "string"}] | 
| success |	否|接口请求成功回调，data示例："data": {"failureList": [{"data": {"dk": "string","pk": "string"},"msg": "string"}],"successList": [{"dk": "string","pk": "string"}]}	| 
| failure |	否|接口请求失败回调	|

#### 删除分组
```
- (void)deleteDeviceGroupWithDeviceGroupId:(NSString *)deviceGroupId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceGroupId |	是| 设备组ID	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|
 
 
#### 删除分组中的设备
```
- (void)deleteDeviceFromGroupWithDeviceGroupId:(NSString *)deviceGroupId deviceList:(NSArray *)deviceList success:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceGroupId |	是| 设备组ID	| 
| deviceList |	是| 设备列表，示例：[{"dk": "string","pk": "string"}] | 
| success |	否|接口请求成功回调，data示例："data": {"failureList": [{"data": {"dk": "string","pk": "string"},"msg": "string"}],"successList": [{"dk": "string","pk": "string"}]}	| 
| failure |	否|接口请求失败回调	|

#### 获取分组详情
```
- (void)getDeviceGroupInfoWithDeviceGroupId:(NSString *)deviceGroupId success:(void(^)(QuecDeviceGroupInfoModel *dataModel))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceGroupId |	是| 设备组ID	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 获取分组列表
```
- (void)getDeviceGroupListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize extra:(QuecDeviceGroupInfoBaseModel *)infoModel success:(void(^)(NSArray<QuecDeviceGroupInfoModel *> *list, NSInteger total))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| pageNumber |	是| 当前页，默认为第 1 页	| 
| pageSize |	是| 页大小，默认为 10 条| 
| infoModel |	是| 筛选信息	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 查询设备分组列表
```
- (void)getDeviceGroupListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(NSArray<QuecDeviceGroupInfoModel *> *list, NSInteger total))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceKey |	是| device key	| 
| productKey |	是| product key| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 获取分组设备列表
```
- (void)getDeviceListWithDeviceGroupId:(NSString *)deviceGroupId deviceGroupName:(NSString *)deviceGroupName deviceKeyList:(NSString *)deviceKeyList productKey:(NSString *)productKey pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void (^)(NSArray<NSDictionary *> *, NSInteger))success failure:(void (^)(NSError *))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceGroupName |	否| 分组名称	| 
| deviceGroupId |	否| 分组id| 
| deviceKeyList |	否| device key列表，多个device key，使用英文逗号分隔	| 
| pageNumber |	否| 当前页，默认为第 1 页	| 
| pageSize |	是| 页大小，默认为 10 条| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 修改分组信息
```
- (void)updateDeviceGroupInfoWithModel:(QuecDeviceGroupParamModel *)infoModel success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| infoModel |	是| 分组信息	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 蓝牙通信相关（QuecBleManager）

#### 添加listener
```
- (void)addListener:(id<QuecBleManagerDelegate>)delegate;

```
|参数|	说明|	
| --- | --- | 
| delegate |	遵循QuecBleManagerDelegate的对象	| 

#### 移除listener

```
- (void)removeListener:(id<QuecBleManagerDelegate>)delegate;

```
|参数|	说明|	
| --- | --- | 
| delegate |	遵循QuecBleManagerDelegate的对象	| 

#### 扫描外设

```
- (void)startScanWithFilier:(QuecBleFilterModel *)filter;

```

|参数|	说明|	
| --- | --- | 
| filter |  QuecBleFilterModel，过滤外设	| 

#### 关闭扫描

```
- (void)stopScan;

```

#### 连接外设

```
- (void)connectPeripheral:(QuecPeripheralModel *)peripheral;

```

|参数|	说明|	
| --- | --- | 
| peripheral |	QuecPeripheralModel类型，外设 | 

#### 断开外设连接

```
- (void)disconnectPeripheral:(QuecPeripheralModel *)peripheral;

```

|参数|	说明|	
| --- | --- | 
| peripheral |	QuecPeripheralModel类型，外设 | 


#### 发送数据给外设

```
- (void)sendCommand:(QuecBleCommandModel *)command completion:(void(^)(BOOL timeout, QuecBleReceiveModel *response))completion;

```

|参数|	说明|	
| --- | --- | 
| command |	QuecBleCommandModel类型，指令数据	|
| completion |	完成回调	|  

