//
//  EncryptUtil.h
//  QuecCommonKit
//
//  Created by quectel.steven on 2022/2/14.
//

#import <Foundation/Foundation.h>

@interface QuecEncryptUtil : NSObject

/**
 aes128随机加密
 
 @param content 加密内容
 @return return encrypted content @{@"random":@"", @"encrypted": @""}
 */
+ (NSDictionary *)aes128RandomEncryptWithContent:(NSString *)content;

/**
 aes128随机加密（指定随机字符串）
 
 @param content 加密内容
 @param random 随机字符串
 @return return encrypted content}
 */
+ (NSString *)aes128RandomEncryptWithContent:(NSString *)content random:(NSString *)random;

/**
 sha256加密
 
 @param content 加密内容
 @return return encrypted content
 */
+ (NSString *)sha256Encrypt:(NSString *)content;

/**
 获取16位大小写字母和数字随机字符串
 
 @return return random
 */
+ (NSString *)getRandom16LetterAndNumber;

@end

