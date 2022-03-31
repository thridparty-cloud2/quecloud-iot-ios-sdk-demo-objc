//
//  QuecUserManager.h
//  QuecUserKit
//
//  Created by quectel.steven on 2021/9/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuecUserService : NSObject

// 昵称
@property (nonatomic, copy) NSString *nikeName;
// 手机号
@property (nonatomic, copy) NSString *phone;
// 注册时间
@property (nonatomic, copy) NSString *registerTime;
// 性别
@property (nonatomic, copy) NSString *sex;
// 时区
@property (nonatomic, copy) NSString *timezone;
// 用户ID
@property (nonatomic, copy) NSString *uid;
// 微信ID
@property (nonatomic, copy) NSString *wchartId;
// 微信昵称
@property (nonatomic, copy) NSString *wchartName;
// 地址
@property (nonatomic, copy) NSString *address;
// 邮箱
@property (nonatomic, copy) NSString *email;
// 头像
@property (nonatomic, copy) NSString *headimg;
// 语言
@property (nonatomic, copy) NSString *lang;
// 上次登录时间
@property (nonatomic, copy) NSString *lastLoginTime;
// 国籍
@property (nonatomic, copy) NSString *nationality;
// 登录状态
@property (nonatomic, assign) BOOL isLogon;

/**
 @return return a single instance
 */
+ (instancetype)sharedInstance;

/**
 设置token过期回调
 
 @param callBack callBack block
 */
- (void)setTokenInvalidCallBack:(void(^)(void))callBack;

/**
 获取token
 
 @return token
 */
- (NSString *)getToken;

/**
 获取国家列表
 
 @param success success block
 @param failure failure block
 */
- (void)getNationalityListWithSuccess:(void(^)(NSArray *list))success failure:(void(^)(NSError *error))failure;

/**
 获取时区列表
 
 @param success success block
 @param failure failure block
 */
- (void)getTimezoneListWithSuccess:(void(^)(NSArray *list))success failure:(void(^)(NSError *error))failure;

/**
 获取语言列表
 
 @param success success block
 @param failure failure block
 */
- (void)getLanguageListWithSuccess:(void(^)(NSArray *list))success failure:(void(^)(NSError *error))failure;

/**
 查询手机号是否已注册
 
 @param success success block
 @param failure failure block
 */
- (void)queryPhoneIsRegister:(NSString *)phone            internationalCode:(NSString *)internationalCode success:(void(^)(BOOL isRegister))success failure:(void(^)(NSError *error))failure;

/**
 邮箱密码登录
 
 @param email 邮箱
 @param password 密码
 @param success success block
 @param failure failure block
 */
- (void)loginByEmail:(NSString *)email password:(NSString *)password success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 邮箱密码注册
 
 @param email 邮箱
 @param code 验证码
 @param password 密码
 @param nationality 国家
 @param lang 语言
 @param timezone 时区
 @param success success block
 @param failure failure block
 */
- (void)registerByEmail:(NSString *)email code:(NSString *)code password:(NSString *)password nationality:(NSInteger) nationality lang:(NSInteger)lang timezone:(NSInteger)timezone success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 发送邮箱验证码
 
 @param email 邮箱
 @param type 类型, 1: 注册验证码, 2: 密码重置验证码
 @param success success block
 @param failure failure block
 */
- (void)sendVerifyCodeByEmail:(NSString *)email type:(NSInteger)type success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 手机号密码登录
 
 @param phone 手机号
 @param password 密码
 @param internationalCode 国际代码，默认为国内
 @param success success block
 @param failure failure block
 */
- (void)loginByPhone:(NSString *)phone password:(NSString *)password internationalCode:(NSString *)internationalCode  success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 手机号验证码登录
 
 @param mobile 手机号
 @param code 验证码
 @param internationalCode 国际代码，默认为国内
 @param success success block
 @param failure failure block
 */
- (void)loginWithMobile:(NSString *)mobile code:(NSString *)code internationalCode:(NSString *)internationalCode  success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 手机号密码注册
 
 @param phone 手机号
 @param code 验证码
 @param password 密码
 @param internationalCode 国际代码，默认为国内
 @param nationality 国家
 @param lang 语言
 @param timezone 时区
 @param success success block
 @param failure failure block
 */
- (void)registerByPhone:(NSString *)phone code:(NSString *) code password:(NSString *)password internationalCode:(NSString *)internationalCode nationality:(NSInteger)nationality lang:(NSInteger)lang timezone:(NSInteger)timezone success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 发送手机验证码
 
 @param phone 手机号
 @param internationalCode 国际代码，默认为国内
 @param type 类型, 1: 注册验证码, 2: 密码重置验证码, 3: 登录验证码
 @param ssid 短信签名ID，DMP创建，不传使用系统默认
 @param stid 短信模板ID，DMP创建，不传使用系统默认
 @param success success block
 @param failure failure block
 */
