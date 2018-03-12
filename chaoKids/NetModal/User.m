//
//  User.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "User.h"
#import <objc/runtime.h>
#import "NSString+Empty.h"
NSString *const STTCurrentUserKey = @"STTCurrentUser";
@implementation User
+(instancetype)sharedManager{
    static dispatch_once_t once;
    static id instance;
    
    dispatch_once(&once, ^{
        instance = [User currentUser];
        
        if (instance == nil) {
            instance = [User new];
        }
    });
    return instance;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
        
        for (int i = 0; i < propertyCount; i++) {
            objc_property_t *thisProperty = propertyList + i;
            const char *propertyName = property_getName(*thisProperty);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            
            id value = [aDecoder decodeObjectForKey:key];
            
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t *thisProperty = propertyList + i;
        const char *propertyName = property_getName(*thisProperty);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}
/**
 *  用户信息保存到本地磁盘
 */
- (void)saveUserInfoToDisk {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSAssert(data != nil, @"data must not be nil");
    [defaults setObject:data forKey:STTCurrentUserKey];
    [defaults synchronize];
}
+ (void)deleteUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:STTCurrentUserKey];
    [defaults synchronize];
    [[User sharedManager] clear];
}
/**
 *  清空User单例对象
 */
- (void)clear {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        char *typeEncoding = property_copyAttributeValue(properties[i], "T");
        
        if (typeEncoding[0] != '@') {
            [[User sharedManager] setValue:@-1
                                       forKey:key];
        }else {
            [[User sharedManager] setValue:nil
                                       forKey:key];
        }
        
    }
    
    free(properties);
}
+ (instancetype)currentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData* data = [defaults objectForKey:STTCurrentUserKey];
    
    if (data) {
        User *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return user;
    }
    
    return nil;
}
- (void)setUserId:(NSString *)userId {
    _userId = [NSString stringWithFormat:@"%@", userId];
}

- (BOOL)isLogin{
    
    if (self.userId != nil
        && [self.userId isEmpty] == NO
        && self.userToken != nil
        && [self.userToken isEmpty] == NO) {
        return YES;
    }else {
        return NO;
    }
}
/**
 *  保存self到STTUser的单例对象中
 */
- (void)saveToCurrentUser {
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:key];
        char *typeEncoding = property_copyAttributeValue(properties[i], "T");
        
        if (typeEncoding[0] == '@'
            && value == nil) {
            continue;
        }else if (typeEncoding[0] != '@'
                  && value == 0
                  && ![key isEqualToString:@"sex"]) {
            continue;
        }else if (typeEncoding[0] != '@'
                  && [value integerValue] == -1) {
            continue;
        }else {
            [[User sharedManager] setValue:[self valueForKey:key]
                                       forKey:key];
        }
    }
    
    free(properties);
    [[User sharedManager] saveUserInfoToDisk];
}


- (NSURLRequest *)requestWithUserTokenByURLString:(NSString *)urlString {
    NSString *queryString = [NSString stringWithFormat:@"&user_token=%@", [User sharedManager].userToken];
    NSString *urlWithQueryString = [urlString stringByAppendingString: queryString];
    NSURL *finalURL = [NSURL URLWithString:urlWithQueryString];
    NSURLRequest *request = [NSURLRequest requestWithURL:finalURL];
    return request;
}
@end
