
### IoT SDK API简介

#### QuecIotSdk

#### 初始化SDK
```
//该接口执行后，其他接口功能才能正常执行

typedef NS_ENUM(NSUInteger, QuecCloudServiceType) { //云服务类型
    QuecCloudServiceTypeChina = 0, //国内
    QuecCloudServiceTypeEurope,    //欧洲
    QuecCloudServiceTypeNorthAmerica,    //北美
};

- (void)startWithUserDomain:(NSString *)userDomain userDomainSecret:(NSString *)userDomainSecret cloudServiceType:(QuecCloudServiceType)cloudServiceType;
```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| userDomain |	是|用户域，DMP平台创建APP生成	| 
| userDomainSecret |	是|用户域秘钥，DMP平台创建APP生成	| 
| cloudServiceType |	是|云服务类型，指定连接的云服务| 


#### 通过配置初始化SDK（可用于私有化部署）
```
//该接口执行后，其他接口功能才能正常执行

- (void)startWithConfig:(QuecPublicConfig *)config;
```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| config |	是| 初始化SDK的配置	| 




#### 更改debug模式

```
//在开发的过程中可以开启Debug模式，打印日志用于分析问题。
- (void)setDebugMode:(BOOL)debugMode;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| debugMode |	是|更改debug状态	| 

#### 设置国家码

[云服务支持的国家列表](https://iot-cloud-docs.quectelcn.com/introduction/page-05.html)

```
//如中国传入"86"
- (void)setDebugMode:(BOOL)debugMode;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| debugMode |	是|更改debug状态	| 


#### 账户管理相关（QuecUserKit）
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
- (void)sendEmailWithType:(QuecEmailCodeType)type email:(NSString *)email success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| email |	是|邮箱| 
| type |是| QuecEmailCodeType类型| 
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
                         type:(QuecVerifyCodeType)type
                         ssid:(NSString *)ssid
                         stid:(NSString *)stid
                      success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| phone |	是|手机号| 
| internationalCode |是|国际代码| 
| type |是| QuecVerifyCodeType类型| 
| ssid |否|使用type，可不传| 
| stid |否|使用type，可不传| 
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
- (void)logoutWithParams:(NSDictionary *)params success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| params |	否|退出登录需要清除的信息，如deviceId（推送id）| 
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



#### 本机号码一键登录

```
- (void)oneKeyLoginByAppid:(NSString *)appid
                     msgid:(NSString *)msgid
               strictcheck:(NSString *)strictcheck
                systemtime:(NSString *)systemtime
                 appSecret:(NSString *)appSecret
                loginToken:(NSString *)loginToken
                   version:(NSString *)version
                   success:(void(^)(void))success
                   failure:(void(^)(NSError *error))failure;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| appid |	是|中国移动开放平台申请appid	|
| msgid |	是|uuid	|
| strictcheck |	否|0：不对服务器ip白名单进行强校验,1：对服务器ip白名单进行强校验	|
| systemtime |	否|系统时间 yyyyMMddHHmmssSSS	|
| appSecret |	是|中国移动开放平台申请appSecret	|
| loginToken |	是|获取权限后移动SDK返回token	|
| version |	是|版本	|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




#### 删除消息

```
- (void)deleteMessageByMsgId:(NSString *)msgId language:(NSString *)language success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| msgId |	是|阅读的消息ID列表 多个ID使用英文逗号分隔	|
| language |	否|语音	|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


#### 查询用户接收推送的消息类型

```
- (void)getReceiveMessagePushTypeWithSuccess:(void(^)(NSString *result))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


#### 阅读消息

```
- (void)readMessageByMsgIdList:(NSString *)msgIdList msgType:(int)msgType success:(void(^)(NSDictionary *resultDict))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| msgIdList |	否|阅读的消息ID列表 多个ID使用英文逗号分隔,如果不传，会阅读所有消息| 
| msgType |	否|1：设备通知，2：设备告警，3：设备故障，4：系统消息；接收的消息类型任意组合，多个类型使用英文逗号分隔	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



#### 设置消息类型

```
- (void)setReceiveMessagePushTypeByMsgType:(NSString *)msgType success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| msgType |	是|1：设备通知，2：设备告警，3：设备故障，4：系统消息；接收的消息类型任意组合，多个类型使用英文逗号分隔	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



#### 查询消息列表

```
- (void)getUserMessageListByPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize msgType:(NSInteger)msgType isRead:(BOOL)isRead deviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(NSArray<QuecUserMessageListModel *> *list, NSInteger total))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| pageNumber |	否|查询的列表页，默认为 1	| 
| pageSize |	否|查询的页大小，默认 10	| 
| msgType |	否|1：设备通知，2：设备告警，3：设备故障，4：系统消息；接收的消息类型任意组合，多个类型使用英文逗号分隔	| 
| isRead |	否|是否已读	| 
| deviceKey |	否|device key	| 
| productKey |	否|product key	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


#### 检查用户是否登录

```
- (void)checkUserLoginState:(void(^)(BOOL isLogin))completion;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| completion |	是|回调| 


#### 查询邮箱是否已注册

```
- (void)checkEmailRegister:(NSString *)email
                   success:(void(^)(BOOL isRegister))success
                   failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|

#### 第三方用户登录

```
- (void)loginByAuthCode:(NSString *)authCode success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| authCode |	是|authCode| 
| success |	否|成功回调| 
| failure |	否|失败回调| 

#### 设备相关（QuecDeviceKit）
#### 获取设备列表
```
- (void)getDeviceListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecDeviceModel *> *list, NSInteger total)) success failure:(QuecErrorBlock)failure;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| pageNumber |    否|当前页，默认为第 1 页    | 
| pageSize |    否|页大小，默认为 10 条    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 获取设备列表
```
- (void)getDeviceListWithParams:(QuecDeviceListParamsModel *)params success:(void(^)(NSArray<QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| params |    否| QuecDeviceListParamsModel类型  | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 


#### 获取设备列表-根据设备名称搜索
```
- (void)getDeviceListByDeviceName:(NSString *)deviceName pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceName |    否|设备名称    |
| pageNumber |    否|当前页，默认为第 1 页    | 
| pageSize |    否|页大小，默认为 10 条    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 




#### 通过SN绑定设备

```
- (void)bindDeviceBySerialNumber:(NSString *)serialNumber productKey:(NSString *)productKey deviceName:(NSString *)deviceName success:(void(^)())success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| serialNumber |    是|设备SN    | 
| productKey |    是|product key|
| deviceName |    否|设备名称    |
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 通过authCode绑定设备（可用于wifi/wifi+蓝牙设备绑定）

```
- (void)bindDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| authCode |    是|设备authCode    | 
| productKey |    是|product key    | 
| deviceKey |    是|device key|
| deviceName |    否|设备名称    |
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

####  通过authCode + password绑定设备（可用于蓝牙设备绑定）

```
- (void)bindDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey password:(NSString *)password deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| authCode |    是|设备authCode    | 
| productKey |    是|product key    | 
| deviceKey |    是|device key|
| password |    是|设备password|
| deviceName |    否|设备名称    |
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 


#### 设备解绑

```
- (void)unbindDeviceWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceKey |    是|device key    | 
| productKey |    是|product key|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 设备重命名

```
- (void)updateDeviceName:(NSString *)deviceName productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceName |    是|设备名称    | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 通过DK+PK查询设备信息

```
- (void)getDeviceInfoByDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(QuecDeviceModel *deviceModel))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceKey |    是|device key|
| productKey |    是|product key|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 获取物模型TSL

```
- (void)getProductTSLWithProductKey:(NSString *)productKey success:(void(^)(QuecProductTSLModel *tslModel))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 获取设备业务属性

```
- (void)getDeviceBusinessAttributesWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey gatewayPk:(NSString *)gatewayPk gatewayDk:(NSString *)gatewayDk codeList:(NSString *)codeList type:(NSString *)type success:(void (^)(QuecProductTSLInfoModel *tslInfoModel))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| gatewayDk |    否|网关设备的 device Key|
| gatewayPk |    否|网关设备的 product Key|
| codeList |    否|查询的属性标识符|
| type |    否|1:查询设备基础属性，2:查询物模型属性，3:查询定位信息；查询类型可以单选和多选，如果需要查询多个类型的属性值，使用英文逗号分隔|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 获取设备历史轨迹

```
- (void)getLocationHistoryWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey startTimestamp:(NSInteger)startTimestamp endTimestamp:(NSInteger)endTimestamp gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk locateTypes:(NSString *)locateTypes success:(void(^)(NSArray<QuecLocationHistoryModel *> *list))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| startTimestamp |    是| 开始时间（毫秒时间戳）|
| endTimestamp |    是| 结束时间（毫秒时间戳）|
| gatewayDk |    否|网关设备的 device Key|
| gatewayPk |    否|网关设备的 product Key|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 



#### 获取设备属性图表列表

```
- (void)getPropertyChartListWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey startTimestamp:(NSInteger)startTimestamp endTimestamp:(NSInteger)endTimestamp attributeCode:(NSString *)attributeCode gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk countType:(NSInteger)countType timeGranularity:(NSInteger)timeGranularity success:(void(^)(NSArray *dataArray))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| startTimestamp |    是| 开始时间（毫秒时间戳）|
| endTimestamp |    是| 结束时间（毫秒时间戳）|
| attributeCode |    否| 物模型属性标识符，查询多个属性时使用英文逗号分隔|
| gatewayDk |    否|网关设备的 device Key|
| gatewayPk |    否|网关设备的 product Key|
| countType |    否|聚合类型（默认3）：1-最大值 2-最小值 3-平均值 4-差值|
| timeGranularity |    否|统计时间粒度（默认2）：1-月 2-日 3-小时 4-分钟 5-秒|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 


#### 获取设备属性环比统计数据

```
- (void)getPropertyStatisticsPathWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey currentTimestamp:(NSInteger)currentTimestamp attributeCode:(NSString *)attributeCode gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk countType:(NSInteger)countType timeGranularities:(NSString *)timeGranularities success:(void(^)(NSArray *dataArray))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| currentTimestamp |    否| 当前时间（毫秒时间戳）|
| attributeCode |    否| 物模型属性标识符，查询多个属性时使用英文逗号分隔|
| gatewayDk |    否|网关设备的 device Key|
| gatewayPk |    否|网关设备的 product Key|
| countType |    否|聚合类型（默认3）：1-最大值 2-最小值 3-平均值 4-差值|
| timeGranularity |    否|统计时间粒度（默认2）：1-月 2-日 3-小时 4-分钟 5-秒|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 获取设备属性数据列表

```
- (void)getPropertyDataListWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey startTimestamp:(NSInteger)startTimestamp endTimestamp:(NSInteger)endTimestamp attributeCode:(NSString *)attributeCode gatewayDk:(NSString *)gatewayDk gatewayPk:(NSString *)gatewayPk pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecPropertyDataListModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| startTimestamp |    是| 开始时间（毫秒时间戳）|
| endTimestamp |    是| 结束时间（毫秒时间戳）|
| attributeCode |    否| 物模型属性标识符，查询多个属性时使用英文逗号分隔|
| gatewayDk |    否|网关设备的 device Key|
| gatewayPk |    否|网关设备的 product Key|
| pageNumber |    否|当前页，默认为第 1 页|
| pageSize |    否|页大小，默认为 10 条|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 