- (void)sendVerifyCodeByPhone:(NSString *)phone
            internationalCode:(NSString *)internationalCode
                         type:(NSInteger)type
                         ssid:(NSString *)ssid
                         stid:(NSString *)stid
            success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 验证国际手机号格式
 
 @param phone 手机号
 @param internationalCode 国际代码，默认为国内
 @param success success block
 @param failure failure block
 */
- (void)validateInternationalPhone:(NSString *)phone internationalCode:(NSString *)internationalCode success:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

/**
 验证短信验证码
 
 @param phone 手机号
 @param smsCode 验证码
 @param internationalCode 国际代码，默认为国内
 @param type 验证码验证后是否失效，1：失效 2：不失效，默认 1
 @param success success block
 @param failure failure block
 */
- (void)validateSmsCode:(NSString *)phone smsCode:(NSString *)smsCode internationalCode:(NSString *)internationalCode type:(NSInteger)type success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改手机号
 
 @param newPhone 新手机号码
 @param newInternationalCode 新手机号码国际代码
 @param newPhoneCode 新手机号码接收到的验证码
 @param oldPhone 原手机号码
 @param oldInternationalCode 原手机号码国际代码
 @param oldPhoneCode 原手机号码接收到的验证码
 @param success success block
 @param failure failure block
 */
- (void)updatePhone:(NSString *)newPhone newInternationalCode:(NSString *)newInternationalCode newPhoneCode:(NSString *)newPhoneCode oldPhone:(NSString *)oldPhone oldInternationalCode:(NSString *)oldInternationalCode oldPhoneCode:(NSString *)oldPhoneCode success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改用户地址
 
 @param address 地址
 @param success success block
 @param failure failure block
 */
- (void)updateUserAddress:(NSString *)address success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改用户头像
 
 @param headImage 头像
 @param success success block
 @param failure failure block
 */
- (void)updateUserHeadIcon:(UIImage *)headImage success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改语言
 
 @param langId 语言Id
 @param success success block
 @param failure failure block
 */
- (void)updateLangWithLangId:(NSInteger)langId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改用户昵称
 
 @param nikeName 昵称
 @param success success block
 @param failure failure block
 */
- (void)updateUserNickName:(NSString *)nikeName success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改用户性别
 
 @param sex 性别 0：男 1：女 2：保密
 @param success success block
 @param failure failure block
 */
- (void)updateUserSex:(NSInteger)sex success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改用户时区
 
 @param timeZoneId 时区
 @param success success block
 @param failure failure block
 */
- (void)updateUserTimeZoneWithTimeZoneId:(NSInteger)timeZoneId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改国家
 
 @param nationalityId 国家
 @param success success block
 @param failure failure block
 */
- (void)updateUserNationLityWithNationalityId:(NSInteger)nationalityId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 修改密码
 
 @param newPassword 新密码
 @param oldPassword 原密码
 @param success success block
 @param failure failure block
 */
- (void)updatePassword:(NSString *)newPassword oldPassword:(NSString *)oldPassword success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 删除用户
 
 @param type 删除类型：1- 立即删除 2- 7天后删除，默认为 7 天后删除
 @param success success block
 @param failure failure block
 */
- (void)deleteUser:(NSInteger)type success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 用户信息读取
 
 @param success success block
 @param failure failure block
 */
- (void)getUserInfoWithSuccess:(void(^)(NSDictionary *data))success failure:(void(^)(NSError *error))failure;

/**
 用户退出登录
 
 @param success success block
 @param failure failure block
 */
- (void)logoutWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 用户通过手机号+验证码重置密码

 @param code 验证码
 @param phone 手机号码
 @param internationalCode 国际代码，配合手机号码使用，默认为国内
 @param password 用户重置的密码，如果不输入默认为 12345678
 @param success success block
 @param failure failure block
 */
- (void)resetPasswordByPhone:(NSString *)phone code:(NSString *)code internationalCode:(NSString *)internationalCode password:(NSString *)password success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 用户通过邮箱+验证码重置密码

 @param code 验证码
 @param email 邮箱
 @param internationalCode 国际代码，配合手机号码使用，默认为国内
 @param password 用户重置的密码，如果不输入默认为 12345678求成功回调
 @param success success block
 @param failure failure block
 */
- (void)resetPasswordByEmail:(NSString *)email code:(NSString *)code internationalCode:(NSString *)internationalCode password:(NSString *)password success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end

