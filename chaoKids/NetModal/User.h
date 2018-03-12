//
//  User.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString *userName;       //userName    字符串    用户名
@property (nonatomic, copy) NSString *userId;       //userId    字符串    用户id
@property (nonatomic, assign) NSInteger userType;       //userType    整型    用户类型
@property (nonatomic, copy) NSString *userToken;       //userToken    字符串    用户唯一标识
/**
 *  当前登录用户的单例
 *
 *  @return 返回当前登录用户的单例
 */
+ (instancetype)sharedManager;
//是否已登录
- (BOOL)isLogin;
/**
 *  删除用户信息
 */
+ (void)deleteUserInfo;

//登录成功之后调用
- (void)saveToCurrentUser;

- (NSURLRequest *)requestWithUserTokenByURLString:(NSString *)urlString;

@end
