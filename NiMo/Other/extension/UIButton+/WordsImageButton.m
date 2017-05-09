
//
//  WordsImageButton.m
//  NiMo
//
//  Created by PerhapYs on 17/5/9.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "WordsImageButton.h"

@implementation WordsImageButton

- (void)setImage:(UIImage *)image
       withTitle:(NSString *)title
      titleColor:(UIColor *)titleColor
        forState:(UIControlState)stateType {
    CGSize titleSize = [title sizeWithAttributes:@{
                                                   NSFontAttributeName: [UIFont systemFontOfSize:12]
                                                   }];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, -titleSize.width)];
    
    
    [self setTintColor:[UIColor redColor]];
    if (stateType != UIControlStateNormal) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    } else {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [self setImage:image forState:stateType];
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30, -image.size.width, 0, 0)];
    [self setTitle:title forState:stateType];
    [self setTitleColor:titleColor forState:stateType];
    
    _title = title;
}
@end
