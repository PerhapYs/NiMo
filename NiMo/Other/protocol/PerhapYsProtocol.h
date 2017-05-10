//
//  PerhapYsProtocol.h
//  NiMo
//
//  Created by PerhapYs on 17/5/10.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PerhapYsProtocol <NSObject>

@end


@protocol CenterProtocol <NSObject>

-(void)updateLeftViewControllerTableViewWithChapter:(BookChapter *)chapter;

@end


@protocol LeftProtocol <NSObject>

-(void)updateBookChapterWithChapterIndex:(NSInteger)chapterIndex;

@end
