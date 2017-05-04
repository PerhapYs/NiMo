//
//  BookMark.m
//  NiMo
//
//  Created by PerhapYs on 17/5/4.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookMark.h"

@implementation BookMark

+ (NSMutableArray *)dbObjectsWithBookId:(NSInteger)bookId
{
    NSString *contion = [NSString stringWithFormat:@"bookId = '%ld'",bookId];
    return [self dbObjectsWhere:contion orderby:nil];
}

+ (NSArray *)dbObjectsWithBookId:(NSInteger)bookId chapterName:(NSString *)chapterName
{
    NSString *contion = [NSString stringWithFormat:@"bookId = '%ld' and chapterIndex = '%@'",bookId,chapterName];
    return [self dbObjectsWhere:contion orderby:nil];
}

-(BOOL)existDbObjectsWhereRange:(NSRange)range{
    
    NSArray *array = [[self class] dbObjectsWithBookId:_bookId chapterName:_chapterIndex];
    for (BookMark *mark in array) {
        if (NSLocationInRange(mark.offset, range)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)removeDbObjectsWhereRange:(NSRange)range
{
    BOOL isRemove = NO;
    NSArray *array = [[self class] dbObjectsWithBookId:_bookId chapterName:_chapterIndex];
    for (BookMark *mark in array) {
        if (NSLocationInRange(mark.offset, range)) {
            NSString *contion = [NSString stringWithFormat:@"bookId = '%ld' and chapterIndex = '%@' and offset = '%ld'",_bookId,_chapterIndex,mark.offset];
            isRemove = [BookMark removeDbObjectsWhere:contion];
            NSLog(@"删除书签 %d",isRemove);
        }
    }
    return isRemove;
}

- (BOOL)removeDbObjects
{
    BOOL isRemove = NO;
    NSArray *array = [[self class] dbObjectsWithBookId:_bookId chapterName:_chapterIndex];
    
    for (BookMark *mark in array) {
        if (mark.offset == _offset) {
            NSString *contion = [NSString stringWithFormat:@"bookId = '%ld' and chapterIndex = '%@' and offset = '%ld'",_bookId,_chapterIndex,mark.offset];
            isRemove = [BookMark removeDbObjectsWhere:contion];
            NSLog(@"删除书签 %d",isRemove);
            break;
        }
    }
    return isRemove;
}

@end
