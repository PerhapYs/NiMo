//
//  BookBasicViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/4/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookBasicViewController.h"
#import "BookManager.h"
#import "TextViewController.h"


#define HEIGHT_TOPSETING SET_HEIGHT_(100)

#define HEIGHT_BELOWSETTING SET_HEIGHT_(100)

#define HEIGHT_FONTSETTING SET_HEIGHT_(100)


@interface BookBasicViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    
    BOOL _isShowSetting;
}

@property (nonatomic, strong) UIPageViewController * pageViewController;

@property (nonatomic , strong) UIView *topSettingView;

@property (nonatomic , strong) UIView *belowSettingView;
@end

@implementation BookBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initializeData];
    [self intializeInterface];
    [self showBookWithPage:0];  // 默认显示第一页数据
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)addSingleTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //增加事件者响应者，
    [self.view addGestureRecognizer:singleTap];
}
- (void)singleTapAction:(UIGestureRecognizer *)gesture
{
   
}

#pragma mark - 初始化数据
-(void)initializeData{
    
    _isShowSetting = NO;
}
#pragma mark -- 初始化界面

-(void)intializeInterface{
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    [self.view addSubview:self.topSettingView];
    [self.topSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-HEIGHT_TOPSETING);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_TOPSETING);
    }];
    
    [self.view addSubview:self.belowSettingView];
    [self.belowSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_BELOWSETTING);
        make.bottom.equalTo(self.view.mas_bottom).offset(HEIGHT_BELOWSETTING);
    }];
}
#pragma mark - view
-(UIView *)belowSettingView{
    if (!_belowSettingView) {
        
        _belowSettingView = ({
            UIView *view = [UIView new];
            
            view.backgroundColor = [UIColor blueColor];
            
            view;
        });
    }
    return _belowSettingView;
}
-(UIView *)topSettingView{
    if (!_topSettingView) {
        _topSettingView = ({
            UIView *view = [UIView new];
            
            view.backgroundColor = [UIColor redColor];
            
            view;
        });
    }
    return _topSettingView;
}

-(UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = ({
            NSInteger bookTransitionStyle = [BookManager BookTransitionStyle];
            
            UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:bookTransitionStyle navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            pageViewController.delegate = self;
            pageViewController.dataSource = self;
            pageViewController.view.frame = self.view.bounds;
            
            pageViewController;
        });
    }
    return _pageViewController;
}

#pragma mark -- 设置显示/隐藏
// 显示
-(void)showSettingBar{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.topSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
        }];
        
        [self.belowSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        [self.view layoutIfNeeded];
        
    }];
}
// 隐藏
-(void)hidenSettingBar{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.topSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(-HEIGHT_TOPSETING);
        }];
        
        [self.belowSettingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(HEIGHT_BELOWSETTING);
        }];
        [self.view layoutIfNeeded];
        
    }];
}

#pragma mark - 设置显示第几页

-(void)showBookWithPage:(NSUInteger)page{
    
    [self.pageViewController setViewControllers:@[[[TextViewController alloc] init]]
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
}

#pragma mark -- UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"🌹");
}

#pragma mark -- UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSLog(@"下一页");
    
    TextViewController *textVc = [[TextViewController alloc] init];
    return textVc;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSLog(@"上一叶");
    
    TextViewController *textVc = [[TextViewController alloc] init];
    return textVc;
}
@end
