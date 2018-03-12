//
//  Header.h
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Header : NSObject
/**
 *  设备唯一id，UIDevice类的identifierForVendor获得
 */
@property (nonatomic, copy) NSString *deviceId;
/**
 *  设备型号，例如iPhone,iPad等
 */
@property (nonatomic, copy) NSString *clientType;
/**
 *  客户端版本号，同BundleVersion
 */
@property (nonatomic, copy) NSString *clientVersion;
/**
 *  由App生成的一个id
 */
@property (nonatomic, copy) NSString *clientId;
/**
 *  请求来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  Header的一个单例
 *
 *  @return Header单例实体
 */
+ (instancetype)sharedInstance;
@end
