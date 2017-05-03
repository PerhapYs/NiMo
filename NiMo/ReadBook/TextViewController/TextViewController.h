//
//  TextViewController.h
//  NiMo
//
//  Created by PerhapYs on 17/4/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "TopViewController.h"
@class BookPage;
@class BookChapter;

@interface TextViewController : TopViewController

@property (nonatomic, strong) BookChapter *readerChapter;
@property (nonatomic, strong) BookPage *readerPager;
@property (nonatomic, assign) NSUInteger totalPage;

// 获取当前图文label 的大小
+ (CGSize)renderSizeWithFrame:(CGRect)frame;
@end
