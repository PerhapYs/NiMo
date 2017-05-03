//
//  NSString+PerhapYs.m
//  NiMo
//
//  Created by PerhapYs on 17/4/25.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "NSString+PerhapYs.h"

@implementation NSString (PerhapYs)

+(NSString *)getNovelWithBookPath:(NSString *)path{

    NSError *error = nil;
    
//    ANSI编码
    NSString *ansiStr = [[NSString alloc] initWithContentsOfFile:path encoding:-2147482062 error:&error];
    if (error) {
        NSLog(@"ASCALL open book chapter error:%@",error);
    }
    else {
        return ansiStr;
    }
    
//    UNICODE编码
    NSError *errorAscall = nil;
    NSString *unicodeStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&errorAscall];
    if (errorAscall) {
        NSLog(@"UTF8 open book chapter error :%@",errorAscall);
    }
    else{
        return unicodeStr;
    }
    return nil;
}
+(NSString *)getBookPathWithName:(NSString *)name type:(NSString *)type{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    return filePath;
}

//防止越界
- (NSString *)yj_substringWithRange:(NSRange)range{
    
    if (self.length >= range.location + range.length) {
        return [self substringWithRange:range];
    }
    return @"";
}

- (NSString *)trimmed{
    NSCharacterSet* whiteSpaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:whiteSpaceSet];
}
@end
