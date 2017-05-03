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
#import "BookModel.h"
#import "BookChapter.h"

#define HEIGHT_TOPSETING SET_HEIGHT_(60)

#define HEIGHT_BELOWSETTING SET_HEIGHT_(100)

#define HEIGHT_FONTSETTING SET_HEIGHT_(100)


@interface BookBasicViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    
    BOOL _isShowSetting;
    BOOL _isShowFont;
    BookModel *_readBook;
    BookChapter *_chapter;
}

@property (nonatomic, strong) UIPageViewController * pageViewController;

@property (nonatomic , strong) UIView *topSettingView;

@property (nonatomic , strong) UIView *belowSettingView;

@property (nonatomic, assign) CGSize renderSize;

@property (nonatomic, assign) NSInteger curPage;    // 当前页数

@property (nonatomic, assign) NSInteger readOffset; // 当前页在本章节位移
@end

@implementation BookBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initializeData];
    [self intializeInterface];
    [self addSingleTapGesture];
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
    if (_isShowFont) {
        
        return;
    }
    
    if (_isShowSetting) {
        [self hidenSettingBar];
    }
    else{
        [self showSettingBar];
    }
}

#pragma mark - 初始化数据
-(void)initializeData{
    
    _isShowFont = NO;
    _isShowSetting = NO;
     _renderSize = [TextViewController renderSizeWithFrame:self.view.frame];
    [self getBookContent];
}
-(void)getBookContent{
    
    if (!_readBook) {
        _readBook = [[BookModel alloc] init];
        _readBook.bookId = 1;
        _readBook.bookName = @"大主宰";
        _readBook.totalChapter = 1;
    }
   _chapter = [self getBookChapter:1];
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
            
            view.backgroundColor = [UIColor whiteColor];
            
            UIView *upLineView = [UIView new];
            upLineView.backgroundColor = [UIColor blackColor];
            [view addSubview:upLineView];
            [upLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.and.top.equalTo(view);
                make.height.mas_equalTo(SET_HEIGHT_(1));
            }];
            
            view;
        });
    }
    return _belowSettingView;
}
-(UIView *)topSettingView{
    if (!_topSettingView) {
        _topSettingView = ({
            UIView *view = [UIView new];
            
            view.backgroundColor = [UIColor whiteColor];
            
            UIButton *goBackBtn = [UIButton buttonWithType:0];
            [goBackBtn setImage:[UIImage imageNamed:@"btn_back_red"] forState:UIControlStateNormal];
            [goBackBtn addTarget:self action:@selector(closeViewEvent) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:goBackBtn];
            [goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(SET_WIDTH_(10));
                make.bottom.equalTo(view.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(40), SET_HEIGHT_(40)));
            }];
            
            UIView *belowLineView = [UIView new];
            belowLineView.backgroundColor = [UIColor blackColor];
            [view addSubview:belowLineView];
            [belowLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.and.bottom.equalTo(view);
                make.height.mas_equalTo(SET_HEIGHT_(1));
            }];
            
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

#pragma mark -- 设置显示/隐藏 设置
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
    _isShowSetting = YES;
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
    _isShowSetting = NO;
}

#pragma mark -- 显示/隐藏 字体修改



#pragma mark - 设置显示第几页

-(void)showBookWithPage:(NSUInteger)page{
    _curPage = page;
    TextViewController *textVC = [self readerControllerWithPage:page chapter:_chapter];
    
    [self.pageViewController setViewControllers:@[textVC]
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
}
- (TextViewController *)readerControllerWithPage:(NSUInteger)page chapter:(BookChapter *)chapter
{
    TextViewController *readerViewController = [[TextViewController alloc]init];
    [self confogureReaderController:readerViewController page:page chapter:chapter];
    return readerViewController;
}

- (void)confogureReaderController:(TextViewController *)readerViewController page:(NSUInteger)page chapter:(BookChapter *)chapter
{
    if ([BookManager BookTransitionStyle] == 0) {
        _curPage = page;
    }
    readerViewController.readerChapter = chapter;
    readerViewController.readerPager = [chapter chapterPagerWithIndex:page];
    if (readerViewController.readerPager) {
        NSRange range = readerViewController.readerPager.pageRange;
        _readOffset = range.location+range.length/3;
    }
}

#pragma mark -- UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"🌹");
}

#pragma mark -- UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    TextViewController *curReaderVC = (TextViewController *)viewController;
    NSInteger currentPage = curReaderVC.readerPager.pageIndex;
    _curPage = currentPage;
    
    BookChapter *chapter = curReaderVC.readerChapter;
    
    if (_chapter != chapter) {
        _chapter = chapter;
        [_readBook resetChapter:chapter];
    }
    
    TextViewController *readerVC = [[TextViewController alloc]init];
    if (currentPage > 0) {
        [self confogureReaderController:readerVC page:currentPage-1 chapter:chapter];
        NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
        return readerVC;
    }else {
        if ([_readBook havePreChapter]) {
            NSLog(@"--获取上一章");
            BookChapter *preChapter = [self getBookPreChapter];
            [self confogureReaderController:readerVC page:preChapter.totalPage-1 chapter:preChapter];
            NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
            return readerVC;
        }else {
            NSLog(@"已经是第一页了");
            return nil;
        }
    }
    return readerVC;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    TextViewController *curReaderVC = (TextViewController *)viewController;
    NSInteger currentPage = curReaderVC.readerPager.pageIndex;
    _curPage = currentPage;
    
    BookChapter *chapter = curReaderVC.readerChapter;
    
    if (_chapter != chapter) {
        _chapter = chapter;
        [_readBook resetChapter:chapter];
    }
    
    TextViewController *readerVC = [[TextViewController alloc]init];
    if (currentPage < chapter.totalPage - 1) {
        [self confogureReaderController:readerVC page:currentPage+1 chapter:chapter];
        NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
        return readerVC;
    }else {
        if ([_readBook haveNextChapter]) {
            NSLog(@"--获取下一章");
            BookChapter *nextChapter = [self getBookNextChapter];
            [self confogureReaderController:readerVC page:0 chapter:nextChapter];
            NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
            return  readerVC;
        }else {
            NSLog(@"已经是最后一页了");
            return nil;
        }
    }
    return readerVC;
}
#pragma mark -- btn selected event
-(void)closeViewEvent{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  -- 获取章节

// 获取章节
- (BookChapter *)getBookChapter:(NSInteger)chapterIndex
{
    BookChapter *chapter = [_readBook openBookWithChapter:chapterIndex];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}
- (BookChapter *)getBookNextChapter
{
    BookChapter *chapter = [_readBook openBookNextChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}
- (BookChapter *)getBookPreChapter
{
    BookChapter *chapter = [_readBook openBookPreChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}

@end