#### 创建定时任务

```
- (void)addCornJobWithCornJobModel:(QuecCornJobModel *)cornJobModel success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| cornJobModel |    是|QuecCornJobModel类型|

#### 修改定时任务

```
- (void)setCronJobWithCornJobModel:(QuecCornJobModel *)cornJobModel success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| cornJobModel |    是|QuecCornJobModel类型|

#### 查询设备下定时任务列表

```
- (void)getCronJobListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey type:(NSString *)type pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecCornJobModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| type |    否|定时任务类型，once: 执行一次，day-repeat: 每天重复，custom-repeat: 自定义重复，multi-section: 多段执行，random: 随机执行，delay: 延迟执行（倒计时）|
| pageNumber |    否|分页页码，默认: 1|
| pageSize |    否|分页大小，默认: 10|
| success |    否|success block|
| failure |    否|failure block|


#### 查询定时任务详情

```
- (void)getCronJobInfoWithRuleId:(NSString *)ruleId success:(void(^)(QuecCornJobModel *cornJobModel))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| ruleId |    是|定时任务ID|
| success |    否|success block|
| failure |    否|failure block|


#### 批量删除定时任务

```
- (void)batchDeleteCronJobWithParams:(NSDictionary *)params success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| params |    是|{ruleIdList:[String 定时任务ID数组]}|
| success |    否|success block|
| failure |    否|failure block|

#### 查询产品下定时任务限制数

```
- (void)getProductCornJobLimitWithProductKey:(NSString *)productKey success:(void(^)(NSInteger limit))success failure:(QuecErrorBlock)failure;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| success |    否|success block|
| failure |    否|failure block|


#### 通过authCode绑定设备
 为了兼容旧方法新增返回参数,可用于wifi/wifi+蓝牙设备绑定

```
- (void)bindWifiDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName success:(void(^)(NSDictionary *dictionary))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| authCode |    是|设备authCode|
| productKey |    是|product key|
| deviceKey |    是|device key|
| deviceName |    否|设备名称|
| success |    否|success block|
| failure |    否|failure block|


####  查询用户是否可以绑定该设备

```
- (void)getDeviceInfoByBindingByFid:(NSString *)fid productKey:(NSString *)productKey success:(void(^)(NSDictionary *dictionary))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| fid |    否|家庭fid|
| productKey |    是|product key|
| success |    否|success block|
| failure |    否|failure block|

####  查询dk

```
- (void)getDeviceDkForSn:(NSString *)sn productKey:(NSString *)productKey success:(void(^)(NSDictionary *dictionary))success failure:(QuecErrorBlock)failure;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| sn |    是|sn|
| productKey |    是|product key|
| success |    否|success block|
| failure |    否|failure block|


####  获取设备物模型及业务属性值

```
- (void)getProductTslAndDeviceBusinessAttributesWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey gatewayPk:(NSString *)gatewayPk gatewayDk:(NSString *)gatewayDk codeList:(NSString *)codeList type:(NSString *)type success:(void (^)(NSArray *tslAndAttributesArray))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| gatewayDk |    否| 网关设备的 device Key|
| gatewayPk |    否|网关设备的 product Key|
| codeList |    否|查询的属性标识符,和查询类型配合使用，如果查询多个属性，使用英文逗号分隔|
| type |    否|查询类型,1:查询设备基础属性,2:查询物模型属性,3:查询定位信息,如果需要查询多个类型的属性值，使用英文逗号分隔|
| success |    否|success block|
| failure |    否|failure block|


####  通过authCode绑定设备
可用于wifi/wifi+蓝牙设备绑定,为了兼容旧方法新增设备连网能力入参

```
- (void)bindWifiDeviceByAuthCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName capabilitiesBitmask:(NSInteger)capabilitiesBitmask success:(void(^)(NSDictionary *dictionary))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| authCode |    是|设备authCode|
| productKey |    是|product key|
| deviceKey |    是|device key|
| deviceName |    否|设备名称|
| capabilitiesBitmask |    否|设备连网能力|
| success |    否|success block|
| failure |    否|failure block|


####  获取设备物模型
缓存最新物模型,无网络默认读取缓存

```
- (void)getProductTSLWithCacheByProductKey:(NSString *)productKey success:(void (^)(NSArray *properties))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| success |    否|success block|
| failure |    否|failure block|


#### 设备批量控制

```
- (void)sendDataToDevicesByHttpWithData:(NSString *)data deviceList:(NSArray *)deviceList type:(NSInteger)type dataFormat:(NSInteger )dataFormat success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| data |    是|遵循tsl格式的json string|
| type |    是|类型 1：透传 2：属性 3：服务|
| deviceList |    是|设备列表, [{"deviceKey":{"deviceKey":"", "productKey":""}}]| 
| dataFormat |    否| 数据类型 1：Hex 2：Text （当 type 为透传时，需要指定 dataFormat）|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |  


#### 设备批量控制

```
- (void)sendDataToDevicesByHttpWithData:(NSString *)data
                             deviceList:(NSArray *)deviceList
                                   type:(NSInteger)type
                              extraData:(NSDictionary *)extraData
                                success:(QuecDictionaryBlock)success
                                failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| data |    是|遵循tsl格式的json string|
| deviceList |    是|设备列表 [{"deviceKey":"", "productKey":""}]| 
| type |    是|类型 1：透传 2：属性 3：服务|
| extraData |    否| {"cacheTime": 0, "isCache": 0,"isCover": 0,"qos": 0}|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### QuecDeviceService (Share) 方法

#### 通过分享码查询设备信息

```
- (void)getDeviceInfoByShareCode:(NSString *)shareCode success:(void(^)(QuecDeviceModel *deviceModel))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| shareCode |    是|分享码|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 更改分享设备名称

```
- (void)updateDeviceNameByShareUserWithDeviceName:(NSString *)deviceName shareCode:(NSString *)shareCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceName |    是|设备名称    | 
| shareCode |    是|分享码|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 获取设备分享人列表

```
- (void)getDeviceShareUserListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(NSArray <QuecShareUserModel *> *list))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceName |    是|设备名称    | 
| productKey |    是|product key|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 分享人取消分享

```
- (void)unShareDeviceByOwnerWithShareCode:(NSString *)shareCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| shareCode |    是|分享码    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 被分享人取消分享

```
- (void)unShareDeviceByShareUserWithShareCode:(NSString *)shareCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| shareCode |    是|分享码    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 被分享人接受分享

```
- (void)acceptShareByShareUserWithShareCode:(NSString *)shareCode success:(void(^)())success failure:(void(^)(NSError *error))failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| shareCode |    是|分享码    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 分享人设置分享信息

