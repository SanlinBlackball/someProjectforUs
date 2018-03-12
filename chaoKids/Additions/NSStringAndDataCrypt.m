//
//  NSStringAndDataCrypt.m
//  SZBBS
//
//  Created by AngusChen on 15/12/10.
//  Copyright © 2015年 Seentao Technology CO.,LTD. All rights reserved.
//

#import "NSStringAndDataCrypt.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData(STTCryptBlowfishECB)

+ (NSData *)doCipher:(NSData *)dataIn
                  iv:(NSData *)iv
                 key:(NSData *)symmetricKey
             context:(CCOperation)encryptOrDecrypt
               error:(NSError **)error
{
    CCCryptorStatus ccStatus   = kCCSuccess;
    size_t          cryptBytes = 0;    // Number of bytes moved to buffer.
    NSMutableData  *dataOut    = [NSMutableData dataWithLength:dataIn.length+kCCBlockSizeBlowfish];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithmBlowfish,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       symmetricKey.bytes,
                       symmetricKey.length,
                       nil,
                       dataIn.bytes,
                       dataIn.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus == kCCSuccess) {
        dataOut.length = cryptBytes;
    }else {
        if (error) {
            *error = [NSError errorWithDomain:@"kEncryptionError"
                                         code:ccStatus
                                     userInfo:nil];
        }
        dataOut = nil;
    }
    
    return dataOut;
}

- (NSData *)deCryptUsingECBModeWithKey:(NSString *)key {
    NSError *error;
    NSData *decryptData = [NSData doCipher:self
                                        iv:nil
                                       key:[key dataUsingEncoding:NSUTF8StringEncoding]
                                   context:kCCDecrypt
                                     error:&error];
    
    if (decryptData == nil) {
         NSLog(@"Error when decrypt: %@", error);
        return nil;
    }
    
    return decryptData;
}

@end



@implementation NSString (STTCryptBlowfishECB)

- (NSString *)encryptUsingECBModeWithKey:(NSString *)key {
    NSError *error;
    NSData *encryptData = [NSData doCipher:[self dataUsingEncoding:NSUTF8StringEncoding]
                                        iv:nil
                                       key:[key dataUsingEncoding:NSUTF8StringEncoding]
                                   context:kCCEncrypt
                                     error:&error];
    if (encryptData == nil) {
        NSLog(@"Error when encrypt: %@", error);
        return nil;
    }
    
    NSString *encryptString = [encryptData base64EncodedStringWithOptions:0];
    return encryptString;
}
@end