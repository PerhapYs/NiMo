//
//  BookManager.h
//  NiMo
//
//  Created by PerhapYs on 17/4/26.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookChapter.h"

@interface BookManager : NSObject

@property (nonatomic , strong) MMDrawerController *bookMMD;

+ (instancetype)shareBook;

+ (NSUInteger)fontSize;

+(NSInteger)BookTransitionStyle;

+ (NSArray<BookChapter *> *)analyseTxtWithContent:(NSString *)content
                            maintainEmptyCharcter:(BOOL)maintainEmptyCharcter;
// 保存书签
+ (void)saveBookMarkWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage;

+ (BOOL)existMarkWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage;

+ (BOOL)removeBookMarkWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage;
@end

