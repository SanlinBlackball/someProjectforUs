//
//  NSStringAdditions.h
//  CarPool
//
//  Created by kiwi on 14-1-6.
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Emoji.h"
#import "NSString+Empty.h"
//Functions for Encoding Data.
@interface NSData (kEncode)

@end

//Functions for Encoding String.
@interface NSString (kEncode)
@property (readonly) BOOL hasValue;

+ (NSString *)GUIDString;
//- (NSString *)URLEncodedString;
//- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding;
//- (NSString*)URLDecodedString;
//- (NSString *)URLDecodedStringWithCFStringEncoding:(CFStringEncoding)encoding;

- (NSString *)replaceSpace;
- (NSString *)iPhoneStandardFormat;
- (NSString*)isPureInt;
- (NSString *)trimString;
- (NSString*)trim;
- (NSDate*)convertDateFromString:(NSString*)uiDate;

- (NSString *)findAndReplaceString:(NSString *)string withFindWhat:(NSString *)findWhat withReplaceWith:(NSString *)replaceWith;
- (NSString *)regularMobilePhoneNumber;
- (NSString *)substringFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;
@end


@interface NSString (STTCountToString)
+ (NSString *)stringWithCount:(NSInteger)count;
@end

@interface NSString (STTMD5)

- (NSString *)MD5Digest;

@end
