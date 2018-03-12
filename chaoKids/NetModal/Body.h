//
//  Body.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

/*
 本文件是接口使用的方法名
 */
#import <Foundation/Foundation.h>
@class RequestParam;
/**
 *  调用接口使用的方法名
 */
FOUNDATION_EXPORT NSString *const STTActionGetInfos;
@interface Body : NSObject
/**
 *  接口方法名(Method name)
 */
@property (nonatomic, copy) NSString *action;
/**
 *  请求参数实体
 */
@property (nonatomic, strong) RequestParam *requestParam;
@end
