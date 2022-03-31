//
//  NSString+QuecSDKCategory.h
//  IoT
//
//  Created by Tsing on 2018/3/29.
//  Copyright © 2018年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QuecSDKCategory)
/**
 *  是否是数字
 */
- (BOOL)isNumber;

/**
 是否标准的移动号码
 */
- (BOOL)isPhone;

/**
 是否是数字或者字母
 */
- (BOOL)isNumberOrLetter;

- (BOOL)isChineseEnglishNumber;

/**
 中文+英文+数字
 */
- (BOOL)isChineseOrEnglishOrNumber;

/**
 去空
 */
+ (NSString *)deletEmpty:(NSString *)string;

/**
 AES加密，对应java (AES/ECB/PKCS5Padding)
 */
- (NSData *)aesEncryptWithKey:(NSString *)key;

/**
 格式化手机号 344
 */
- (NSString *)getFormatPhone;


@end
