//
//  ORSecurityUtil.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "SecurityUtil.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "Base64.h"
@implementation SecurityUtil
+ (NSString *)aesEncryptUrs:(NSString *)aString key:(NSString *)aKey
{
    NSData *data = [aString dataUsingEncoding:NSUTF8StringEncoding];
    
    CocoaSecurityDecoder *decoder = [CocoaSecurityDecoder new];
    NSData *aesKey = [decoder hex:aKey];
    
    CocoaSecurityResult *result = [self aesEncryptWithData:data key:aesKey];
    
    return result.hexLower;
}

+ (NSString *)aesDecryptUrs:(NSString *)aString key:(NSString *)aKey
{
    CocoaSecurityDecoder *decoder = [CocoaSecurityDecoder new];
    NSData *data = [decoder hex:aString];
    NSData *aesKey = [decoder hex:aKey];
    
    CocoaSecurityResult *result = [self aesDecryptWithData:data key:aesKey];
    return result.utf8String;
}


+ (CocoaSecurityResult *)aesEncryptWithData:(NSData *)data key:(NSData *)key
{
    // check length of key
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)"
                                     userInfo:nil];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key bytes],     // Key
                                          [key length],    // kCCKeySizeAES
                                          NULL,       // IV
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        
        return result;
    }
    else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Encrypt Error!"
                                     userInfo:nil];
        return nil;
    }
}

+ (CocoaSecurityResult *)aesDecryptWithData:(NSData *)data key:(NSData *)key
{
    // check length of key
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)"
                                     userInfo:nil];
    }
    
    // setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key bytes],     // Key
                                          [key length],    // kCCKeySizeAES
                                          NULL,       // IV
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        CocoaSecurityResult *result = [[CocoaSecurityResult alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        
        return result;
    }
    else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Cocoa Security"
                                       reason:@"Decrypt Error!"
                                     userInfo:nil];
        return nil;
    }
}
@end
