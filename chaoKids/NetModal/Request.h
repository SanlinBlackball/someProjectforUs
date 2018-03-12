//
//  Request.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Body.h"
#import "Header.h"
#import "NetKit.h"
#import "RequestParam.h"
@interface Request : NSObject
@property (nonatomic, strong) Header *header;
@property (nonatomic, strong) Body *body;
/**
 *  根据action和param生成一个request实体，方便的实例化方法
 *
 *  @param action 请求action
 *  @param param  请求参数
 *
 *  @return request实体
 */
+ (instancetype)requestWithAction:(NSString *)action
                         andParam:(RequestParam *)param;
/**
 *  开始根据request来进行请求
 *
 *  @param completeBlock 请求执行完成后调用的block
 */
- (void)startRequestWithCompleteBlock:(CompletionBlock)completeBlock;

/**
 *  开始根据request来进行请求
 *
 *  @param addUserInfo  是否需要当前用户信息
 *  @param completeBlock 请求执行完成后调用的block
 */
- (void)startRequestAddUserInfo:(BOOL)addUserInfo
              WithCompleteBlock:(CompletionBlock)completeBlock;

/**
 *  开始根据request来进行分页请求
 *
 *  @param start         查询起始值
 *  @param limit         期望查询的条数
 *  @param completeBlock 请求执行完之后调用的block
 */
- (void)startRequestStartAtIndex:(NSUInteger)start
                         ofLimit:(NSUInteger)limit
                   completeBlock:(CompletionBlock)completeBlock;

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
                   completeBlock:(CompletionBlock)completeBlock;
@end
