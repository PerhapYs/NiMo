//
//  UITextView+PerhapYs.m
//  NiMo
//
//  Created by PerhapYs on 17/4/25.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "UITextView+PerhapYs.h"

@implementation UITextView (PerhapYs)


-(void)setReadText:(NSString *)text{
    
    NSMutableParagraphStyle *MParaStyle = [[NSMutableParagraphStyle alloc] init];
    MParaStyle.alignment =  NSTextAlignmentJustified;  // 文字站位
    MParaStyle.maximumLineHeight = 20;  // 最大高度
    MParaStyle.lineHeightMultiple = 15 ;  //  平均高度
    MParaStyle.minimumLineHeight = 10;  // 最小高度
    MParaStyle.firstLineHeadIndent = 20; // 首行缩进
    MParaStyle.paragraphSpacing = 50;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:MParaStyle forKey:NSParagraphStyleAttributeName];
    
    NSAttributedString *mText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    [self setAttributedText:mText];
}

@end
