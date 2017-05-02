//
//  BookManager.h
//  NiMo
//
//  Created by PerhapYs on 17/4/26.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookManager : NSObject

+ (instancetype)shareBook;

+ (NSUInteger)fontSize;

+(NSInteger)BookTransitionStyle;
@end

