
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

#### 查询设备升级信息

```
- (void)getFetchPlanWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey extraInfo:(QuecDeviceOTAQueryModel *)extraInfo success:(void(^)(QuecDeviceOTAPlanModel *planModel))success failure:(QuecErrorBlock)failure;

```
 

|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| extraInfo |    否| QuecDeviceOTAQueryModel类型，其他信息|
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    | 

#### 上报设备升级信息

```
- (void)reportDeviceUpgradeStatusWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey componentNo:(NSString *)componentNo reportStatus:(NSInteger)reportStatus success:(QuecVoidBlock)success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|product key|
| deviceKey |    是|device key|
| componentNo |    是| 升级组件标识|
| reportStatus |    是| 升级状态 0 - 12|
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


#### QuecDeviceService (OTA) 方法

#### 设备升级 - 检查升级计划
```
- (void)checkDeviceOTAPlan:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void (^)(QuecOTAPlanModel *))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是| product key    | 
| deviceKey |    是| device key    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |



#### 设备升级 - 用户确认升级计划
```
- (void)updateDeviceOTAWith:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void (^)(void))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是| product key    | 
| deviceKey |    是| device key    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 - getAutoUpgradeSwitch
```
- (void)autoUpgradeSwitch:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是| product key    | 
| deviceKey |    是| device key    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 - 设置自动升级开关
```
- (void)setAutoUpgradeSwitch:(BOOL)isAuto productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void (^)(void))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| isAuto |     是 | 是否设置为自动升级：NO-否 YES-是    | 
| productKey |    是| product key    | 
| deviceKey |    是| device key    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |



#### 设备升级 -  用户有可升级的设备
```
- (void)userOTADevicesWithFId:(NSString *)fId success:(void (^)(NSInteger))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| fId |     否 | 家庭ID    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |



#### 设备升级 -  获取更新设备列表
```
- (void)otaDeviceListWithFId:(NSString *)fId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(void (^)(QuecOTADeviceListModel *))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| fId |     否 | 家庭ID    | 
| page |     否 | 当前页，默认1    | 
| pageSize |     否 | 每页数量，默认10    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 -  获取自动更新设备列表
```
- (void)autoOtaDeviceListWithFId:(NSString *)fId page:(NSInteger)page pageSize:(NSInteger)pageSize success:(void (^)(QuecOTADeviceListModel *))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| fId |     否 | 家庭ID    | 
| page |     否 | 当前页，默认1    | 
| pageSize |     否 | 每页数量，默认10    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |




#### 设备升级 -  获取用户自动更新开关值
```
- (void)userOTAAutoSwitchWithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 -  设置用户自动更新开关值
```
- (void)setUserOTAAutoSwitch:(BOOL)isAuto success:(void (^)(void))success failure:(void (^)(NSError *))failure;

```

|参数|    是否必传|说明|    
| --- | --- | --- | 
| isAuto |    是|YES-启用 NO-停用    | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |



#### 设备升级 -  批量添加设备进入自动更新
```
- (void)addOTADeviceList:(NSArray *)deviceList fid:(NSString *)fid success:(void (^)(void))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceList |    是|设备列表,deviceList":[{"pk": "string","dk": "string"}]| 
| fid |    否| 家庭id | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 -  批量删除设备的自动更新
```
- (void)deleteOTADeviceList:(NSArray *)deviceList fid:(NSString *)fid success:(void (^)(void))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| deviceList |    是|设备列表,deviceList":[{"pk": "string","dk": "string"}]| 
| fid |    否| 家庭id | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 -  查询设备最近一次升级状态
```
- (void)getLatestUpgradeDetailsWithProductKey:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| productKey |    是|   product key | 
| deviceKey |    是 | device key | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |



#### 设备升级 -  按照planid查询设备升级状态
```
- (void)getUpgradeDetailsByPlanId:(NSString *)planId productKey:(NSString *)productKey deviceKey:(NSString *)deviceKey success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| planId |    是|  计划id | 
| productKey |    是|   product key | 
| deviceKey |    是 | device key | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 -  用户批量确认升级计划
```
- (void)userBatchConfirmUpgradeWithList:(NSArray<QuecOTAPlanParamModel *> *)list success:(void(^)(NSDictionary *data))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| list |    是|  计划列表 | 
| success |    否|接口请求成功回调    | 
| failure |    否|接口请求失败回调    |


#### 设备升级 -  批量查询升级状态
```
- (void)getBatchUpgradeDetailsWithList:(NSArray<QuecOTAPlanParamModel *> *)list success:(void(^)(NSArray<QuecOTAPlanModel *> *data))success failure:(QuecErrorBlock)failure;

```


|参数|    是否必传|说明|    
| --- | --- | --- | 
| list |    是|  计划列表 | 
| productKey |    是|   product key | 
| deviceKey |    是 | device key | 
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
#### 添加配网监听

```
- (void)addSmartConfigDelegate:(id<QuecSmartConfigDelegate>)delegate;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| delegate |	是| 遵循QuecSmartConfigDelegate协议对象	| 


#### 移除配网监听

```
- (void)removeSmartConfigDelegate:(id<QuecSmartConfigDelegate>)delegate;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| delegate |	是| 遵循QuecSmartConfigDelegate协议对象	| 


#### 开启配网(适用wifi+BLE类型设备配网)

```
- (void)startConfigDevices:(NSArray<QuecPeripheralModel *> *)devices ssid:(NSString *)ssid password:(NSString *)password;

```

|参数|	是否必传|说明|	
| --- | --- | --- | 
| devices |	是| BleChannel获取到的外设数据，支持批量加入	| 
| ssid |	否| wifi名称	| 
| password |	否| wifi密码	| 


#### 取消进行域配网所有操作

```
- (void)cancelConfigDevices;

```