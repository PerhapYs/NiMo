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

+ (instancetype)shareBook;

+ (NSUInteger)fontSize;

+(NSInteger)BookTransitionStyle;

+ (void)extractNovelWithContent:(NSString *)content
                          async:(BOOL)isAsync
          maintainEmptyCharcter:(BOOL)isNeedMaintainEmptyCharcter
                         result:(void(^)(NSArray<BookChapter *> *models))result;

+ (NSArray<BookChapter *> *)analyseTxtWithContent:(NSString *)content
                            maintainEmptyCharcter:(BOOL)maintainEmptyCharcter;
@end

