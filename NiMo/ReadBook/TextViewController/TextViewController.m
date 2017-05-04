//
//  TextViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/4/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "TextViewController.h"
#import <TYAttributedLabel.h>
#import "BookPage.h"
#import "BookChapter.h"

#define kTextLabelHorEdge 15
#define kTextLabelTopEdge 25
#define kTextLabelBottomEdge 10

@interface TextViewController ()

@property (nonatomic, weak) TYAttributedLabel *showChapterLabel;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self intializeInterface];
}
- (void)viewWillLayoutSubviews
{
    _showChapterLabel.frame = [[self class]renderFrameWithFrame:self.view.frame];
}

-(void)intializeInterface{
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"readBook_backgroundImage"]];
    [self.view addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    TYAttributedLabel *label = [[TYAttributedLabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.attributedText = _readerPager.attString;
    [self.view addSubview:label];
    _showChapterLabel = label;
}


#pragma mark - renderSize

+ (CGRect)renderFrameWithFrame:(CGRect)frame
{
    return CGRectMake(kTextLabelHorEdge, kTextLabelTopEdge, CGRectGetWidth(frame)-2*kTextLabelHorEdge, CGRectGetHeight(frame)-kTextLabelTopEdge-kTextLabelBottomEdge);
}

+ (CGSize)renderSizeWithFrame:(CGRect)frame
{
    return [self renderFrameWithFrame:frame].size;
}


@end
