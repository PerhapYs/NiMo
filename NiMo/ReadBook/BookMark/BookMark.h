//
//  BookMark.h
//  NiMo
//
//  Created by PerhapYs on 17/5/4.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "EDbObject.h"

@interface BookMark : EDbObject

@property (nonatomic, assign) NSInteger bookId;
@property (nonatomic, strong) NSString *chapterIndex; // 章节下标
@property (nonatomic, strong) NSString *content;      // 标签文本
@property (nonatomic, strong) NSString *time;         // 时间（未使用）
@property (nonatomic, assign) NSInteger offset;       // 章节位移

- (BOOL)existDbObjectsWhereRange:(NSRange)range;

+ (NSMutableArray *)dbObjectsWithBookId:(NSInteger)bookId;

- (BOOL)removeDbObjectsWhereRange:(NSRange)range;

- (BOOL)removeDbObjects;
@end
