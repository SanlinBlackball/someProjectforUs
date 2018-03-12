//
//  NSObject+NSObjectAdditions.m
//  chaoKids
//
//  Created by 林志清 on 2018/3/11.
//  Copyright © 2018年 林志清. All rights reserved.
//

#import "NSObject+NSObjectAdditions.h"
#import <objc/runtime.h>

@implementation NSArray (STTtoNSDictionary)

- (NSDictionary*)toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dict setObject:[obj toDictionary] forKey:@(idx)];
    }];
    
    return dict;
}

@end

@implementation NSObject (NSObjectAdditions)
- (NSDictionary *)toDictionary {
    unsigned int count = 0;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        id value = [self valueForKey:key];
        
        if (value) {
            if ([value isKindOfClass:[NSString class]]
                || [value isKindOfClass:[NSNumber class]]
                || [value isKindOfClass:[NSDictionary class]]) {
                [dictionary setObject:value
                               forKey:key];
            }else if ([value isKindOfClass:[NSArray class]]) {
                NSMutableArray *marray = [@[] mutableCopy];
                
                for (id item in value) {
                    [marray addObject:[item toDictionary]];
                }
                
                dictionary[key] = marray;
                
            }else if ([value isKindOfClass:[NSObject class]]) {
                [dictionary setObject:[value toDictionary]
                               forKey:key];
            }else {
                NSLog(@"Invaild type for value:%@ key: %@", NSStringFromClass([value class]), key);
            }
        }
    }
    
    free(properties);
    
    return dictionary;
}
@end
