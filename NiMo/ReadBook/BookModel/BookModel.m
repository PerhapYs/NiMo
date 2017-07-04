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

#pragma mark -- save

+ (NSArray *)dbObjectsWithBookId:(NSInteger)bookId
{
    NSString *contion = [NSString stringWithFormat:@"bookId = '%ld'",bookId];
    return [self dbObjectsWhere:contion orderby:nil];
}

+(BOOL)exsitBookWithBookId:(NSInteger)bookId{
    
    NSArray *arr = [self dbObjectsWithBookId:bookId];
    
    if (arr && arr.count > 0) {
        
        return YES;
    }
    
    return NO;
}

+(BookModel *)getBookModelWithBookId:(NSInteger)bookId{
    
    BOOL isExsit = [self exsitBookWithBookId:bookId];
    
    if (isExsit) {
        NSArray *defaultArray = [BookModel dbObjectsWithBookId:bookId];
            
        BookModel *bookSetting = defaultArray[0];
        
        return bookSetting;
    }
    else{
        BookModel *readBook = [[BookModel alloc] init];
        
        NSString *bookContent = [NSString getNovelWithBookPath:[CurrentBook shareCurrentBook].bookPath];
        
        if (bookContent) {
            NSArray *chapterArray = [BookManager analyseTxtWithContent:bookContent maintainEmptyCharcter:YES];
            readBook.chapterArray = [NSArray arrayWithArray:chapterArray];
            readBook.totalChapter = chapterArray.count;
        }
        
        return readBook;
    }
}

@end
