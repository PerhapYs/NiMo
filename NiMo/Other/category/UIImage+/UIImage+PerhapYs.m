//
//  UIImage+PerhapYs.m
//  NiMo
//
//  Created by PerhapYs on 17/4/24.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "UIImage+PerhapYs.h"

@implementation UIImage (PerhapYs)

- (UIImage *)reSizeImagetoSize:(CGSize)reSize
{
    if (!self) {
        return [[UIImage alloc] init];
    }
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
