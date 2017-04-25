//
//  ReadBookViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/4/25.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "ReadBookViewController.h"

#import "UITextView+PerhapYs.h"
#import "NSString+PerhapYs.h"
#import "NSArray+PerhapYs.h"

#define RANGE_SHOWSETTING SCREEN_WIDTH / 3

@interface ReadBookViewController (){
    
    BOOL _showSetting;
    NSInteger _presentPage;
}

@property (nonatomic , strong) UIView *upSettingView;

@property (nonatomic , strong) UIView *belowSettingView;

@property (nonatomic , strong) UITextView *novelContentTextView;

@property (nonatomic , strong) UIImageView *novelContentImageView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation ReadBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self intializeData];
    [self initializeInterface];
}

-(void)intializeData{
    
    NSString*filePath = [NSString getBookPathWithName:@"大主宰" type:@"txt"];
    NSString *str = [NSString getNovelWithBookPath:filePath];
    
    int bookSize = [filePath getBookSizeUsingFilePath];
    
    NSString *firstStr = [str substringToIndex:str.length / bookSize];
    
    _dataSource = [[NSMutableArray alloc] initWithArray:[NSArray paragraphWithNovel:firstStr]];
    
    _showSetting = YES;
    
    _presentPage = 0;
}

-(void)initializeInterface{
    
    [self.view addSubview:self.novelContentImageView];
    [self.novelContentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.upSettingView];
    [self.upSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(SET_HEIGHT_(100));
        make.top.equalTo(self.view.mas_top).offset(-SET_HEIGHT_(100));
    }];
    
    [self.view addSubview:self.belowSettingView];
    [self.belowSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(self.view);
        make.height.mas_equalTo(SET_HEIGHT_(50));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(SET_HEIGHT_(50));
    }];
}
#pragma mark -- getter
-(UIImageView *)novelContentImageView{
    if (!_novelContentImageView) {
        _novelContentImageView = ({

            UIImageView *view = [UIImageView new];
            [view setImage:[UIImage imageNamed:@"readBook_backgroundImage"]];
            view.userInteractionEnabled = YES;
            
            [view addSubview:self.novelContentTextView];
            [self.novelContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view);
            }];
            
            
            view;
        });
    }
    
    return _novelContentImageView;
}
-(UITextView *)novelContentTextView{
    if (!_novelContentTextView) {
        _novelContentTextView = ({
            UITextView *view = [[UITextView alloc] init];
            
            view.backgroundColor = [UIColor clearColor];
            view.scrollEnabled = NO;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(novelTapEvent:)];
            [view addGestureRecognizer:tap];
            view.editable = NO;
            
            view.text = _dataSource[0];
            
            view;
        });
    }
    return _novelContentTextView;
}

-(UIView *)upSettingView{
    if (!_upSettingView) {
        _upSettingView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            
            UIButton *backBtn = [UIButton buttonWithType:0];
            [backBtn setTitle:@"返回" forState:UIControlStateNormal];
            [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [backBtn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:backBtn];
            [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(view.mas_bottom).offset(-SET_HEIGHT_(20));
                make.left.equalTo(view.mas_left).offset(SET_WIDTH_(40));
                make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(100), SET_HEIGHT_(50)));
            }];
            
            view;
        });
    }
    return _upSettingView;
}

-(UIView *)belowSettingView{
    if (!_belowSettingView) {
        _belowSettingView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            
            view;
        });
    }
    return _belowSettingView;
}

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.type = type;
    if (subtype != nil) {
        animation.subtype = subtype;
    }
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}


#pragma mark -- btn selected event

-(void)backEvent{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITapGestureRecognizer event

-(void)novelTapEvent:(UITapGestureRecognizer *)tap{
    
    CGPoint tapPoint = [tap locationInView:self.novelContentTextView];
    
    if (tapPoint.x > RANGE_SHOWSETTING && tapPoint.x <= 2 *RANGE_SHOWSETTING) {
        [self showSettingEvent];
    }
    else if (tapPoint.x <= RANGE_SHOWSETTING){
        
        [self lastPageEvent];
    }
    else{
        [self nextPageEvent];
    }
}
#pragma mark -- 显示设置

-(void)showSettingEvent{
    
    if (_showSetting) {
        [UIView animateWithDuration:0.2 animations:^{
           
            [self.upSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top);
            }];
            
            [self.belowSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_bottom);
            }];
            
            [self.view layoutIfNeeded];
        }];
        _showSetting = NO;
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            
            [self.upSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(-SET_HEIGHT_(100));
            }];
            
            [self.belowSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_bottom).offset(SET_HEIGHT_(50));
            }];
            
            [self.view layoutIfNeeded];
        }];
        _showSetting = YES;
    }
}
#pragma mark -- 翻页

-(void)nextPageEvent{
    
    if (_presentPage >= _dataSource.count - 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到头了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else{
        _showSetting = NO;
        [self showSettingEvent];
        _presentPage ++;
        NSString *subtypeString;
        subtypeString = kCATransitionFromRight;
        [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.novelContentImageView];
        
        [self.novelContentTextView setReadText:_dataSource[_presentPage]];
    }
}
-(void)lastPageEvent{
    if (_presentPage < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已经到头了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else{
        _showSetting = NO;
        [self showSettingEvent];
        _presentPage --;
        NSString *subtypeString;
        subtypeString = kCATransitionFromLeft;
        [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.novelContentImageView];
        
        [self.novelContentTextView setReadText:_dataSource[_presentPage]];
    }
}
@end
