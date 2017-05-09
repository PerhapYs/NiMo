//
//  WordsImageButton.h
//  NiMo
//
//  Created by PerhapYs on 17/5/9.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordsImageButton : UIButton

@property (nonatomic , strong) NSString *title;

- (void)setImage:(UIImage *)image
       withTitle:(NSString *)title
      titleColor:(UIColor *)titleColor
        forState:(UIControlState)stateType;
@end
