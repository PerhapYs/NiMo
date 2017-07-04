//
//  BookDefault.m
//  NiMo
//
//  Created by PerhapYs on 17/5/8.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookDefault.h"
#import "BookPage.h"
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
    
    if (arr) {
       
        return YES;
    }
    
    return NO;
}

+(void)updateBookDefaultWithBookId:(NSInteger)bookId Chapter:(BookChapter *)chapter curPage:(NSInteger)curPage{

    BOOL isExsit = [self exsitBookWithBookId:bookId];
    
    BookDefault *bookSetting = [BookDefault getDefaultWithBookId:bookId];
    bookSetting.bookId = bookId;
    bookSetting.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    BookPage *pager = [chapter chapterPagerWithIndex:curPage];
    bookSetting.offset = pager.pageRange.location;
    if (isExsit) {
        
        if ([bookSetting updateBookSettingWithBookId:bookId]) {
            NSLog(@"更新默认成功");
        }
        return;
    }

    if ([bookSetting insertToDb]) {
     
        NSLog(@"初始化默认");
    }
}
+(BookDefault *)getDefaultWithBookId:(NSInteger)bookId{
    
    NSArray *defaultArray = [BookDefault dbObjectsWithBookId:bookId];
    
    if (defaultArray && defaultArray.count > 0) {
        
        BookDefault *bookSetting = defaultArray[0];
        
        return bookSetting;
    }
    else{
        
        BookDefault *bookSetting = [[BookDefault alloc] init];
        bookSetting.chapterIndex = @"0";
        bookSetting.offset = 0;
    
        return bookSetting;
    }
}

@end
