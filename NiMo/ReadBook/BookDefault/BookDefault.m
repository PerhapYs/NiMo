//
//  BookDefault.m
//  NiMo
//
//  Created by PerhapYs on 17/5/8.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookDefault.h"
#import "BookPage.h"
#import "NSString+PerhapYs.h"
#import "BookManager.h"

@interface BookDefault ()



@end

@implementation BookDefault

+ (NSArray *)dbObjectsWithBookId:(NSInteger)bookId
{
    NSString *contion = [NSString stringWithFormat:@"bookId = '%ld'",bookId];
    return [self dbObjectsWhere:contion orderby:nil];
}

-(BOOL)updateBookSettingWithBookId:(NSInteger)bookId{
    
    NSString *contion = [NSString stringWithFormat:@"bookId = '%ld'",bookId];
    
   return [self updateToDbsWhere:contion];
}
+(BOOL)exsitBookWithBookId:(NSInteger)bookId{
    
    NSArray *arr = [self dbObjectsWithBookId:bookId];
    
    if (arr && arr.count > 0) {
       
        return YES;
    }
    
    return NO;
}

+(void)updateBookDefaultWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage{

    BOOL isExsit = [self exsitBookWithBookId:bookId];
    
    BookDefault *bookSetting = [BookDefault getDefaultWithBookId:bookId];
    bookSetting.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    BookPage *pager = [chapter chapterPagerWithIndex:curPage];
    bookSetting.offset = pager.pageRange.location;
    
    if (isExsit) {  // 书籍默认信息存在
        
        [bookSetting updateBookSettingWithBookId:bookId];
        return;
    }
    else{
        
        [bookSetting insertToDb];
    }
}
+(BookDefault *)getDefaultWithBookId:(NSInteger)bookId{
    
    BOOL isExsit = [self exsitBookWithBookId:bookId];
    
    if (isExsit) {
        
        NSArray *defaultArray = [BookDefault dbObjectsWithBookId:bookId];
        BookDefault *bookSetting = defaultArray[0];
        
        return bookSetting;
    }
    else{
        
        BookDefault *bookSetting = [[BookDefault alloc] init];
        bookSetting.chapterIndex = @"0";
        bookSetting.offset = 0;
        
        [bookSetting insertToDb];
        
        return bookSetting;
    }
}
@end
