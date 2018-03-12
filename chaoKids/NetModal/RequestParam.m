//
//  RequestParam.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "RequestParam.h"
#import "Body.h"
#import "Request.h"
#import "User.h"
@implementation RequestParam


+ (Request *)instanceRequestWithParam:(RequestParam *)requestParam
                                  action:(NSString *)action{
    Body *body = [[Body alloc] init];
    body.action = action;
    body.requestParam = requestParam;
    
    Request *request = [[Request alloc] init];
    request.body = body;
    
    return request;
}

+ (void)setParamWithUserInfo:(RequestParam *)requestParam{
    if ([[User sharedManager] isLogin]) {
        requestParam.userId = [User sharedManager].userId;
        requestParam.userName = [User sharedManager].userName;
        requestParam.userToken = [User sharedManager].userToken;
        requestParam.userType = @([User sharedManager].userType);
    }
}

+ (instancetype)requestParamOfCurrentUser {
    RequestParam *param = [RequestParam new];
    [RequestParam setParamWithUserInfo:param];
    return param;
}
@end
