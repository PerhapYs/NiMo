//
//  PyAlertView.h
//  NiMo
//
//  Created by PerhapYs on 17/6/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertStyle;
@interface PyAlertView : UIView

@property (nonatomic , strong) UILabel *titleLabel;

+(instancetype)defaultStyle;

- (void)show;

@end


@interface AlertStyle : NSObject

@property (nonatomic , readonly , assign) CGSize size;

@property (nonatomic , readonly ,assign) CGPoint point;

+(instancetype)defaultAlertStyle;

@end
