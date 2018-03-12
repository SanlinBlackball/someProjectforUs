//
//  RequestParam.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Request;
@interface RequestParam : NSObject

@property (nonatomic, copy) NSString *userName;     //userName    可选    字符串    用户名
@property (nonatomic, copy) NSString *userId;   //userId    可选    字符串    用户id
@property (nonatomic, strong) NSNumber *userType;  //userType    可选    整型    用户类型    1：大平台用户；2：微信用户；3：QQ用户；4：sina微博用户
@property (nonatomic, copy) NSString *userToken;    //userToken    可选    字符串    用户唯一标识
/**
 *  查询起始值
 */
@property(nonatomic, strong) NSNumber *start;
/**
 *  期望查询条数
 */
@property(nonatomic, strong) NSNumber *limit;
/**
 *  根据请求参数requestParam和请求方法名action创建一个STTRequest实体
 *
 *  @param requestParam 请求参数
 *  @param action       请求方法名
 *
 *  @return STTRequest实体
 */
+ (Request *)instanceRequestWithParam:(RequestParam *)requestParam
                                  action:(NSString *)action;
/**
 *  判断用户是否登录，登录后向requestParam中写入当前登录用户的userId,userType,userName,userToken
 *
 *  @param requestParam 请求参数实体
 */
+ (void)setParamWithUserInfo:(RequestParam *)requestParam;
/**
 *  获得一个包含当前用户信息的STTRequestParam实体
 *
 *  @return STTRequestParam实体
 */
+ (instancetype)requestParamOfCurrentUser;
@end
