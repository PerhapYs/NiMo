//
//  NSString+PerhapYs.h
//  NiMo
//
//  Created by PerhapYs on 17/4/25.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PerhapYs)

+(NSString *)getNovelWithBookPath:(NSString *)path;

-(int)getBookSizeUsingFilePath;


+(NSString *)getBookPathWithName:(NSString *)name type:(NSString *)type;
@end
