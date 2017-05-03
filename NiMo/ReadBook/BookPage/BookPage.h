//
//  BookPage.h
//  NiMo
//
//  Created by PerhapYs on 17/4/28.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookPage : NSObject

@property (nonatomic, strong) NSAttributedString *attString; // 本页属性文本
@property (nonatomic, assign) NSRange pageRange;   // 本页范围
@property (nonatomic, assign) NSInteger pageIndex; // 本页下标

@end
