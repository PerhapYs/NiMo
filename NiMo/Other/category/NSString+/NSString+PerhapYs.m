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
    if (!error) {

        return ansiStr;
    }

//    UNICODE编码
    NSString *unicodeStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        
        return unicodeStr;
    }
    
    return @"文本格式错误";
}
+(NSString *)getBookPathWithName:(NSString *)name type:(NSString *)type{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    return filePath;
}
-(int)getBookSizeUsingFilePath{
    
    if (!self) {
        return 1;
    }

    long long size = 0;
    NSFileManager *manage = [NSFileManager defaultManager];
    NSDictionary *attriDict = [manage attributesOfItemAtPath:self error:nil];
    size =  [attriDict[NSFileSize] longLongValue];

    float bookSize = size / 1048576;
    
    return bookSize;
}
@end
