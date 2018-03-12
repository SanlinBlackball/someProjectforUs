//
//  NSStringAndDataCrypt.h
//  SZBBS
//
//  Created by AngusChen on 15/12/10.
//  Copyright © 2015年 Seentao Technology CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(STTCryptBlowfishECB)
/**
 *  使用Blowfish算法ECB模式PKCS7Padding填充方式解密
 *
 *  @param key 密钥
 *
 *  @return 解密后的明文
 */
- (NSData *)deCryptUsingECBModeWithKey:(NSString *)key;
@end


@interface NSString(STTCryptBlowfishECB)
/**
 *  使用Blowfish算法ECB模式PKCS7Padding填充方式加密
 *
 *  @param key 密钥
 *
 *  @return 加密后的密文
 */
- (NSString *)encryptUsingECBModeWithKey:(NSString *)key;
@end