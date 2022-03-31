//
//  QuecShareUserInfoModel.h
//  QuecDeviceKit
//
//  Created by quectel.steven on 2021/10/29.
//

#import <Foundation/Foundation.h>

@interface QuecShareUserInfoModel : NSObject

// 地址
@property (nonatomic, copy) NSString *address;
// 邮箱
@property (nonatomic, copy) NSString *email;
// 头像
@property (nonatomic, copy) NSString *headimg;
// 最后登录时间
@property (nonatomic, copy) NSString *lastLoginTime;
// 昵称
@property (nonatomic, copy) NSString *nikeName;
// 手机号码
@property (nonatomic, copy) NSString *phone;
// 授权时间
@property (nonatomic, copy) NSString *registerTime;
// 性别
@property (nonatomic, copy) NSString *sex;
// 用户ID
@property (nonatomic, copy) NSString *uid;
// 用户域
@property (nonatomic, copy) NSString *userDomain;
// 用户来源
@property (nonatomic, assign) NSInteger userType;
// 微信ID
@property (nonatomic, copy) NSString *wchartId;
// 微信名称
@property (nonatomic, copy) NSString *wchartName;

@end

