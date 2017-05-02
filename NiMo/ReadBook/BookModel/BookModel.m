//
//  BookModel.m
//  NiMo
//
//  Created by PerhapYs on 17/4/28.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel


- (BOOL)havePreChapter
{
    return _curChpaterIndex > 1;
}
- (BOOL)haveNextChapter
{
    return _totalChapter > _curChpaterIndex;
}

- (void)resetChapter:(BookChapter *)chapter
{
    _curChpaterIndex = chapter.chapterIndex;
}

- (BookChapter *)openBookWithChapter:(NSInteger)chapter
{
    BookChapter *readerChapter = [[BookChapter alloc]init];
    readerChapter.chapterIndex = chapter;
    _curChpaterIndex = chapter;
    NSError *error = nil;
    NSString *chapter_num = [NSString stringWithFormat:@"Chapter%d",(int)chapter];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:chapter_num ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"UTF8 open book chapter error:%@",error);
    }
    else{
        readerChapter.chapterContent = content;
        return readerChapter;
    }
    
    NSError *errorAscall = nil;
    NSString *contentAscall = [NSString stringWithContentsOfFile:path1 encoding:-2147482062 error:&errorAscall];
    if (errorAscall) {
        NSLog(@"ASCALL open book chapter error:%@",error);
    }
    else{
        readerChapter.chapterContent = contentAscall;
        return readerChapter;
    }
    
    return readerChapter;
}

- (BookChapter *)openBookNextChapter
{
    return [self openBookWithChapter:_curChpaterIndex+1];
}

- (BookChapter *)openBookPreChapter
{
    return [self openBookWithChapter:_curChpaterIndex-1];
}
@end
