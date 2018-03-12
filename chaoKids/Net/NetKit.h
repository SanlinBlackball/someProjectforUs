//
//  NetKit.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Response;
@class Request;

typedef void(^CompletionBlock)(Response *response, NSError *error);

@interface NetKit : NSObject
/**
 *  发起一个POST请求
 *
 *  @param url    请求地址
 *  @param entity STTRequest实体
 *  @param block  请求返回时调用的block
 *  @param needEncrypt  是否需要加密
 *
 *  @return 一个数据传输任务实体
 */
+ (NSURLSessionDataTask *)POST:(NSString *)url
                   withRequest:(Request *)entity
               completionBlock:(CompletionBlock)block
                       encrypt:(BOOL)needEncrypt;
/**
 *  上传任务
 *
 *  @param url      上传地址
 *  @param entity   STTRequest实体
 *  @param progress NSProgress进度实体
 *  @param block    上传完成后调用的block
 *
 *  @return NSURLSessionUploadTask实体
 */
+ (NSURLSessionUploadTask *)uploadTo:(NSString *)url withRequest:(Request *)entity progress:(NSProgress**)progress completionBlock:(CompletionBlock)block;
@end
