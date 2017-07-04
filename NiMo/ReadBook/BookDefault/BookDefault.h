//
//  BookDefault.h
//  NiMo
//
//  Created by  on 17/5/8.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "EDbObject.h"
#import "BookChapter.h"
#import "BookPage.h"

#import "BookModel.h"
@interface BookDefault : EDbObject

@property (nonatomic, strong) NSString *chapterIndex; // 章节下标

@property (nonatomic, assign) NSInteger offset;       // 章节位移

+(void)updateBookDefaultWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage;

+ (NSArray *)dbObjectsWithBookId:(NSInteger)bookId;

+(BookDefault *)getDefaultWithBookId:(NSInteger)bookId;

@end
