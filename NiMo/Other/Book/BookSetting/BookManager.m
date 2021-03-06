//
//  BookManager.m
//  NiMo
//
//  Created by PerhapYs on 17/4/26.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookManager.h"
#import "BookChapter.h"
#import "NSString+PerhapYs.h"
#import "BookMark.h"

#define FONT_SIZE_KEY @"FONT_SIZE"

#define FONT_SIZE 16

#define MARK_TEXT_LENGTH 120

@implementation BookManager
+ (instancetype)shareBook{
    static dispatch_once_t onceToken;
    static id shareId = nil;
    @synchronized(self) {
        dispatch_once(&onceToken, ^{
            shareId = [[[self class] alloc] init];
        });
        return shareId;
    }
}


+(NSInteger)BookTransitionStyle{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *bookStyel =  [userDefault objectForKey:@"bookTransitionStyle"];
    if (!bookStyel) {
        return 0;
    }
    return [bookStyel integerValue];
}

+ (NSUInteger)fontSize
{
    NSUInteger fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:FONT_SIZE_KEY];
    if (fontSize == 0) {
        fontSize = FONT_SIZE;
    }
    return fontSize;
}

/**
 提取章节的NSRange信息
 
 @param content 文本内容
 @return `range字符串`数组
 */
+ (NSArray<NSTextCheckingResult *> *)extractChapterListWithContent:(NSString *)content{
    
    NSString* regPattern = @"(\\s)+[第]{0,1}[0-9一二三四五六七八九十百千万]+[章回节卷集幕计][ \t]*(\\S)*";
    NSError* error = NULL;
    NSRegularExpression* regExp = [NSRegularExpression regularExpressionWithPattern:regPattern
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    
    return [regExp matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, content.length)];
}

/**
 根据 title Range 提取章节所需信息
 
 @param content 字符串内容
 @param maintainEmptyCharcter 是否保留空章节
 @return ChapterModel数组
 */
+ (NSArray<BookChapter *> *)analyseTxtWithContent:(NSString *)content
                             maintainEmptyCharcter:(BOOL)maintainEmptyCharcter{
    
    NSArray<NSTextCheckingResult *> *matchResult = [self extractChapterListWithContent:content];
    NSMutableArray *chapterModels = @[].mutableCopy ;
    
    if (matchResult.count == 0) {
        BookChapter *model = [BookChapter new] ;
        model.chapterTitle = @"内容";
        model.contentRange = NSMakeRange(0, content.length);
        model.allContentRange = NSMakeRange(0, content.length);
        model.chapterContent = [content substringWithRange:model.allContentRange];
        return @[model];
    }
    
    for (NSInteger i = 0; i < matchResult.count ; i++) {
        
        NSRange titleRange = matchResult[i].range;
        NSString *chapterTitle = [[content yj_substringWithRange:titleRange] trimmed];

        if (i == 0) { //第0章前
            
            NSString *firstTitle = @"开始";
            NSString *contentString = [content yj_substringWithRange:NSMakeRange(0, titleRange.location)];
            if (contentString.trimmed.length > 0 ) {
            
                BookChapter *model2 = [BookChapter new];
                model2.chapterTitle = firstTitle;
                model2.contentRange = NSMakeRange(0, 0);
                model2.allContentRange = NSMakeRange(0, titleRange.location);
                model2.chapterContent = [content substringWithRange:model2.allContentRange];
                [chapterModels addObject:model2];
            }
        }
        
        if (i < matchResult.count-1) {
            
            NSRange nextRange = matchResult[i+1].range;
            if (nextRange.location > titleRange.location) {
                
                NSInteger length = nextRange.location - titleRange.location ;
                
                BookChapter *model2 = [BookChapter new];
                model2.chapterTitle = chapterTitle;
                model2.contentRange = titleRange;
                model2.allContentRange = NSMakeRange(titleRange.location, length);
                model2.chapterContent = [content substringWithRange:model2.allContentRange];
                [self chapterModels:chapterModels addModel:model2 content:content maintainEmpty:maintainEmptyCharcter];
            }
        }
        
        if (i == matchResult.count-1){ //最后章节

            BookChapter *model2 = [BookChapter new];
            model2.chapterTitle = chapterTitle;
            model2.contentRange = titleRange;
            model2.allContentRange = NSMakeRange(titleRange.location,content.length -  titleRange.location);
            model2.chapterContent = [content substringWithRange:model2.allContentRange];
            [self chapterModels:chapterModels addModel:model2 content:content maintainEmpty:maintainEmptyCharcter];
        }
    }
    return [chapterModels copy];
}

+ (void)chapterModels:(NSMutableArray *)chapterModels
             addModel:(BookChapter *)model
              content:(NSString *)content
        maintainEmpty:(BOOL)maintainEmptyCharcter{
    NSInteger contentLength = [[content yj_substringWithRange:model.contentRange] trimmed].length;
    //保留空章节 或者 章节有内容
    if (maintainEmptyCharcter == YES || contentLength > 0) {
        [chapterModels addObject:model];
    }
}

+ (void)saveBookMarkWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage
{
    BookMark *mark = [[BookMark alloc]init];
    mark.bookId = bookId;
    mark.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    BookPage *pager = [chapter chapterPagerWithIndex:curPage];
    mark.offset = pager.pageRange.location;
    
    if ([mark existDbObjectsWhereRange:pager.pageRange]) {
        NSLog(@"书签已经存在！");
        return;
    }
    
    mark.content = [pager.attString attributedSubstringFromRange:NSMakeRange(0, MIN(MARK_TEXT_LENGTH,  pager.pageRange.length))].string;
    mark.content = [mark.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self saveBookMark:mark];
}

+ (void)saveBookMark:(BookMark *)readerMark
{
//    // TODO
    if ([readerMark insertToDb]) {
        PyAlertView *alertView = [PyAlertView defaultStyle];
        alertView.titleLabel.text = @"加入书签成功";
        [alertView show];
    }
}

+ (BOOL)existMarkWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage
{
    BookMark *mark = [[BookMark alloc]init];
    mark.bookId = bookId;
    mark.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    BookPage *pager = [chapter chapterPagerWithIndex:curPage];
    
    return [mark existDbObjectsWhereRange:pager.pageRange];
}

+ (BOOL)removeBookMarkWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage
{
    BookMark *mark = [[BookMark alloc]init];
    mark.bookId = bookId;
    mark.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    BookPage *pager = [chapter chapterPagerWithIndex:curPage];
    
    return [mark removeDbObjectsWhereRange:pager.pageRange];
}
@end
