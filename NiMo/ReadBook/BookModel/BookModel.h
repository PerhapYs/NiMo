//
//  BookModel.h
//  NiMo
//
//  Created by PerhapYs on 17/4/28.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookChapter.h"

@interface BookModel : NSObject

@property (nonatomic, assign) NSInteger bookId;     // 书本id
@property (nonatomic, strong) NSString *bookName;   // 书本名
@property (nonatomic, assign) NSInteger totalChapter; // 书本章节
@property (nonatomic, assign) NSInteger curChpaterIndex; // 当前章节

// 是否有下章节
- (BOOL)haveNextChapter;

// 是否有上章节
- (BOOL)havePreChapter;

// 重置章节
- (void)resetChapter:(BookChapter *)chapter;

// 获取书籍的章节
- (BookChapter *)openBookWithChapter:(NSInteger)chapter;

- (BookChapter *)openBookNextChapter;

- (BookChapter *)openBookPreChapter;


@end