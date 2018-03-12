//
//  NSStringAdditions.m
//  CarPool
//
//  Created by kiwi on 14-1-6.
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//

#import "NSStringAdditions.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
//#import "GTMBase64.h"

#pragma mark - NSData (kEncode)

@implementation NSData (kEncode)

@end

#pragma mark - NSString (kEncode)

@implementation NSString (kEncode)

+ (NSString *)GUIDString
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return CFBridgingRelease(string);
}
- (BOOL)hasValue {
    return ([self isKindOfClass:[NSString class]] && self.length > 0);
}

//- (NSString *)URLEncodedString
//{
//    return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
//}

//- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
//{
//    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
//                                                                                 (__bridge CFStringRef)[self mutableCopy],
//                                                                                 NULL,
//                                                                                 CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), encoding);
//}

//- (NSString*)URLDecodedString
//{
//    return [self URLDecodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
//}

//- (NSString *)URLDecodedStringWithCFStringEncoding:(CFStringEncoding)encoding
//{
//    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
//                                                                                 (__bridge CFStringRef)self,CFSTR(""),encoding);
//}

- (NSString *)replaceSpace {
    NSString *result = self;
    result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return result;
}

- (NSString *)iPhoneStandardFormat {
    NSString * originStr = [NSString stringWithFormat:@"%@",self];
    NSMutableString * strippedString = [NSMutableString stringWithCapacity:originStr.length];
    NSScanner * scanner = [NSScanner scannerWithString:originStr];
    NSCharacterSet * numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    while ([scanner isAtEnd] == NO) {
        NSString * buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
}

- (NSString*)isPureInt{
    NSString * result = [NSString stringWithFormat:@"%@",self];
    NSScanner* scan = [NSScanner scannerWithString:result];
    int val;
    if (!([scan scanInt:&val] && [scan isAtEnd])) {
        result = @"";
    }
    return result;
}

- (NSString *)trimString {
    // Scanner
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [ NSCharacterSet newlineCharacterSet];
    // Scan
    while (![scanner isAtEnd]) {
        
        // Get non new line or whitespace characters
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        
        // Replace with a space
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@" "];
        }
    }
    
    // Return
    NSString *retString = [NSString stringWithString:result];
    return retString;
}

- (NSString*)trim {
    NSString * result = [NSString stringWithFormat:@"%@",self];
    result = [result stringByReplacingOccurrencesOfString :@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString :@"\r" withString:@""];
    result = [result stringByReplacingOccurrencesOfString :@"\t" withString:@""];
    result = [result stringByReplacingOccurrencesOfString :@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString :@"　" withString:@""];
    return result;
}

- (NSDate*)convertDateFromString:(NSString*)uiDate; {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate * date=[formatter dateFromString:uiDate];
    return date;
}

- (NSString *)findAndReplaceString:(NSString *)string withFindWhat:(NSString *)findWhat withReplaceWith:(NSString *)replaceWith
{
    if(string == nil)
        return nil;
    
    NSRange result = [string rangeOfString:findWhat];
    if(result.location == NSNotFound)
        return string;
    
    int repLen = (int)[replaceWith length];
    NSRange range = {0, [string length]};
    NSMutableString* theString = [[NSMutableString alloc] initWithString:string];
    while (range.length > 0)
    {
        //result = [theString rangeOfString:findWhat];
        result = [theString rangeOfString:findWhat options:0 range:range];
        if(result.location == NSNotFound)
            break;
        
        [theString replaceCharactersInRange:result withString:replaceWith];
        range.location = result.location + repLen;
        range.length = [theString length] - range.location;
    }
    
    return theString;
}

- (NSString *)regularMobilePhoneNumber{
    NSString *tmpStr = [self findAndReplaceString:self withFindWhat:@"-" withReplaceWith:@""];
    tmpStr = [tmpStr findAndReplaceString:tmpStr withFindWhat:@"(" withReplaceWith:@""];
    tmpStr = [tmpStr findAndReplaceString:tmpStr withFindWhat:@")" withReplaceWith:@""];
    tmpStr = [tmpStr findAndReplaceString:tmpStr withFindWhat:@" " withReplaceWith:@""];
    
    NSString* pattern;
    NSRegularExpression* regex;
    NSRange range = NSMakeRange(0, [tmpStr length]);
    NSInteger len = [tmpStr length];
    
    // 手机（仅号码）
    pattern = @"\\b(1\\d{10})\\b";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                      options:NSRegularExpressionCaseInsensitive error:nil];
    if ([regex numberOfMatchesInString:tmpStr options:0 range:range] > 0 && len == 11)
        return tmpStr;
    
    //	// 手机（国家+号码）,e.g.+8613811223344
    //	pattern = @"\\b\\+{0,1}\\d{1,2}(1\\d{10})\\b";
    //	regex = [NSRegularExpression regularExpressionWithPattern:pattern
    //													  options:NSRegularExpressionCaseInsensitive error:nil];
    //	if ([regex numberOfMatchesInString:string options:0 range:range] > 0 && (len >= 10 && len <= 15))
    //		return string;
    
    return nil;
}

- (NSString *)substringFromIndex:(NSUInteger)from toIndex:(NSUInteger)to{
    NSRange range = NSMakeRange(from,to);
    return [self substringWithRange:range];
}
@end


@implementation NSString (STTCountToString)

+ (NSString *)stringWithCount:(NSInteger)count {
    if (count <= 9999) {
        return [NSString stringWithFormat:@"%ld", count];
    }else if (count > 9999 && count <= 99999) {
        return [NSString stringWithFormat:@"%ld万+", (NSInteger)(count/10000)];
    }else if (count > 99999 && count <= 999999) {
        return [NSString stringWithFormat:@"%ld0万+", (NSInteger)(count/100000)];
    }else if (count > 999999 && count <= 9999999) {
        return [NSString stringWithFormat:@"%ld00万+", (NSInteger)(count/1000000)];
    }else if (count > 9999999 && count <= 99999999) {
        return [NSString stringWithFormat:@"%ld000万+", (NSInteger)(count/1000000)];
    }else {
        return NSLocalizedString(@"太多了", @"太多了");
    }
}

@end

@implementation NSString (STTMD5)

- (NSString *)MD5Digest
{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

@end
