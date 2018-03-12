//
//  Header.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "Header.h"
#import <UIKit/UIKit.h>
@implementation Header

-(id)init {
    self = [super init];
    if (self) {
        self.deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

        self.clientType = @"iPhone";
        //获取软件的版本号
        NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
        self.clientVersion = version;
        self.clientId = @"";
    }
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
@end
