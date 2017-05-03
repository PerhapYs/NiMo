//
//  BookModel.m
//  NiMo
//
//  Created by PerhapYs on 17/4/28.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookModel.h"
#import "BookManager.h"
#import "NSString+PerhapYs.h"
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
    
    if (!self.chapterArray){
//        NSString *chapter_num = self.bookName;
        
//        NSString *path = [NSString getBookPathWithName:chapter_num type:@"txt"];
        NSString *path = self.bookPath;
        
        NSString *bookContent = [NSString getNovelWithBookPath:path];
        
        if (bookContent) {
            NSArray *chapterArray = [BookManager analyseTxtWithContent:bookContent maintainEmptyCharcter:YES];
            self.chapterArray = [NSArray arrayWithArray:chapterArray];
            self.totalChapter = chapterArray.count;
        }
    }
    // 防止取值超范围，（无内容，获取内容失败的情况）
    if (self.chapterArray.count > 0 && chapter < self.chapterArray.count) {
        BookChapter *newBook = (BookChapter *) self.chapterArray[chapter];
        readerChapter.chapterContent = newBook.chapterContent;
        readerChapter.chapterTitle = newBook.chapterTitle;
        readerChapter.allContentRange = newBook.allContentRange;
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
