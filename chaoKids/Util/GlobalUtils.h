//
//  GlobalUtils.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface GlobalUtils : NSObject

/**
 *  API地址url
 *
 *  @return urlString
 */
+ (NSString *)appAPIHost;
/*
 * 是否需要加密
 *
 */
+ (BOOL)needEncrypt;
@end
