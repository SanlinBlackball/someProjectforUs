//
//  Response.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject
@property (nonatomic, assign) NSInteger code; //code    整型    请求结果
@property (nonatomic, copy) NSString *msg;    //msg    字符串    返回详情
@end
