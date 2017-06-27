//
//  PyAlertView.m
//  NiMo
//
//  Created by PerhapYs on 17/6/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "PyAlertView.h"

@interface PyAlertView ()



@end

@implementation PyAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self placeSubView];
    }
    return self;
}

-(void)placeSubView{
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundColorView = [UIView new];
    backgroundColorView.layer.cornerRadius = 2;
    backgroundColorView.clipsToBounds = YES;
    backgroundColorView.backgroundColor = [UIColor blackColor];
    backgroundColorView.alpha = 0.7;
    [self addSubview:backgroundColorView];
    [backgroundColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
+(instancetype)defaultStyle{
    
    PyAlertView *alertView = [[PyAlertView alloc] init];
    
    AlertStyle *style = [AlertStyle defaultAlertStyle];
    
    alertView.center = style.point;
    
    alertView.bounds = CGRectMake(0, 0, style.size.width, style.size.height);
    
    return alertView;
}

- (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    dispatch_time_t removeTime = dispatch_time(DISPATCH_TIME_NOW,1.0 * NSEC_PER_SEC);
    
    dispatch_after(removeTime, dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
        }];
        
    });
}
@end

@interface AlertStyle ()

@property (nonatomic , assign) CGSize size;

@property (nonatomic , assign) CGPoint point;


@end

@implementation AlertStyle

+ (instancetype)defaultAlertStyle{
    
    static dispatch_once_t onceToken;
    
    static AlertStyle *shareId = nil;
    
    @synchronized(self) {
        dispatch_once(&onceToken, ^{
            
            shareId = [[AlertStyle alloc] init];
            
            shareId.point = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HTIGHT / 2);
            
            shareId.size = CGSizeMake(200, 100);
            
        });
        
        return shareId;
    }
}
@end
