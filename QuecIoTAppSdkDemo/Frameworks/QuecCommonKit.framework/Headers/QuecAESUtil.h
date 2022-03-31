//
//  AESEncryptUtil.h
//  QuecCommonKit
//
//  Created by quectel.steven on 2022/2/14.
//

#import <Foundation/Foundation.h>
@interface QuecAESUtil : NSObject

/**
 aes128加密
 
 @param content 加密内容
 @param key 秘钥
 @param iv 向量
 @return return encrypted base64 content
 */
+ (NSString *)aes128encryptWithContent:(NSString *)content key:(NSString *)key iv:(NSString *)iv;

@end


