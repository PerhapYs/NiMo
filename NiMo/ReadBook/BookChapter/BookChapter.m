//
//  BookChapter.m
//  NiMo
//
//  Created by PerhapYs on 17/4/28.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookChapter.h"
#import <TYTextContainer.h>
#import <RegexKitLite.h>
#import "BookManager.h"
#import "NSAttributedString+PerhapYs.h"

@interface BookChapter ()

@property (nonatomic, strong) NSAttributedString *attString;

@end

@implementation BookChapter


- (void)parseChapterWithRenderSize:(CGSize)renderSize
{
    _renderSize = renderSize;
    [self parseChapter];
}


// 解析章节文本
- (void)parseChapter
{
//     textContainer 的属性 比如font linesSpacing... 应该和 显示的label 一致
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
    textContainer.text = _chapterContent;
    textContainer.font = [UIFont systemFontOfSize:[BookManager fontSize]];
    NSMutableArray *tmpArray = [NSMutableArray array];
    // 正则匹配图片信息
    [_chapterContent enumerateStringsMatchedByRegex:@"\\[(\\w+?),(\\d+?),(\\d+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if (captureCount > 3) {
            // 图片信息储存
            TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
            imageStorage.imageName = capturedStrings[1];
            imageStorage.range = capturedRanges[0];
            imageStorage.size = CGSizeMake([capturedStrings[2]intValue], [capturedStrings[3]intValue]);
            
            [tmpArray addObject:imageStorage];
        }
    }];
    
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.font = [UIFont systemFontOfSize:[BookManager fontSize]+6];
    textStorage.range = NSMakeRange([_chapterContent rangeOfString:@"第"].location, 3);
    [tmpArray addObject:textStorage];
    
    
    TYTextStorage *textStorage1 = [[TYTextStorage alloc]init];
    textStorage1.font = [UIFont systemFontOfSize:[BookManager fontSize]+4];
    textStorage1.range = NSMakeRange([_chapterContent rangeOfString:@"]"].location, 20);
    [tmpArray addObject:textStorage1];
    
    // 添加图片信息数组到label
    [textContainer addTextStorageArray:tmpArray];
    
    // 以上是 test data  ，应该按照你的方式解析文本 然后生成_attString 就可以了
    _attString = [textContainer createAttributedString];

    _pageRangeArray = [_attString pageRangeArrayWithConstrainedToSize:_renderSize];
}

- (NSInteger)totalPage
{
    return _pageRangeArray.count;
}

- (NSRange)chapterPagerRangeWithIndex:(NSInteger)pageIndex
{
    if (pageIndex >= 0 && pageIndex < _pageRangeArray.count) {
        NSRange range = [_pageRangeArray[pageIndex] rangeValue];
        return range;
    }
    return NSMakeRange(NSNotFound, 0);
}

- (BookPage *)chapterPagerWithIndex:(NSInteger)pageIndex
{
    NSRange range = [self chapterPagerRangeWithIndex:pageIndex];
    if (range.location != NSNotFound) {
        BookPage *page = [[BookPage alloc]init];
        page.attString = [_attString attributedSubstringFromRange:range];
        page.pageRange = range;
        page.pageIndex = pageIndex;
        return page;
    }
    return nil;
}

- (NSInteger)pageIndexWithChapterOffset:(NSInteger)offset
{
    
    NSInteger pageIndex = 0;
   
    for (NSValue *rangeValue in _pageRangeArray) {
        
        NSRange range = [rangeValue rangeValue];
        
        if (NSLocationInRange(offset, range)) {
            
            return pageIndex;
        }
        ++ pageIndex;
    }
    return NSNotFound;
}

@end
