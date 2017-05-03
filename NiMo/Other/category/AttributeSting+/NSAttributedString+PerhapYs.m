//
//  NSAttributedString+PerhapYs.m
//  NiMo
//
//  Created by PerhapYs on 17/5/2.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "NSAttributedString+PerhapYs.h"
#import <CoreText/CoreText.h>
@implementation NSAttributedString (PerhapYs)
//根据指定的大小,对字符串进行分页,计算出每页显示的字符串区间(NSRange)
- (NSArray *)pageRangeArrayWithConstrainedToSize:(CGSize)size
{
    NSAttributedString *attributedString = self;
    NSMutableArray * resultRange = [NSMutableArray array];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    //    以下方法耗时 基本再 0.5s 以内
     NSDate * date = [NSDate date];
    NSInteger rangeIndex = 0;
    do {
        NSUInteger length = MIN(600, attributedString.length - rangeIndex);
        NSAttributedString * childString = [attributedString attributedSubstringFromRange:NSMakeRange(rangeIndex, length)];
        CTFramesetterRef childFramesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) childString);
        UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:rect];
        CTFrameRef frame = CTFramesetterCreateFrame(childFramesetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL);
        
        CFRange range = CTFrameGetVisibleStringRange(frame);
        NSRange r = {rangeIndex, range.length};
        if (r.length > 0) {
            [resultRange addObject:[NSValue valueWithRange:r]];
        }
        rangeIndex += r.length;
        CFRelease(frame);
        CFRelease(childFramesetter);
    } while (rangeIndex < attributedString.length && attributedString.length > 0);
    NSTimeInterval millionSecond = [[NSDate date] timeIntervalSinceDate:date];
    NSLog(@"耗时 %lf", millionSecond);
    return resultRange;
}
@end
