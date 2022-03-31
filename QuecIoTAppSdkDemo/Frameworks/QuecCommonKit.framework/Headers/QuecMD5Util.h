//
//  QuecMD5Util.h
//  QuecCommonKit
//
//  Created by quectel.steven on 2022/2/14.
//

#import <Foundation/Foundation.h>

@interface QuecMD5Util : NSObject

/**
 md5加密
 
 @param content 加密内容
 @return return encrypted content
 */
+ (NSString *)md5Encrypt:(NSString *)content;

@end


