//
//  NetKit.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "NetKit.h"

#import "AFNetworking.h"
#import "AFNetworking/AFNetworking.h"
#import "NSObject+ObjectMap.h"

#import "Request.h"
#import "Response.h"
#import "NSObject+NSObjectAdditions.h"
#import "Constant.h"
#import "GlobalUtils.h"
#import "NSStringAndDataCrypt.h"

#define DBG 1
#define kEnCryptDBG 0

static NSString *const kEncryptBlowFishKey = @"";

@implementation NetKit

+ (NSURLSessionDataTask *)POST:(NSString *)url
                   withRequest:(Request *)entity
               completionBlock:(CompletionBlock)block
                       encrypt:(BOOL)needEncrypt{
    
#if kUseSimulatedData
    
#if DBG
    NSLog(@"request = %@", [entity JSONString]);
#endif
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:entity.body.action
                                                        ofType:@"json"];
    
    if (needEncrypt) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"getInfosEncrypted"
                                                  ofType:@"json"];
    }
    
    NSLog(@"path = %@", srcPath);
    
    if (srcPath == nil) {
        srcPath = [[NSBundle mainBundle] pathForResource:@"default"
                                                  ofType:@"json"];
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:srcPath];
    
    STTResponse *response = [[STTResponse alloc] initWithJSONData:jsonData];
    
    if (response == nil) {
        
        NSString *base64EncryptedString = [[NSString alloc] initWithData:jsonData
                                                                encoding:NSUTF8StringEncoding];
        NSData *encryptedData = [NSData base64DataFromString:base64EncryptedString];
        response = [[STTResponse alloc] initWithJSONData:[encryptedData deCryptUsingECBModeWithKey:kEncryptBlowFishKey]];
    }
#if DBG
    NSLog(@"response = %@", [response toDictionary]);
#endif
    
    if (block) {
        block(response, nil);
    }
    return nil;
#else
    
    NSDictionary *param = [entity toDictionary];
    
    if (needEncrypt) {
        
        NSString *body = [entity.body JSONString];
#if kEnCryptDBG
        NSLog(@"request = %@", body);
#endif
        body = [body encryptUsingECBModeWithKey:kEncryptBlowFishKey];
        param = @{@"header":[entity.header toDictionary], @"body":body};
    }
    
    return [NetKit POST:url
                     param:param
           completionBlock:^(id responseObject, NSError *error) {
               Response *responseEntity;
               NSAssert(block != nil, @"completionBlock must not be nil!");
               
               if (error) {
                   responseEntity = [Response new];
                   responseEntity.code = error.code;
                   
                   if (error.code == NSURLErrorNotConnectedToInternet) {
                       responseEntity.msg = error.localizedDescription;
                   }else {
                       responseEntity.msg = NSLocalizedString(@"网络开小差啦~", nil);
                   }
                   
               }else {
                   //首先解析返回文本并转成对应实体
                   responseEntity = [[Response alloc] initWithJSONData:responseObject];
                   
                   //如果实体为空，尝试解密
                   if (responseEntity == nil) {
                       
                       NSString *base64EncryptedString = [[NSString alloc] initWithData:responseObject
                                                                               encoding:NSUTF8StringEncoding];
                       NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:base64EncryptedString
                                                                                   options:0];
                       responseEntity = [[Response alloc] initWithJSONData:[encryptedData deCryptUsingECBModeWithKey:kEncryptBlowFishKey]];
#if kEnCryptDBG
                       NSLog(@"responseString = %@", [[NSString alloc] initWithData:[encryptedData deCryptUsingECBModeWithKey:kEncryptBlowFishKey]
                                                                           encoding:NSUTF8StringEncoding]);
#endif
                   }
                   
                   //如果解密失败，则构建一个错误的response实体
                   if (responseEntity == nil) {
                       responseEntity = [Response new];
                       responseEntity.code = NSURLErrorUnknown;
                       responseEntity.msg = NSLocalizedString(@"网络开小差啦~", nil);
                   }
                   
//                   if (responseEntity.code == STTResponseCodeUserTokenOutofDate) {
//                       [[NSNotificationCenter defaultCenter] postNotificationName:STTNotificationUserTokenOutOfDate
//                                                                           object:responseEntity];
//                   }
               }
               
               block(responseEntity, error);
           }];
#endif
    
}

+ (NSURLSessionUploadTask *)uploadTo:(NSString *)url withRequest:(Request *)entity progress:(NSProgress**)progress completionBlock:(CompletionBlock)block {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[entity JSONData]];
    
    return [NetKit uploadTo:url
                          data:[entity JSONData]
                      progress:progress
               completionBlock:^(NSURLResponse *response, id responseObject, NSError *error) {
                   Response *responseEntity = [[Response alloc] initWithJSONData:responseObject];
                   NSAssert(block != nil, @"completionBlock must not be nil!");
                   block(responseEntity, error);
               }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)url param:(id)param completionBlock:(void (^)(id responseObject, NSError *error))block {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSURLSessionDataTask *dataTask = [manager POST:url
                                        parameters:param
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                               
                                               NSString *responseString = [[NSString alloc] initWithData:responseObject
                                                                                                encoding:NSUTF8StringEncoding];
#if DBG
                                               NSLog(@"request = %@ responseString = %@", param, responseString);
#endif
                                               NSError *error = nil;
                                               //处理错误类型：请求了不存在的接口，生成一个NSError
                                               if ([responseString containsString:@"动作不存在"]) {
                                                   responseObject = nil;
                                                   error = [NSError errorWithDomain:responseString
                                                                               code:-10000
                                                                           userInfo:nil];
                                               }
                                               
                                               if (block) {
                                                   block(responseObject, error);
                                               }
                                           }
                                           failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
#if DBG
                                               NSLog(@"request = %@ error = %@", param, error);
#endif
                                               if (block) {
                                                   block(nil, error);
                                               }
                                           }];
    [dataTask resume];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)POST:(NSString *)url data:(NSData *)data completionBlock:(void (^)(id responseObject, NSError *error))block {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
#if DBG
        NSString *responseString = [[NSString alloc] initWithData:responseObject
                                                         encoding:NSUTF8StringEncoding];
        NSLog(@"request = %@ responseString = %@", [[NSString alloc] initWithData:data
                                                                         encoding:NSUTF8StringEncoding], responseString);
#endif
        if (block) {
            block(responseObject, error);
        }
    }];
    [dataTask resume];
    
    return dataTask;
}

+ (NSURLSessionUploadTask *)uploadTo:(NSString *)url data:(NSData *)data progress:(NSProgress * __autoreleasing *)progress completionBlock:(void (^)(NSURLResponse *response, id responseObject, NSError *error))block {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request
                                                               fromData:data
                                                               progress:progress
                                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error) {
                                                          
                                                          if (block) {
                                                              block(response, responseObject, error);
                                                          }
                                                      }];
    return uploadTask;
}
@end