```
- (void)setShareInfoByOwnerWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey acceptingExpireTime:(NSInteger) acceptingExpireTime coverMark:(NSInteger)coverMark isSharingAlwaysValid:(BOOL)isSharingAlwaysValid sharingExpireTime:(NSInteger)sharingExpireTime success:(void(^)(NSString *shareCode))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| acceptingExpireTime |    是|分享二维码种子失效时间 时间戳（毫秒），表示该分享在此时间戳时间内没有使用，会失效    | 
| productKey |    是|product key    | 
| deviceKey |    是|device key    | 
| coverMark |    否|覆盖标志:1 直接覆盖上条有效分享（默认）（覆盖原有的分享码）；2 直接添加，允许多条并存；3 只有分享时间延长了，才允许覆盖上条分享    | 
| isSharingAlwaysValid |    否|设备是否永久有效    | 
| sharingExpireTime |    否|设备使用到期时间 时间戳（毫秒），表示该分享的设备，被分享人可以使用的时间，isSharingAlwaysValid为YES时该参数无效    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### QuecDeviceService (Group) 方法

#### 获取分组列表
```
- (void)getDeviceGroupListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize extra:(QuecDeviceGroupParamModel *)infoModel success:(void(^)(NSArray<QuecDeviceGroupInfoModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| pageNumber |    否| 页码    | 
| pageSize |    否| 页数据数量    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 添加设备组
```
- (void)addDeviceGroupWithInfo:(QuecDeviceGroupParamModel *)groupInfoModel success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| groupInfoModel |    是| 分组信息    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 修改设备组
```
- (void)updateDeviceGroupInfoWithDeviceGroupId:(NSString *)deviceGroupId infoModel:(QuecDeviceGroupParamModel *)infoModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceGroupId |    是| 分组id    | 
| infoModel |    是| 分组信息    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 删除设备组
```
- (void)deleteDeviceGroupWithDeviceGroupId:(NSString *)deviceGroupId success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceGroupId |    是| 分组id    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 获取分组详情
```
- (void)getDeviceGroupInfoWithDeviceGroupId:(NSString *)deviceGroupId success:(void(^)(QuecDeviceGroupInfoModel *model))success failure:(QuecErrorBlock)failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceGroupId |    是| 分组id    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 获取分组设备列表
```
- (void)getDeviceListWithDeviceGroupId:(NSString *)deviceGroupId deviceGroupName:(NSString *)deviceGroupName deviceKeyList:(NSString *)deviceKeyList productKey:(NSString *)productKey pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void (^)(NSArray<QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceGroupId |    是| 分组id    | 
| deviceGroupName |    否| 分组名称| 
| deviceKeyList |    否| device key列表，多个device key，使用英文逗号分隔    | 
| productKey |    否| product key    | 
| pageNumber |    否| 页码，默认为1    | 
| pageSize |    否| 页大小，默认为10条    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备添加到设备组中
```
- (void)addDeviceToGroupWithDeviceGroupId:(NSString *)deviceGroupId deviceList:(NSArray *)deviceList success:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceGroupId |    是| 设备组ID    | 
| deviceList |    是| 设备列表，示例：[{"dk": "string","pk": "string"}] | 
| success |    否|接口请求成功回调，data示例："data": {"failureList": [{"data": {"dk": "string","pk": "string"},"msg": "string"}],"successList": [{"dk": "string","pk": "string"}]}    | 
| failure |    否|接口请求失败回调    |

 

#### 删除分组中的设备
```
- (void)deleteDeviceFromGroupWithDeviceGroupId:(NSString *)deviceGroupId deviceList:(NSArray *)deviceList success:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceGroupId |    是| 设备组ID    | 
| deviceList |    是| 设备列表，示例：[{"dk": "string","pk": "string"}] | 
| success |    否|接口请求成功回调，data示例："data": {"failureList": [{"data": {"dk": "string","pk": "string"},"msg": "string"}],"successList": [{"dk": "string","pk": "string"}]}    | 
| failure |    否|接口请求失败回调    |



#### 查询设备分组列表
```
- (void)getDeviceGroupListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey success:(void(^)(NSArray<QuecDeviceGroupInfoModel *> *list, NSInteger total))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceKey |    是| device key    | 
| productKey |    是| product key| 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 查询网关设备下子设备列表

```
- (void)getGatewayDeviceChildListWithDeviceKey:(NSString *)deviceKey productKey:(NSString *)productKey pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceKey |    是| device key    | 
| productKey |    是| product key| 
| pageNumber |    否| 页码，默认为1    | 
| pageSize |    否| 页大小，默认为10条    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 查询不在设备组内的设备列表

```
- (void)getDeviceListByNotInDeviceGroupWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize groupId:(NSString *)groupId success:(void(^)(NSArray<QuecDeviceModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| pageNumber |    否| 页码，默认为1    | 
| pageSize |    否| 页大小，默认为10条    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

#### 设备关联管理 - 绑定设备
```
- (void)deviceAssociationWithList:(NSArray<QuecDeviceModel *> *)list master:(QuecDeviceModel *)masterDevice fid:(NSString *)fid success:(void (^)(void))success failure:(void (^)(NSError *))failure;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| list |    是|  设备列表 | 
| masterDevice |    是|   主设备 | 
| fid |    否|家庭id，家居模式下必传| 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备关联管理 - 关联关系查询
```
- (void)deviceAssociationWithMaster:(QuecDeviceModel *)masterDevice fid:(NSString *)fid code:(NSString *)code success:(void(^)(NSDictionary *data))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| masterDevice |    是|   主设备 | 
| fid |    否|家庭id，家居模式下必传| 
| code |    否|物模型code|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |



#### 设备关联管理 - 关联关系解除
```
- (void)deviceDisassociationWithDevice:(QuecDeviceModel *)model fid:(NSString *)fid success:(void (^)(void))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| model |    是|   设备 | 
| fid |    否|家庭id，家居模式下必传| 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备关联管理 - 关联关系配置
```
- (void)deviceAssociationConfigWithProductKey:(NSString *)productKey success:(void(^)(QuecDeviceAssociationConfig *config))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|   product key | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |

### QuecIotCacheService 方法
当前和设备建立通道连接，和设备进行上下行数据之前，需要先将设备加入缓存队列，该缓存队列会统一维护设备的通道状态。

#### 通过pk和dk初始化
```
- (void)addDeviceModelList:(NSArray<QuecDeviceModel *> *)deviceModelList;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceModelList |    是|   设备列表 | 


### QuecDevice 方法
该类主要包含设备控制相关，如设备数据下行，监听设备上行数据，底层会根据设备的能力值和当前APP以及设备的环境，自动选择合适的链路进行连接和数据传输。

#### 通过pk和dk初始化
```
- (nullable instancetype)initWithPk:(NSString *)pk dk:(NSString *)dk NS_DESIGNATED_INITIALIZER;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|   product key | 
| deviceKey |    是 | device key | 


#### 建立通道连接
```
- (void)connect;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 


#### 建立指定的通道连接
```
- (void)connectWithMode:(QuecIotChannelMode)mode;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| mode |    是|   QuecIotChannelMode类型，通道模式 | 


#### 断开连接
```
- (void)disconnect;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 


#### 断开指定的通道连接
```
- (void)disconnectWithType:(QuecIotChannelType)type;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| mode |    是|   QuecIotChannelMode类型，通道模式 | 

#### 获取连接状态
```
- (QuecIotChannelBitMask)connectedState;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 


#### 删除设备
```
- (void)remove:(nullable void(^)(void))success failure:(void(^)(NSError *error))failure;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| success |    否|   成功回调 | 
| failure |    否|   失败回调 | 


#### 写物模型
```
- (void)writeDps:(NSArray<QuecIotDataPoint*> *)dps success:(nullable void(^)(void))success failure:(void(^)(NSError *error))failure;
```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| dps |    是|   物模型数据 | 
| success |    否|   成功回调 | 
| failure |    否|   失败回调 | 


#### 指定通道写物模型
```
- (void)writeDps:(NSArray<QuecIotDataPoint*> *)dps mode:(QuecIotChannelMode)mode success:(nullable void(^)(void))success failure:(void(^)(NSError *error))failure;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| dps |    是|   物模型数据 | 
| mode |    是|   QuecIotChannelMode类型，通道模式 | 
| success |    否|   成功回调 | 
| failure |    否|   失败回调 | 


#### 读物模型
```
- (void)readDps:(NSArray<QuecIotDataPoint*> *)dps success:(nullable void(^)(void))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| dps |    是|   物模型数据 | 
| success |    否|   成功回调 | 
| failure |    否|   失败回调 | 


#### 指定通道读物模型
```
- (void)readDps:(NSArray<QuecIotDataPoint*> *)dps mode:(QuecIotChannelMode)mode success:(nullable void(^)(void))success failure:(void(^)(NSError *error))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| dps |    是|   物模型数据 | 
| mode |    是|   QuecIotChannelMode类型，通道模式 | 
| success |    否|   成功回调 | 
| failure |    否|   失败回调 | 


#### 云端更新设备状态
```
- (void)updateDeviceCloudOnlineStatus:(int)cloudOnlineStatus;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| cloudOnlineStatus |    是|   0：离线，1：在线 | 


#### 蓝牙通信相关（QuecBleChannelKit）

#### 添加listener
```
- (void)addListener:(id<QuecBleManagerDelegate>)delegate;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| delegate |	是|遵循QuecBleManagerDelegate的对象	| 

#### 移除listener

```
- (void)removeListener:(id<QuecBleManagerDelegate>)delegate;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| delegate |	是|遵循QuecBleManagerDelegate的对象	| 

#### 扫描外设

```
- (void)startScanWithFilier:(QuecBleFilterModel *)filter;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| filter |	否|QuecBleFilterModel，过滤外设		| 

#### 关闭扫描

```
- (void)stopScan;

```


#### 连接外设

```
- (void)connectPeripheral:(QuecPeripheralModel *)peripheral;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| peripheral |	是| QuecPeripheralModel	| 

#### 断开外设连接

```
- (void)disconnectPeripheral:(QuecPeripheralModel *)peripheral;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| peripheral |	是|QuecPeripheralModel	| 


#### 发送数据给外设

```
- (void)sendCommandToPeripheral:(QuecPeripheralModel *)peripheral command:(QuecTtlvCommandModel *)command completion:(void(^)(BOOL timeout, QuecTtlvCommandModel *response))completion;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| peripheral |	是| QuecPeripheralModel	| 
| command |	是| QuecTtlvCommandModel	| 
| completion |	否| 完成回调	| 


#### 开启通道AES128加解密

```
- (void)startAES128EncryptAndDecryptWithPeripheral:(QuecPeripheralModel *)peripheral serviceUuid:(NSString *)serviceUuid key:(NSString *)key iv:(NSString *)iv;

```

 

|参数|	是否必传|说明|	
| --- | --- | --- | 
| peripheral |	是| QuecPeripheralModel	| 
| serviceUuid |	否| serviceUuid，不传使用默认	| 
| key |	否| AES128 key	| 
| iv |	否| AES128 iv	| 



#### 关闭通道AES128加解密

```
- (void)stopAES128EncryptAndDecryptWithPeripheral:(QuecPeripheralModel *)peripheral serviceUuid:(NSString *)serviceUuid;

```


|参数|	是否必传|说明|	
| --- | --- | --- | 
| peripheral |	是| QuecPeripheralModel	| 
| serviceUuid |	否| serviceUuid，不传使用默认	| 


#### 获取外设的连接状态

```
- (BOOL)getPeripheralConnectState:(QuecPeripheralModel *)peripheral;

```

#### 设备配网相关（QuecSmartConfigKit）
#### ~~添加配网监听~~(已过时, 使用下面新Api)

```
- (void)addSmartConfigDelegate:(id<QuecSmartConfigDelegate>)delegate;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| delegate |	是| 遵循QuecSmartConfigDelegate协议对象	| 


#### ~~移除配网监听~~(已过时, 使用下面新Api)

```
- (void)removeSmartConfigDelegate:(id<QuecSmartConfigDelegate>)delegate;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| delegate |	是| 遵循QuecSmartConfigDelegate协议对象	| 


#### ~~开启配网(适用wifi+BLE类型设备配网)~~(已过时, 使用下面新Api)

```
- (void)startConfigDevices:(NSArray<QuecPeripheralModel *> *)devices ssid:(NSString *)ssid password:(NSString *)password;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| devices |	是| BleChannel获取到的外设数据，支持批量加入	| 
| ssid |	否| wifi名称	| 
| password |	否| wifi密码	| 


#### ~~取消进行域配网所有操作~~(已过时, 使用下面新Api)

```
- (void)cancelConfigDevices;
```

### 设备配网绑定相关（#import <QuecSmartconfigKit/QuecDevicePairingService.h>）

#### 扫描设备
扫描结果参考QuecPairingDelegate
```
- (void)scanWithFid:(NSString * _Nullable)fid filier:(QuecBleFilterModel * _Nullable)filter;
```
|参数|	是否必传| 说明            |	
| --- | --- |---------------| 
| fid |	否| 家庭id，家居模式下传入	 | 
| filter |	否| 过滤外设条件	       |

#### 停止扫描

```
- (void)stopScan;
```

#### 开始配对设备
配网进度和结果参考QuecPairingDelegate
```
- (void)startPairingByDevices:(NSArray<QuecPairingPeripheral *> *)pairingDevices fid:(NSString *)fid ssid:(NSString *)ssid pwd:(NSString *)pwd;
```
|参数|	是否必传| 说明                        |	
| --- | --- |---------------------------| 
| devices |	是| 待绑定数据源	                   | 
| fid |	否| 家庭id，传入值合法且不为空则默认家居模式下绑定设备	 |
| ssid |	否| WiFi名称	                   |
| pwd |	否| WiFi密码	                   |

#### 取消所有设备配对

```
- (void)cancelAllDevicePairing;
```

#### 设置WiFi配网超时时间

```
- (BOOL)setWiFiPairingDuration:(int)duration;
```
|参数|	是否必传| 说明            |	
| --- | --- |---------------|
| duration |	否| 60~120,默认120秒，单位：秒	       |

#### 设置Ble配对超时时间

```
- (BOOL)setBlePairingDuration:(int)duration;
```

|参数|	是否必传| 说明            |	
| --- | --- |---------------|
| duration |	否| 30~60,默认60秒，单位：秒	       |

#### 添加配网绑定监听

```
- (void)addPairingListener:(id<QuecPairingDelegate>)listener;
```

|参数|	是否必传| 说明    |	
| --- | --- |-------|
| listener |	否| 代理对象	 |

#### 移除配网绑定监听

```
- (void)removePairingListener:(id<QuecPairingDelegate>)listener;
```

|参数|	是否必传| 说明    |	
| --- | --- |-------|
| listener |	否| 代理对象	 |

#### QuecPairingDelegate协议方法

```
/**
    配网绑定进度
    pairingPeripheral：当前配网绑定设备
    progress: 配网绑定进度(0~1)
*/
- (void)didUpdatePairingStatus:(QuecPairingPeripheral *)pairingPeripheral progress:(CGFloat)progress;
/**
    配网绑定进结果
    pairingPeripheral：当前配网绑定设备
    result: 配网绑定结果
    error: 配网绑定失败详细
*/
- (void)didUpdatePairingResult:(QuecPairingPeripheral *)pairingPeripheral result:(BOOL)result error:(NSError *)error;
/**
    外设扫描
    pairingPeripheral：扫描到的外设对象
*/
- (void)centralDidDiscoverPairingPeripheral:(QuecPairingPeripheral *)pairingPeripheral;
```

#### QuecPairingPeripheral类
|参数| 	类型 | 说明                    |	
| --- |----|-----------------------|
| productName | 	NSString  | 产品名称	                 |
| deviceName | 	NSString | 设备名称	                 |
| productLogo | 	NSString | 产品图片	                 |
| bindingMode | 	int | 绑定模式: 多绑：1/唯一：2/轮流：3	 |
| peripheralModel | 	QuecPeripheralModel | 扫描的BLE设备对象	           |

#### QuecPeripheralModel类

|参数| 	类型 | 说明                            |	
| --- |----|-------------------------------|
| uuid | 	NSString  | 设备唯一标志	                       |
| pk | 	NSString | 设备pk	                         |
| dk | 	NSString | 设备dk	                         |
| mac | 	NSString | 蓝牙mac地址	                      |
| isConfig | 	BOOL | wifi 设备是否已配网，1 表示已配网，0 表示未配网	 |
| isBind | 	BOOL | 纯Ble设备是否已绑定	                  |
| isEnableBind | 	BOOL | 纯Ble设备是否允许绑定	                 |
| capabilitiesBitmask | 	int | 设备能力值 bit0=1 表示设备支持 WAN 远场通讯能力 bit1=1 表示设备支持 WiFi LAN 近场通讯能力 bit2=1 表示设备支持 BLE 近场通讯能力	                   |

#### 配网绑定状态码QuecPairingState说明

|参数| 	值   | 说明                            |	
| --- |------|-------------------------------|
| QuecPairingWaiting | 	301 | 设备待绑定	                       |
| QuecPairingBleConnecting | 	302 | 蓝牙连接中                         |
| QuecPairingBleConnectedFail | 	303 | 蓝牙连接失败                        |
| QuecPairingWiFiGetBindingCodeFail | 	304 | WiFi配网设备，超时未获取到bindingcode	                      |
| QuecPairingWiFiBindingSuccess | 	305 | WiFi配网成功	 |
| QuecPairingWiFiBindingFail | 	306 | WiFi配网失败	                  |
| QuecPairingBleGetRandomFail | 	307 | 向蓝牙设备询问random失败	                 |
| QuecPairingBleGetEncryptionCodeFail | 	308 | 向云端请求加密bindingcode失败	                  |
| QuecPairingBleCodeAuthFail | 	309 | 向蓝牙设备认证失败	                 |
| QuecPairingBleCodeAuthSuccess | 	310 | 向蓝牙设备认证成功	                  |
| QuecPairingBleBindingSuccess | 	311 | 蓝牙绑定成功	                 |
| QuecPairingBleBindingFail | 	312 | 蓝牙绑定失败                  |
| QuecPairingFail | 	313 | 通用异常场景：绑定失败, 如入参问题等	                 |

### OTA SDK (QuecOTAUpgradeKit)

#### 蓝牙OTA
#### 查询单个设备升级计划

```
- (void)checkVersionWithProductKey:(NSString *)productKey
                         deviceKey:(NSString *)deviceKey
                         infoBlock:(void (^)(QuecBleOTAInfoModel * _Nullable infoModel))infoBlock;
```

|参数|	是否必传| 说明                     |	
| --- | --- |------------------------|
| productKey |	是| 设备pk	                  |
| deviceKey |	是| 设备dk	                  |
| infoBlock |	是| QuecBleOTAInfoModel回调	 |

#### QuecBleOTAInfoModel类说明

|参数| 	类型  | 说明                            |	
| --- |------|-------------------------------|
| pk | 	String | 设备pk	                       |
| dk | 	String | 设备dk                        |
| targetVersion | 	String | 新版本的版本号                      |
| componentNo | 	String | 组件号                      |
| desc | 	String | 升级说明	 |
| fileName | 	String | 文件名	                  |
| fileUrl | 	String | 文件下载地址	                 |
| fileSize | 	NSInteger | 文件大小	                  |
| fileSign | 	String | 文件Hash256值	                 |
| planId | 	NSInteger | 升级计划ID	                  |

#### 设置OTA成功或失败传输回调
```
- (void)addStateListener:(id)delegate
               onSuccess:(OnSuccessBlock)onSuccess
                  onFail:(OnFailBlock)onFail;
```
|参数|	是否必传| 说明    |	
| --- | --- |-------|
| delegate |	是| 代理对象	 |
| onSuccess |	是| 成功回调	 |
| OnFailBlock |	是| 失败回调	 |

#### 移除设置OTA成功或失败传输回调
```
- (void)removeStateListener:(id)delegate;
```
|参数|	是否必传| 说明    |	
| --- | --- |-------|
| delegate |	是| 代理对象	 |

#### 设置OTA进度回调接口监听
```
- (void)addProgressListener:(id)delegate
           progressListener:(ProgressListenerBlock)progressListener;
```
|参数|	是否必传| 说明                             |	
| --- | --- |--------------------------------|
| delegate |	是| 代理对象	                          |
| progressListener |	是| progress:当前单个文件传输的进度,范围为0 - 1	 |

#### 移除OTA进度回调接口监听
```
- (void)removeProgressListener:(id)delegate;
```
|参数|	是否必传| 说明    |	
| --- | --- |-------|
| delegate |	是| 代理对象	 |

#### 开始指定设备的ota流程
```
- (void)startOTAWithInfoList:(NSArray<QuecBleOTAInfoModel *> *)infoList;
```
|参数|	是否必传| 说明                             |	
| --- | --- |--------------------------------|
| infoList |	是| 可传多个设备，方法内部处理依次升级                          |


####  终止指定设备的ota流程
```
- (void)stopOTAWithInfoList:(NSArray<QuecBleOTAInfoModel *> *)infoList;
```
|参数|	是否必传| 说明                             |	
| --- | --- |--------------------------------|
| infoList |	是| 可传多个设备，方法内部处理依次升级                          |

#### QuecBleOTAErrorType错误码说明

|参数|	说明|
| --- | --- |
| QuecBleOTAErrorTypeCommon |	通用错误|
| QuecBleOTAErrorTypeNotConnect |	蓝牙未连接|
| QuecBleOTAErrorTypeNoFilePath |	升级文件路径不存在|
| QuecBleOTAErrorTypeFileCheckFail |	升级文件校验失败|
| QuecBleOTAErrorTypeDeviceRefuse |	设备拒绝升级|
| QuecBleOTAErrorTypeDeviceCancel |	设备取消升级|
| QuecBleOTAErrorTypeDeviceFail |	设备升级失败|
| QuecBleOTAErrorTypeDeviceTimeout |	升级超时|

#### Http OTA (QuecHttpOTAService)
####  查询设备升级计划

```
- (void)getDeviceUpgradePlan:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void (^)(QuecOTAPlanModel *))success failure:(void (^)(NSError *))failure;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### QuecOTAPlanModel

|参数| 类型 | 说明                                                                    |    
| --- |----|-----------------------------------------------------------------------| 
| planId | 是  | 升级计划id                                                                |
| planName | 是  | 升级计划name                                                              |
| versionInfo | 是  | 版本信息                                                                  |
| dataType | 是  | 包类型                                                                   |
| planStartTime | 否  | 计划开始时间，单位ms                                                           | 
| planEndTime | 否  | 计划结束时间，单位ms                                                           | 
| appointStartTime | 是  | 预约开始时间，单位ms                                                           |
| appointEndTime | 是  | 预约结束时间，单位ms                                                           |
| deviceStatus | 是  | 0-未升级, 1-升级中, 2-升级成功, 3-升级失败                                          |
| userConfirmStatusDesc | 是  | 用户确认状态，0未确认(默认)，1马上升级(确认随时升级)，2预约升级(预约指定时间窗口升级)，3(取消预约和取消升级)，4升级结果已确认 |
| comVerList | 否  | 组件升级信息QuecOTAComponetModel 数据源                                        | 
| autoUpgrade | 否  | 暂时无用参数                                                                | 
| deviceStatusDesc | 否  | 设备升级状态描述                                                              | 
| userConfirmStatus | 是  | 用户确认状态：0-未确认，1-马上升级                                                   |
| upgradeProgress | 是  | 升级进度                                                                  |
| productKey | 是  | 设备pk                                                                  |
| deviceKey | 是  | 设备dk                                                                  |

####  查询可升级设备数

```
- (void)getUserlsHaveDeviceUpgrade:(NSString *)fId success:(void (^)(NSInteger))success failure:(void (^)(NSError *))failure;
```

|参数|    是否必传| 说明              |    
| --- | --- |-----------------| 
| fId |    是| 家庭id，家居模式下传入    |
| success |    否| 接口请求成功回调  | 
| failure |    否| 接口请求失败回调        | 

####  有升级计划的设备列表

```
- (void)getUpgradePlanDeviceList:(NSString *)fId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(void (^)(QuecOTADeviceListModel *))success failure:(void (^)(NSError *))failure;
```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| fId |    是|家庭id，家居模式下传入|
| page |     否 | 当前页 | 
| pageSize |     否 | 每页数量    | 
| success |    否|接口请求成功回调 | 
| failure |    否|接口请求失败回调 | 

#### QuecOTADeviceListModel类

|参数| 类型         | 说明                    |    
| --- |------------|-----------------------| 
| page | NSInteger  | 当前页                   |
| totalCount | NSInteger  | 总数量                   |
| list | NSArray    | QuecOTADeviceModel数据源 |
| pageSize | NSInteger  | 每页数量                  |

#### QuecOTADeviceModel类

|参数| 类型         | 说明                             |    
| --- |------------|--------------------------------| 
| productKey | NSString  | 产品pk                           |
| deviceKey | NSString  | 设备dk                           |
| deviceName | NSString    | 设备名称                           |
| version | NSString  | 版本编号/升级计划名称                    |
| desc | NSString  | 版本介绍/升级计划文案/版本包备注              |
| deviceStatus | NSInteger  | 设备状态：0-未升级，1-升级中，2-升级成功，3-升级失败 |
| productIcon | NSString  | 产品Icon                         |
| enabledTime | NSString    | 暂未用到                           |
| enabledTimeTs | NSTimeInterval  | 暂未用到                           |
| planId | long long  | 升级计划id                            |
| userConfirmStatus | NSInteger  | 用户确认状态：0-未确认，1-马上升级                           |

####  用户批量确认升级计划

```
- (void)userBatchConfirmUpgradeWithList:(NSArray<QuecOTAPlanParamModel *> *)list success:(void(^)(NSDictionary *data))success failure:(void (^)(NSError *error))failure;
```

|参数|    是否必传| 说明       |    
| --- | --- |----------| 
| list |    是| 数据源      |
| success |    否| 接口请求成功回调 | 
| failure |    否| 接口请求失败回调 | 

####   批量查询设备升级详情

```
- (void)getBatchUpgradeDetailsWithList:(NSArray<QuecOTAPlanParamModel *> *)list success:(void(^)(NSArray<QuecOTAPlanModel *> *data))success failure:(void (^)(NSError *error))failure;
```

|参数|    是否必传| 说明       |    
| --- | --- |----------| 
| list |    是| 数据源      |
| success |    否| 接口请求成功回调 | 
| failure |    否| 接口请求失败回调 | 

#### QuecOTAPlanParamModel类

|参数| 类型         | 说明                             |    
| --- |------------|--------------------------------| 
| pk | NSString  | 产品pk                           |
| dk | NSString  | 设备dk                           |
| appointStartTime | NSTimeInterval    | 预约开始时间，单位ms，仅用于确认计划                           |
| appointEndTime | NSTimeInterval  | 预约结束时间，单位ms，仅用于确认计划                   |
| operType | NSInteger  | 操作类型:1-马上升级(确认随时升级)2-预约升级(预约指定时间窗口升级) 3-(取消预约和取消升级)5-重试              |
| planId | long long  | 升级计划id |



## 家居SDK QuecSmartHomeKit

### QuecSmartHomeService类  

#### 获取单例对象
```
+ (instancetype)sharedInstance;

```

#### 启用停用家居模式
```
- (void)enabledFamilyMode:(BOOL)familyMode success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| familyMode |	是|启用停用家居模式	| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 启用停用自动切换
```
- (void)enabledAutoSwitch:(BOOL)autoSwitch success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| autoSwitch |	是|启用停用自动切换| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 


#### 查询用户的家居模式配置
```
- (void)getFamilyModeConfigWithSuccess:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 

#### 创建家庭
```
- (void)addFamilyWithFamilyParamModel:(QuecFamilyParamModel *)familyParamModel success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| familyParamModel |	是|QuecFamilyParamModel| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 



#### 修改家庭信息
```
- (void)setFamilyWithFamilyParamModel:(QuecFamilyParamModel *)familyParamModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| familyParamModel |	是|QuecFamilyParamModel| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 



#### 删除家庭
```
- (void)deleteFamilyWithFid:(NSString *)fid success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是|家庭id| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 



#### 查询当前家庭
```
- (void)getCurrentFamilyWithFid:(NSString *)fid currentCoordinates:(NSString *)currentCoordinates success:(void(^)(QuecFamilyItemModel *))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	否|家庭id| 
| currentCoordinates |	否|当前GPS定位坐标，WGS84坐标系，格式：40.759186,-73.928204| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 



#### 查询家庭列表
```
- (void)getFamilyListWithRole:(NSString *)role pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecFamilyItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| role |	否|角色，成员角色：1-创建者  2-管理员 | 
| pageNumber |	否|页码，默认1| 
| pageSize |	否|页大小，默认10| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 


#### 查询家庭中设备列表
```
- (void)getFamilyDeviceListWithFid:(NSString *)fid isAddOwnerDevice:(BOOL)isAddOwnerDevice deviceName:(NSString *)deviceName pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecFamilyDeviceItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是|家庭id |
| isAddOwnerDevice |	否|是否加上自己的所有设备 | 
| deviceName |	否|设备名称| 
| pageNumber |	否|页码，默认1| 
| pageSize |	否|页大小，默认10| 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 



#### 添加常用设备
```
- (void)addCommonUsedDeviceWithFid:(NSString *)fid deviceList:(NSArray *)deviceList success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是|家庭id |
| deviceList |	是|设备列表：{@"dk":@"",@"pk":@""} | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 




#### 移除常用设备
```
- (void)deleteCommonUsedDeviceWithFid:(NSString *)fid deviceList:(NSArray *)deviceList success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是|家庭id |
| deviceList |	是|设备列表：{@"dk":@"",@"pk":@""} | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 





#### 查询常用设备列表
```
- (void)getCommonUsedDeviceListWithFid:(NSString *)fid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecFamilyDeviceItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是|家庭id |
| pageNumber |	否|页码，默认1 | 
| pageSize |	否|页大小，默认10 | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 




#### 创建房间
```
- (void)addFamilyRoomWithFid:(NSString *)fid roomName:(NSString *)roomName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是|家庭id |
| roomName |	是|房间名称 | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 





#### 设置房间
```
- (void)setFamilyRoomWithFrid:(NSString *)frid roomName:(NSString *)roomName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是|家庭id |
| roomName |	是|房间名称 | 
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	| 



#### 删除房间
```
- (void)deleteFamilyRoomsWithIds:(NSArray<NSString *> *)fridList success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fridList |	是| 房间id列表|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####  移入设备到房间
```
- (void)addDeviceInFamilyRoomWithDeviceList:(NSArray *)deviceList success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| deviceList |	是| 设备列表：{@"dk":@"",@"pk":@"", @"oldFrid":@"",@"newFrid":@""}|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####  设置房间排序
```
- (void)setFamilyRoomSortWithRoomRortList:(NSArray *)roomSortList success:(QuecDictionaryBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| roomSortList |	是| 房间排序列表:@{@"frid":@"", @"roomSort":@""}|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####  查询房间中设备列表
```
- (void)getFamilyRoomDeviceListWithFrid:(NSString *)frid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecFamilyDeviceItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| frid |	是| 家庭房间id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




####  查询家庭中的房间列表
```
- (void)getFamilyRoomListWithFid:(NSString *)fid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecFamilyRoomItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####  邀请家庭成员
```
- (void)inviteFamilyMemberWithModel:(QuecInviteFamilyMemberParamModel *)inviteModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| inviteModel |	是| QuecInviteFamilyMemberParamModel，邀请信息|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####   家庭成员邀请的处理
```
- (void)familyMemberInviteHandleWithFid:(NSString *)fid decide:(NSInteger)decide success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| decide |	是|0：拒绝邀请，1：同意邀请|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


####   修改家庭成员名称
```
- (void)setFamilyMemberNameWithFid:(NSString *)fid memberUid:(NSString *)memberUid memberName:(NSString *)memberName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| memberUid |	是|家庭成员用户Id|
| memberName |	是|成员名称|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####   修改家庭成员角色
```
- (void)setFamilyMemberRoleWithFid:(NSString *)fid memberUid:(NSString *)memberUid memberRole:(NSString *)memberRole success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| memberUid |	是|家庭成员用户Id|
| memberRole |	是|2：管理员，3：普通成员|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####   移除家庭成员
```
- (void)deleteFamilyMemberWithFid:(NSString *)fid memberUid:(NSString *)memberUid success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| memberUid |	是|家庭成员用户Id|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|


####   离开家庭
```
- (void)leaveFamilyWithFid:(NSString *)fid success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####  查询家庭中的家庭成员列表
```
- (void)getFamilyMemberListWithFid:(NSString *)fid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecFamilyMemberItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




####   查询被邀请列表
```
- (void)getFamilyInviteListWithPageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecInviteItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




####   查询家庭设备组列表
```
- (void)getFamilyGroupListWithFid:(NSString *)fid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray <QuecFamilyDeviceGroupInfoModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




####  通过SN绑定设备
```
- (void)bindDeviceByFid:(NSString *)fid SerialNumber:(NSString *)serialNumber productKey:(NSString *)productKey deviceName:(NSString *)deviceName success:(void(^)(NSDictionary *dataDict))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| serialNumber |	是| 设备SN码|
| productKey |	是| product key|
| deviceName |	否| 设备名称|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




####  添加家庭设备分组
```
- (void)addFamilyDeviceGroupWithInfo:(QuecFamilyDeviceGroupModel *)groupInfoModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| groupInfoModel |	是| QuecFamilyDeviceGroupModel ，分组信息|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|





####    获取分组列表
```
- (void)getDeviceGroupListWithFid:(NSString *)fid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecFamilyDeviceItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|





####    通过authCode绑定设备
可用于wifi/wifi+蓝牙设备绑定

```
- (void)bindDeviceByFid:(NSString *)fid authCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| authCode |	是| 设备authCode|
| productKey |	是| product key|
| deviceKey |	是| device key|
| deviceName |	否| deviceName|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|





####    查询不在家庭设备组内的设备列表
```
- (void)getDeviceListByNotInDeviceGroupWithFid:(NSString *)fid PageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize groupId:(NSString *)groupId success:(void(^)(NSArray <QuecFamilyDeviceItemModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####    通过authCode绑定设备
可用于wifi/wifi+蓝牙设备绑定，兼容旧方法新增返回参数

```
- (void)bindDeviceAndGetDeviceInfoByFid:(NSString *)fid authCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName success:(void (^)(NSDictionary *dictionary))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| authCode |	是| 设备authCode|
| productKey |	是| product key|
| deviceKey |	是| device key|
| deviceName |	否| deviceName|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




####    编辑设备信息

```
- (void)setDeviceInfoWithModelArray:(NSArray<QuecSetDeviceInfoModel *> *)modelArray success:(void(^)(NSDictionary *dataDict))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| modelArray |	是| 设备信息|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|




####    通过authCode绑定设备
可用于wifi/wifi+蓝牙设备绑定，兼容旧方法新增设备连网能力入参

```
- (void)bindWifiDeviceByFid:(NSString *)fid authCode:(NSString *)authCode productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey deviceName:(NSString *)deviceName capabilitiesBitmask:(NSInteger)capabilitiesBitmask success:(void (^)(NSDictionary *dictionary))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭Id|
| authCode |	是| 设备authCode|
| productKey |	是| product key|
| deviceKey |	是| device key|
| deviceName |	否| deviceName|
| capabilitiesBitmask |	否| 设备连网能力|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



#### QuecFamilyDeviceGroupInfoModel

|参数| 类型 | 说明                                                                    |    
| --- |----|-----------------------------------------------------------------------| 
| name | NSString  | 名称                                                                |
| fid | NSString  | 家庭ID                                                              |
| address | NSString  | 地址                                                                  |
| contactPhoneList | NSString  | 联系人                                                                   |
| coordinate | NSString  | 经纬度                                                           | 
| coordinateSystem | NSString  | 坐标系                                                           | 
| descrip | NSString  | 说明                                                           |
| manager | NSString  | 管理员                                                           |
| managerType | NSString  | 管理员类型                                          |
| parentId | NSString  | 父设备组ID |
| extend | NSString  | 拓展字段                                        | 
| dgid | NSString  | 分组ID                                                                | 
| owner | NSString  | 拥有者                                                              | 
| addTime | NSString  | 添加时间                                                   |
| addTimeTs | NSInteger  | 添加时间戳                                                                  |



#### QuecFamilyDeviceGroupModel

|参数| 类型 | 说明                                                                    |    
| --- |----|-----------------------------------------------------------------------| 
| name | NSString  | 名称                                                                |
| fid | NSString  | 家庭ID                                                              |
| address | NSString  | 地址                                                                  |
| contactPhoneList | NSString  | 联系人                                                                   |
| coordinate | NSString  | 经纬度                                                           | 
| coordinateSystem | NSString  | 坐标系                                                           | 
| descrip | NSString  | 说明                                                           |
| manager | NSString  | 管理员                                                           |
| managerType | NSString  | 管理员类型                                          |
| parentId | NSString  | 父设备组ID |
| extend | NSString  | 拓展字段                                        |



#### QuecFamilyDeviceListParamsModel

|参数| 类型 | 说明                                                                    |    
| --- |----|-----------------------------------------------------------------------| 
| fid | NSString  | 家庭ID                                                                |
| isAddOwnerDevice | BOOL  | 是否加上自己的所有设备，非必须                                                               |
| deviceName | NSString  | 设备名称搜索, 非必须                                                                |
| pageNumber | NSInteger  | 页码，非必填，默认1                                                                   |
| pageSize | NSInteger  | 页大小，非必填，默认10                                                           | 
| isGroupDeviceShow | BOOL  | 是否显示群组设备，默认缺省                                                           | 
| isAssociation | BOOL  | 查询未被关联的设备, 默认 false                                                           |
| secondItemCode | NSString  | 二级品类过滤, 默认为空                                                           |
| pkList | NSString  | 增加pklist, 多pk用逗号隔开                                         |



#### QuecFamilyItemModel

|参数| 类型 | 说明                      |    
| --- |----|-------------------------| 
| fid | NSString  | 家庭ID                    |
| familyName | NSString  | 名称                      |
| familyLocation | NSString  | 家庭位置                    |
| familyCoordinates | NSString  | 家庭经纬度                   |
| addTime | NSString  | 添加时间                    | 
| addTimeTs | NSInteger  | 添加时间戳                   | 
| memberRole | NSInteger  | 角色,1-创建者  2-管理员  3-普通成员 |
| currentRoom | QuecFamilyRoomItemModel  | 二级模型                    |
| rooms | NSArray<QuecFamilyRoomItemModel *>  | 二级模型      |


####  更新家庭列表
```
- (void)updateRooms:(NSArray<QuecFamilyRoomItemModel *> *)rooms;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| rooms |	是| NSArray<QuecFamilyRoomItemModel *>|


####  设置当前房间
```
- (void)setSelectRoom:(QuecFamilyRoomItemModel *)room;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| room |	是| QuecFamilyRoomItemModel|



#### QuecFamilyMemberItemModel

|参数| 类型 | 说明                  |    
| --- |----|---------------------| 
| uid | NSString  | 用户Id                |
| phone | NSString  | 手机号                  |
| nikeName | NSString  | 昵称                |
| sex | NSInteger  | 性别               |
| address | NSString  | 地址                | 
| email | NSString  | 邮箱               | 
| headimg | NSString  | 头像 |
| wechatMiniprogramUserId | NSString  | 小程序Id                |
| wechatUnionId | NSString  | 微信Id      |
| appleUserId | NSString  | apple Id      |
| twitterUserId | NSInteger  | twitter Id      |
| facebookUserId | NSString  | facebook Id      |
| alipayUserId | NSString  | alipay Id      |
| qqUserId | NSString  | qq Id      |
| wechatOffiaccountUserId | NSString  | wechatOffiaccount Id      |
| registerTime | NSString  | 注册时间      |
| registerTimeTs | NSInteger  | 注册时间戳      |
| lastLoginTime | NSString  | 上次登录时间 |
| lastLoginTimeTs | NSInteger  | 上次登录时间戳 |
| timezone | NSString  | 时区  |
| nationality | NSString  | 国家  |
| province | NSString  | 省   |
| city | NSString  | 市   |
| lang | NSString  | 语言   |
| status | NSInteger  | 状态   |
| signature | NSString  | 签名   |
| remark | NSString  | 备注   |
| memberRole | NSInteger  | 角色类型   |
| memberName | NSString  | 名称   |



#### QuecFamilyParamModel

|参数| 类型 | 说明                      |    
| --- |----|-------------------------| 
| fid | NSString  | 家庭Id,更改家庭信息和删除家庭时必传，创建家庭不用传                    |
| familyName | NSString  | 名称，创建家庭时该参数必传，更改家庭非必传                      |
| familyLocation | NSString  | 家庭位置，非必传                    |
| familyCoordinates | NSString  | 家庭经纬度，WGS84坐标系，格式：40.759186,-73.928204, 非必传                   |
| familyRoomList | NSArray<NSString *>  | 房间列表,非必传                    |



#### QuecFamilyRoomItemModel

|参数| 类型 | 说明                      |    
| --- |----|-------------------------| 
| fid | NSString  | 家庭Id                    |
| roomName | NSString  | 房间名称                      |
| roomSort | NSInteger  | 房间排序                    |



#### QuecInviteFamilyMemberParamModel

|参数| 类型 | 说明                      |    
| --- |----|-------------------------| 
| fid | NSString  | 家庭Id，邀请成员时必填                    |
| memberRole | NSString  | 成员角色：2-管理员  3-普通成员，邀请成员时必填                      |
| memberName | NSString  | 成员名称，邀请成员时非必填                    |
| invalidTime | NSInteger  | 邀请失效时间，毫秒时间戳，邀请成员时必填                   |
| phone | NSString  | 手机号，邀请成员时非必填                    |
| email | NSString  | 邮箱，邀请成员时非必填                    |
| uid | NSString  | 用户Id，邀请成员时非必填                    |



#### QuecInviteFamilyMemberParamModel

|参数| 类型 | 说明                      |    
| --- |----|-------------------------| 
| fid | NSString  | 家庭ID                    |
| familyName | NSString  | 名称                      |
| familyLocation | NSString  | 家庭位置                    |
| familyCoordinates | NSString  | 家庭经纬度                   |
| addTime | NSString  | 添加时间                    | 
| addTimeTs | NSInteger  | 添加时间戳                   |
| invalidTime | NSString  | 邀请时间                    |



#### QuecSetDeviceInfoModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| fid | NSString | 家庭ID  |
| dk | NSString | 设备dk  |
| pk | NSString | 设备pk  |
| deviceName | NSString | 设备名称 |
| isCommonUsed | BOOL     | 是否常用：true-常用，false-不是常用  | 
| type | int       | 设备类型：1-家庭中的设备，2-用户接收分享的设备，3-用户多绑模式的设备 |
| oldFrid | NSString | 移出房间ID  |
| selectFrid | NSString | 移入房间ID  |
| shareCode | NSString | 分享码  |



## 场景SDK QuecSceneKit

### QuecSceneService类

#### 获取单例对象
```
+ (instancetype)sharedInstance;

```


####   新增场景
```
- (void)addSceneWithSceneModel:(QuecSceneModel *)sceneModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| sceneModel |	是| QuecSceneModel|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####   编辑场景
```
- (void)editSceneWithSceneModel:(QuecSceneModel *)sceneModel success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| sceneModel |	是| QuecSceneModel|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####   删除场景
```
- (void)deleteSceneWithFid:(NSString *)fid sceneId:(NSString *)sceneId success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| fid |	是| 家庭id|
| sceneId |	是| 场景Id|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####   获取场景列表
```
- (void)getSceneListWithFid:(NSString *)fid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecSceneModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|	
| --- | -- | --- | 
| fid |	是| 家庭id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	| 
| failure |	否|接口请求失败回调	|



####   获取常用场景列表
```
- (void)getCommonSceneListWithFid:(NSString *)fid pageNumber:(NSInteger)pageNumber pageSize:(NSInteger)pageSize success:(void(^)(NSArray<QuecSceneModel *> *list, NSInteger total))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |	是| 家庭id|
| pageNumber |	否| 页码，默认1|
| pageSize |	否| 页大小，默认10|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   执行场景
```
- (void)executeSceneWithFid:(NSString *)fid sceneId:(NSString *)sceneId success:(void(^)(QuecActionExecuteResultModel *executeResultModel))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |	是| 家庭id|
| sceneId |	是| 场景id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   测试场景
```
- (void)executeTestSceneWithSceneModel:(QuecSceneModel *)sceneModel success:(void(^)(QuecActionExecuteResultModel *executeResultModel))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| sceneModel |	是| QuecSceneModel|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询场景详情
```
- (void)getSceneInfoWithFid:(NSString *)fid sceneId:(NSString *)sceneId success:(void(^)(QuecSceneModel * scene))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |	否| 家庭id|
| sceneId |	是| 场景id，必传|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   获取场景日志列表
```
- (void)getSceneLogListWithFid:(NSString *)fid lastExecutionId:(long)lastExecutionId limit:(NSInteger)limit success:(void(^)(NSArray<QuecSceneLogItemModel *> *list))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |	否| 家庭id|
| lastExecutionId |	否| 最后一条执行日志的id|
| limit |	否| 数量|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   获取场景日志列表
```
- (void)clearSceneLogWithFid:(NSString *)fid success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |	否| 家庭id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   获取场景日志详情
```
- (void)getSceneLogDetailInfoWithExecutionId:(long)executionId success:(void(^)(QuecSceneLogItemModel *detailInfo))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| executionId |	是| 场景日志执行Id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   批量增加常用场景
```
- (void)batchAddCommonSceneWithFid:(NSString *)fid sceneList:(NSArray *)sceneList success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |	否| 家庭id|
| sceneList |	是| 场景Id数组|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   批量删除常用场景
```
- (void)batchDeleteCommonSceneWithFid:(NSString *)fid sceneList:(NSArray *)sceneList success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |	否| 家庭id|
| sceneList |	是| 场景Id数组|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



#### QuecActionExecuteResultModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| executeResult | BOOL | 执行结果  |
| failCount | NSInteger | 失败结果  |
| successCount | NSInteger | 成功结果  |
| failActionList | NSArray<QuecFailActionModel *> | 成功结果 |
| isCommonUsed | BOOL     | 是否常用：true-常用，false-不是常用  | 



#### QuecFailActionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| productKey | NSString | 产品pk  |
| deviceName | NSString | 设备名称  |
| imageLogo | NSString | 设备图片  |
| deviceKey | NSString | 设备dk |



#### QuecSceneActionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| code | NSString | 物模型code  |
| itemId | NSInteger | 物模型id  |
| dataType | NSString | 物模型数据类型  |
| name | NSString | 物模型name |
| subName | NSString | 物模型值 name  |
| subType | NSString | 物模型subType  |
| unit | NSString | 物模型单位  |
| value | id | 物模型值 可能是基本数据类型，可能是NSArray<QuecSceneActionModel *>类型 |
| type | NSString | 物模型 type |



#### QuecSceneLogItemModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| sceneId | NSString | 场景Id  |
| sceneName | NSString | 场景名称  |
| sceneIcon | NSString | 场景icon  |
| executionId | long | 执行id |
| executionTime | long | 执行时间  |
| executionResult | int | 执行结果  |
| executionList | NSArray<QuecSceneLogExecutionModel *> | 执行结果  |



#### QuecSceneLogExecutionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| productKey | NSString | 产品pk  |
| deviceKey | NSString | 设备dk  |
| deviceName | NSString | 设备名称  |
| logoImage | NSString | 设备图片 |
| executionResult | int | 执行结果  |
| actionResultList | NSArray<QuecSceneLogActionModel *> | 执行结果  |



#### QuecSceneLogActionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| result | BOOL | result  |
| reason | NSString | 原因  |
| createTime | long | 时间戳  |
| action | QuecSceneActionModel | 物模型 |



#### QuecSceneModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| fid | NSString | 家庭Id  |
| isCommon | BOOL | 是否常用  |
| sceneInfo | long | 时间戳  |
| action | QuecSceneInfoModel | 场景详情 |



#### QuecSceneInfoModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| sceneId | NSString | 场景Id  |
| name | NSString | 场景名称  |
| icon | NSString | 场景Icon  |
| metaDataList | NSArray<QuecSceneMetaDataModel *> | 场景设备动作列表 |



#### QuecSceneMetaDataModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| actionList | NSArray<QuecSceneActionModel *> | 设备动作列表  |
| deviceKey | NSString | 设备dk  |
| productKey | NSString | 产品pk  |
| deviceName | NSString | 设备名称 |
| imageLogo | NSString | 设备icon |
| deviceType | NSInteger | 设备类型 1 默认普通设备 2 群组 |



## 自动化SDK QuecAutomateKit

### QuecAutomateService类
####   创建自动化
```
+ (void)addAutomationWithModel:(QuecAutomateModel *)model
                       success:(QuecVoidBlock)success
                       failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| model |是| QuecAutomateModel|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   编辑自动化
```
+ (void)editAutomationWithModel:(QuecAutomateModel *)model
                        success:(QuecVoidBlock)success
                        failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| model |是| QuecAutomateModel|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询自动化列表
```
+ (void)getAutomationListWithFid:(nullable NSString *)fid
                      pageNumber:(NSInteger)pageNumber
                        pageSize:(NSInteger)pageSize
                         success:(QuecAutomationModelsSuccessBlock)success
                         failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |否| 家庭ID，开启家居模式必填，否则不填|
| pageNumber |否| 分页当前页码,默认 1|
| pageSize |否| 分页每页条数,默认 10|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   启停自动化
```
+ (void)updateAutomationSwitchStatusWithFid:(nullable NSString *)fid
                               automationId:(long long)automationId
                                     status:(BOOL)status
                                    success:(QuecVoidBlock)success
                                    failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |否| 家庭ID，开启家居模式必填，否则不填|
| automationId |是| 自动化ID|
| status |是| 启停状态，启用：true，停用：false|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|


####   删除自动化
```
+ (void)deleteAutomationWithFid:(nullable NSString *)fid
                   automationId:(long long)automationId
                        success:(QuecVoidBlock)success
                        failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |否| 家庭ID，开启家居模式必填，否则不填|
| automationId |是| 自动化ID|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询自动化详情
```
+ (void)getAutomationInfoWithFid:(nullable NSString *)fid
                    automationId:(long long)automationId
                         success:(void(^)(QuecAutomateModel *model))success
                         failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |否| 家庭ID，开启家居模式必填，否则不填|
| automationId |是| 自动化ID|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   测试自动化
```
+ (void)testAutomationInfoWithModel:(QuecAutomateModel *)automateModel
                            success:(void(^)(long long testResultId))success
                            failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| automateModel |是| QuecAutomateModel|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询自动化测试结果
```
+ (void)getTestAutomationResultWithId:(long long)testResultId
                              success:(QuecAutomationResultSuccessBlock)success
                              failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| testResultId |是| 测试结果ID|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询联动配置
```
+ (void)getAutomationTSLWithProductKey:(NSString *)productKey
                                  type:(NSInteger)type
                               success:(QuecAutomationPropertySuccessBlock)success
                               failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| productKey |是| 产品KEY|
| type |是| 查询类型：0：全部，1：条件，2：动作|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   获取自动化日志列表
```
+ (void)getAutomationLogListWithFid:(NSString *)fid lastLogId:(long long)lastLogId limit:(NSInteger)limit success:(void(^)(NSArray<QuecAutomationLogItemModel *> *list))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |否| 家庭id|
| lastLogId |是| 最后一个日志id，分页使用|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|


####   获取自动化日志详情
```
+ (void)getAutomationLogDetailWithFid:(NSString *)fid logId:(long long)logId success:(void(^)(QuecAutomationLogItemModel *detailInfo))success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| logId |是| 日志id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|


####   删除自动化执行日志
```
+ (void)clearAutomationLogsWithFid:(NSString *)fid success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| fid |否| 家庭id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



#### QuecAutomateModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| automationId | long long | 自动化ID  |
| fid | NSString | 家庭ID，开启家居模式必填，否则不填  |
| conditionType | QuecAutomateConditionRuleType | 触发类型 1: 满足任意，2: 满足所有  |
| name | NSString | 自动化名称  |
| nameType | NSInteger | 自动化名称生成方式，1：系统生成，2：用户填写  |
| status | BOOL | 自动化执行状态true：启用，false：停用  |
| precondition | QuecAutomationPreconditionModel | 自动化生效时间  |
| conditions | NSArray<QuecAutomationConditionModel *> | 自动化触发条件  |
| actions | NSArray<QuecAutomationActionModel *> | 自动化执行动作  |



#### QuecAutomateConditionRuleType

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| QuecAutomateConditionRuleAny | NSInteger | 1: 满足任意  |
| QuecAutomateConditionRuleAny | NSInteger | 2: 满足所有  |



#### QuecAutomationPreconditionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| effectDateType | QuecAutomateEffectDateType | 生效日期类型。0：每天，1：每周，2：每月，3：指定日期  |
| effectTimeType | QuecAutomateEffectTimeType | 生效时间类型。0：白天，1：夜晚，2：全天，3：指定时间段  |
| startTime | NSString | 开始时间。生效时间类型为全天和指定时间段时必填，符合HH:mm格式  |
| endTime | NSString | 结束时间。生效时间类型为全天和指定时间段时必填，符合HH:mm格式  |
| effectDate | NSString | 生效日期。生效日期类型为每天时不填。每周：1,2,3,...7表示周一到周日，周月：1-31号，指定日期：符合MM-dd/MM-dd格式，例：12-19/12-2  |
| regionName | NSString | 地区名称  |
| location | NSString | 经纬度  |
| timeZone | NSString | 时区  |



#### QuecAutomationConditionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| type | NSInteger | 0设备触发 1时间触发  |
| icon | NSString | 设备/群组/场景图标  |
| name | NSString | 设备/群组/场景名称  |
| timer | QuecAutomationTimeModel | 自动化触发条件时间  |
| productKey | NSString | 产品PK  |
| deviceKey | NSString | 设备DK  |
| property | QuecAutomationPropertyModel | 物模型属性  |
| sort | NSInteger | 条件顺序，从1开始递增  |



#### QuecAutomationActionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| type | NSInteger | 执行动作类型。1：延时，2：设备，3：群组，4：场景  |
| icon | NSString | 设备/群组/场景图标  |
| name | NSString | 设备/群组/场景名称  |
| productKey | NSString | 产品PK  |
| deviceKey | NSString | 设备DK  |
| sceneId | NSString | 场景ID  |
| delayTime | NSNumber | 延迟时间，单位秒  |
| property | QuecAutomationPropertyModel | 物模型属性  |
| sort | NSInteger | 条件顺序，从1开始递增  |



#### QuecAutomateEffectDateType

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| QuecAutomateEffectDateTypeEveryday | NSInteger | 0 每天  |
| QuecAutomateEffectDateTypeWeekly | NSInteger | 1 每周的 |
| QuecAutomateEffectDateTypeMonthly | NSInteger | 2 每月  |
| QuecAutomateEffectDateTypeNamedDate | NSInteger | 3 指定日期    |



#### QuecAutomateEffectTimeType

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| QuecAutomateEffectTimeTypeDaytime | NSInteger | 0 白天  |
| QuecAutomateEffectTimeTypeNight | NSInteger | 1 夜晚 |
| QuecAutomateEffectTimeTypeWholeDay | NSInteger | 2 全天  |
| QuecAutomateEffectTimeTypeSpecificTimePeriod | NSInteger | 3 特定时间段    |



#### QuecAutomationTimeModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| type | NSInteger | 定时时间类型 定时时间  0仅一次 1每天 2 自定义  |
| time | NSString | 定时时间 |
| dayOfWeek | NSString | 定时自定义时间段的周天组合  |
| timeZone | NSString | 时区    |



#### QuecAutomationPropertyModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| identifier | NSInteger | 物模型id，由于 id 是 Objective-C 的关键字，所以使用 identifier  |
| code | NSString | 物模型code |
| dataType | NSString | 数据类型  |
| value | NSString | 值    |
| name | NSString | 物模型name    |
| compare | NSString | 属性值比较运算符    |
| unit | NSString | 单位    |
| subName | NSString | 描述    |



#### QuecAutomationLogItemModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| logId | long long | 执行日志ID  |
| automationId | long long | 自动化ID |
| name | NSString | 自动化名称  |
| icon | NSString | 自动化图标    |
| time | long long | 执行时间    |
| result | NSInteger | 执行结果:0.成功 1.失败 2.部分成功    |
| logDetails | NSArray<QuecAutomationLogItemActionModel *> | 执行日志详情    |



#### QuecAutomationLogItemActionModel

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| actionName | NSString | 执行动作名称，设备名称/场景名称/群组ID  |
| actionIcon | NSString | 执行动作图标，设备/群组/群组 |
| type | NSInteger | 执行动作类型。2：设备，3：群组，4：场景  |
| result | BOOL | 执行结果，1：成功，0：失败    |
| action | QuecAutomationPropertyModel | 物模型属性    |
| executeTime | long long | 执行时间    |



## 群组SDK QuecGroupKit

### QuecGroupService类



####   创建群组
```
+ (void)createGroupWithBean:(QuecGroupCreateBean *)bean
                    success:(QuecCreateGroupSuccess)success
                    failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| bean |是| QuecGroupCreateBean|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询群组详情
```
+ (void)getGroupInfoWithId:(NSString *)groupId
                   success:(QuecGroupBeanSuccess)success
                   failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询群组基础信息
```
+ (void)getGroupDeviceInfoWithId:(NSString *)groupId
                         success:(QuecGroupDeviceSuccess)success
                         failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   批量设备判断是否可加入群组
```
+ (void)checkDeviceAddGroupWithList:(NSArray<QuecGroupCreateDeviceBean *> *)deviceList
                                fid:(NSString *)fid
                            success:(QuecGroupCheckDeviceSuccess)success
                            failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| deviceList |否| NSArray<QuecGroupCreateDeviceBean *>|
| fid |否| 家庭id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   可添加设备列表
```
+ (void)getAddableListWithList:(NSArray<QuecGroupCreateDeviceBean *> *)addedList
                           fid:(NSString *)fid
                          gdid:(nullable NSString *)gdid
                      pageSize:(NSInteger)pageSize
                          page:(NSInteger)page
                       success:(QuecGroupAddableListSuccess)success
                       failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| addedList |是| NSArray<QuecGroupCreateDeviceBean *>|
| fid |否| 家庭id|
| gdid |否| 群组id|
| pageSize |否|查询的页大小，默认 10	|
| page |否|查询的列表页，默认为 1	|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



### QuecGroupService+control类
####   控制群组
```
+ (void)controlGroupByHttp:(NSArray<QuecIotDataPoint*> *)dps
                   groupId:(NSString *)groupId
                 extraData:(NSDictionary *)extraData
                   success:(QuecDictionaryBlock)success
                   failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| dps |是| dps数组|
| groupId |是| 群组id|
| extraData |否| { type 类型 1：透传 2：属性 3：服务 dataFormat 数据类型 1：Hex 2：Text（当type为透传时，需要指定 dataFormat） cacheTime 缓存时间，单位为秒，缓存时间范围 1-7776000 秒，启用缓存时必须设置缓存时间 isCache  是否启用缓存 1：启用 2：不启用，默认不启用 isCover 是否覆盖之前发送的相同的命令 1：覆盖 2：不覆盖，默认不覆盖，启用缓存时此参数有效 }|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询群组物模型属性值
```
+ (void)groupAttributesById:(NSString *)groupId
                   codeList:(NSString *)codeList
                    success:(void (^)(QuecProductTSLInfoModel *tslInfoModel))success
                    failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| codeList |否| 需要查询的属性值，用英文逗号拼接|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询群组物模型属性,包含属性值
```
+ (void)groupAttributesById:(NSString *)groupId
                   codeList:(NSString *)codeList
                    success:(void (^)(QuecProductTSLInfoModel *tslInfoModel))success
                    failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| productKey |是| 设备pk|
| codeList |否| 需要查询的属性值，用英文逗号拼接|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



### QuecGroupService+edit类
####   编辑群组基础信息
```
+ (void)editGroupBasicInfoWithId:(NSString *)groupId
                 groupDeviceName:(NSString *)groupDeviceName
                             fid:(nullable NSString *)fid
                            frid:(nullable NSString *)frid
                    isCommonUsed:(BOOL)isCommonUsed
                         success:(QuecVoidBlock)success
                         failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| groupDeviceName |是| 群组名|
| fid |否| 家庭id|
| frid |否| 房间id|
| isCommonUsed |是| 否是常用设备：0-不常用 1-常用|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   编辑群组信息
```
+ (void)editGroupInfoWithId:(NSString *)groupId
                       name:(NSString *)name
                        fid:(NSString *)fid
                       frid:(NSString *)frid
               isCommonUsed:(BOOL)isCommonUsed
                 deviceList:(NSArray<NSDictionary *> *)deviceList
                    success:(QuecDictionaryBlock)success
                    failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| name |是| 群组名|
| fid |否| 家庭id|
| frid |否| 房间id|
| isCommonUsed |是| 否是常用设备：0-不常用 1-常用|
| deviceList |否| 设备列表|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   批量移除/添加群组到常用
```
+ (void)batchAddCommonWithIds:(NSArray<NSString *> *)groupIds
                          fid:(NSString *)fid
                 isCommonUsed:(BOOL)isCommonUsed
                      success:(QuecGroupBatchResultBlock)success
                      failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupIds |是| 群组id列表|
| fid |否| 家庭id|
| isCommonUsed |是| 否是常用设备：0-不常用 1-常用|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|


####   批量移动群组到新房间
```
+ (void)batchMovingWithIds:(NSArray<NSString *> *)groupIds
                   newFrid:(NSString *)newFrid
                   success:(QuecGroupBatchResultBlock)success
                   failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupIds |是| 群组id列表|
| newFrid |是| 新房间id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   批量删除群组
```
+ (void)deleteGroupWithIds:(NSArray<NSString *> *)groupIds
                   success:(QuecGroupBatchResultBlock)success
                   failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupIds |是| 群组id列表|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



### QuecGroupService+share类
####   分享人设置群组分享信息
```
+ (void)getShareCodeWithGroupId:(NSString *)groupId
              acceptingExpireAt:(long)acceptingExpireAt
           isSharingAlwaysValid:(BOOL)isSharingAlwaysValid
                sharingExpireAt:(long)sharingExpireAt
                      coverMark:(NSInteger)coverMark
                        success:(void(^)(NSString *shareCode))success
                        failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| acceptingExpireAt |是| 分享二维码种子失效时间 时间戳（毫秒），表示该分享在此时间戳时间内没有使用，会失效|
| isSharingAlwaysValid |是| 设备是否永久有效|
| sharingExpireAt |否| 设备使用到期时间 时间戳（毫秒），表示该分享的群组，被分享人可以使用的时间<br/>如果不填，则为终生有效|
| coverMark |是| 覆盖标志<br/>1 直接覆盖上条有效分享（默认）（覆盖原有的分享码）<br/>2 直接添加，允许多条并存<br/>3 只有分享时间延长了，才允许覆盖上条分享|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   获取群组分享人列表
```
+ (void)getSharedListsWithGroupId:(NSString *)groupId
                          success:(void(^)(NSArray<QuecShareUserModel *> *list))success
                          failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| groupId |是| 群组id|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   分享人取消分享
```
+ (void)ownerUnShareWithShareCode:(NSString *)shareCode
                          success:(QuecVoidBlock)success
                          failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| shareCode |是| 分享码|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   被分享人取消分享
```
+ (void)unShareWithShareCode:(NSString *)shareCode
                     success:(QuecVoidBlock)success
                     failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| shareCode |是| 分享码|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   被分享人接受分享
```
+ (void)acceptShareWithShareCode:(NSString *)shareCode
                         success:(QuecVoidBlock)success
                         failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| shareCode |是| 分享码|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



####   查询分享群组的信息
```
+ (void)shareGroupInfoWithShareCode:(NSString *)shareCode
                            success:(QuecDictionaryBlock)success
                            failure:(QuecErrorBlock)failure;

```

|参数|	是否必传|说明|
| --- | -- | --- |
| shareCode |是| 分享码|
| success |	否|接口请求成功回调	|
| failure |	否|接口请求失败回调	|



#### QuecGroupBatchResultBean

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| code | NSString | 请求结果code码  |
| msg | NSString | 请求结果提示  |
| gdid | NSString | 群组id  |



#### QuecGroupBean

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| name | NSString | 群组名  |
| fid | NSString | 家庭id  |
| frid | NSString | 房间id  |
| gdid | NSString | 群组id  |
| roomName | NSString | 房间名  |
| onlineStatus | NSUInteger | 设备云端在离线状态：0-离线 1-在线  |
| productKey | NSString | 设备pk  |
| deviceKey | NSString | 设备dk  |
| isCommonUsed | BOOL | 否是常用设备：0-不常用 1-常用  |
| groupDeviceDeviceNum | NSUInteger | 群组包含设备数量  |
| deviceList | NSArray<QuecGroupDeviceBean *> | 群组设备列表  |



#### QuecGroupDeviceBean

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| productKey | NSString | 设备pk  |
| deviceKey | NSString | 设备dk  |
| deviceName | NSString | 设备名  |
| logoImage | NSString | 设备logo图片  |
| frid | NSString | 房间id  |
| roomName | NSString | 房间名  |
| onlineStatus | NSUInteger | 设备云端在离线状态：0-离线 1-在线  |
| msg | NSString | 接口响应消息提示  |
| code | NSUInteger | 接口响应code  |



#### QuecGroupCreateBean

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| groupDeviceName | NSString | 群组名称  |
| fid | NSString | 家庭id  |
| frid | NSString | 房间id  |
| isCommonUsed | BOOL | 是否是常用设备：0-不常用 1-常用  |
| onlineStatus | NSUInteger | 设备云端在离线状态：0-离线 1-在线  |
| deviceList | NSArray<QuecGroupCreateDeviceBean *> | 设备列表  |



#### QuecGroupCreateDeviceBean

|参数| 类型       | 说明    |    
| --- |----------|-------| 
| productKey | NSString | 设备pk  |
| deviceKey | NSString | 设备dk  |



#### QuecGroupCreateResultBean

|参数| 类型       | 说明   |    
| --- |----------|------| 
| groupDeviceInfo | QuecDeviceModel | 设备数据 |
| successList | NSArray<QuecGroupDeviceBean *> | 成功的设备列表 |
| failList | NSArray<QuecGroupDeviceBean *> | 失败的设备列表 |
