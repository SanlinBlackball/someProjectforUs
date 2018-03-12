//
//  Request.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "Request.h"
#import "GlobalUtils.h"

@implementation Request
- (id)init {
    self = [super init];
    
    if (self) {
        self.header = [Header sharedInstance];
        self.body = [Body new];
    }
    
    return self;
}

+ (instancetype)requestWithAction:(NSString *)action
                         andParam:(RequestParam *)param {
    Request *request = [Request new];
    request.body.action = action;
    request.body.requestParam = param;
    return request;
}
/**
 *  开始根据request来进行请求
 *
 *  @param completeBlock 请求执行完成后调用的block
 */
- (void)startRequestWithCompleteBlock:(CompletionBlock)completeBlock {
    return [self startRequestAddUserInfo:YES
                       WithCompleteBlock:completeBlock];
}

/**
 *  开始根据request来进行请求
 *
 *  @param addUserInfo  是否需要当前用户信息
 *  @param completeBlock 请求执行完成后调用的block
 */
- (void)startRequestAddUserInfo:(BOOL)addUserInfo
              WithCompleteBlock:(CompletionBlock)completeBlock {
    if (addUserInfo) {
        [RequestParam setParamWithUserInfo:self.body.requestParam];
    }
    
    NSString *url = [GlobalUtils appAPIHost];
    
    [NetKit POST:url
        withRequest:self
    completionBlock:^(Response *response, NSError *error) {
        
        if (completeBlock) {
            completeBlock(response, error);
        }
    }
            encrypt:[GlobalUtils needEncrypt]];
}

/**
 *  开始根据request来进行分页请求
 *
 *  @param start         查询起始值
 *  @param limit         期望查询的条数
 *  @param completeBlock 请求执行完之后调用的block
 */
- (void)startRequestStartAtIndex:(NSUInteger)start
                         ofLimit:(NSUInteger)limit
                   completeBlock:(CompletionBlock)completeBlock {
    return [self startRequestStartAtIndex:start
                                  ofLimit:limit
                              addUserInfo:YES
                            completeBlock:completeBlock];
}

/**
 *  开始根据request进行分页请求
 *
 *  @param start         查询起始值
 *  @param limit         期望查询的条数
 *  @param addUserInfo   是否需要添加当前用户信息
 *  @param completeBlock 请求执行完之后调用的block
 */
- (void)startRequestStartAtIndex:(NSUInteger)start
                         ofLimit:(NSUInteger)limit
                     addUserInfo:(BOOL)addUserInfo
                   completeBlock:(CompletionBlock)completeBlock {
    
    if (addUserInfo) {
        [RequestParam setParamWithUserInfo:self.body.requestParam];
    }
    
    self.body.requestParam.start = @(start);
    self.body.requestParam.limit = @(limit);
    
    NSString *url = [GlobalUtils appAPIHost];
    
    [NetKit POST:url
        withRequest:self
    completionBlock:^(Response *response, NSError *error) {
        
        if (completeBlock) {
            completeBlock(response, error);
        }
    }
            encrypt:[GlobalUtils needEncrypt]];
}

@end
