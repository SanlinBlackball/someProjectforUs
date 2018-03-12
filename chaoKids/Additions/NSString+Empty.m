//
//  NSString+Empty.m
//  SZBBS
//
//  Created by AngusChen on 15/10/26.
//  Copyright © 2015年 Seentao Technology CO.,LTD. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString(Empty)

- (BOOL)isEmpty {
    if (self==nil) {
        return YES;
    }
    if (self==NULL) {
        return YES;
    }
       
    if ([self isEqualToString:@""]) {
        return YES;
    }
    
    if ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return YES;
    }
    if([self length] == 0) { //string isempty or nil
        return YES;
    }
        return NO;
}
@end