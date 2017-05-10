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
#import "WordsImageButton.h"
#import "BookChapter.h"

#define HEIGHT_TOPSETING SET_HEIGHT_(60)

#define HEIGHT_BELOWSETTING SET_HEIGHT_(100)

#define HEIGHT_FONTSETTING SET_HEIGHT_(100)


@interface BookBasicViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    
    BOOL _isShowSetting;
    BOOL _isShowFont;
    
    BookChapter *_chapter;
    
    BookDefault *_default;
    
    UIButton *_bookmarkBtn;  // 书签按钮
    
    UISlider *_bookSlider;  // 读书进度
    
    UILabel *_showProcessTitleLabel; // 显示滑动标题
    UILabel *_showProcessPageLabel; // 显示滑动进度
}

@property (nonatomic, strong) UIPageViewController * pageViewController;

@property (nonatomic , strong) UIView *topSettingView;

@property (nonatomic , strong) UIView *belowSettingView;

@property (nonatomic , strong) UIView *belowFontView;

@property (nonatomic , strong) UIView *showPageView;  // 展示当前页数(滑动进度条出现)

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
    [self showBookWithPage:_curPage];
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
#pragma mark -- 设置手势 及事件
- (void)addSingleTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //增加事件者响应者，
    [self.view addGestureRecognizer:singleTap];
}
- (void)singleTapAction:(UIGestureRecognizer *)gesture
{
    if (_isShowFont) {
        
        [self hidenFontBar];
        
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
    
    _isShowFont = NO;  // 默认隐藏字体设置
    _isShowSetting = NO;  // 默认隐藏设置
     _renderSize = [TextViewController renderSizeWithFrame:self.view.frame];  //文本显示大小
    
    [self getBookContent];
}
-(BookModel *)readBook{
    
    if (!_readBook) {
        _readBook = ({
            BookModel *book = [[BookModel alloc] init];
            
            book;
        });
    }
    return _readBook;
}
// 获取文章内容
-(void)getBookContent{
    
    _default = [BookDefault getDefaultWithBookId:_readBook.bookId];
    
    NSInteger chapterIndex = [_default.chapterIndex integerValue];
    
   _chapter = [self getBookChapter:chapterIndex];
    
    _curPage = [_chapter pageIndexWithChapterOffset:_default.offset];
}

#pragma mark -- 初始化界面

-(void)intializeInterface{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"readBook_backgroundImage"]];
    [self.view addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
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
    
    [self.view addSubview:self.belowFontView];
    [self.belowFontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_FONTSETTING);
        make.bottom.equalTo(self.view.mas_bottom).offset(HEIGHT_FONTSETTING);
    }];
    
    [self.view addSubview:self.showPageView];
    [self.showPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.belowSettingView.mas_top).offset(-SET_HEIGHT_(20));
        make.centerX.equalTo(self.belowSettingView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(300), SET_HEIGHT_(70)));
    }];
}

#pragma mark -- 设置显示/隐藏 设置
// 显示
-(void)showSettingBar{
    
    BOOL haveMarkInCurPage = [BookManager existMarkWithBookId:_readBook.bookId Chapter:_chapter curPage:_curPage];
    
    _bookmarkBtn.selected = haveMarkInCurPage;
    [_bookSlider setValue:_readBook.curChpaterIndex animated:YES];
    
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
    
    _showPageView.hidden = YES;
    
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
// 显示
-(void)showFontBar{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.belowFontView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        [self.view layoutIfNeeded];
    }];
    _isShowFont = YES;
}

-(void)hidenFontBar{
    
    [UIView animateWithDuration:0.2 animations:^{
       
        [self.belowFontView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(HEIGHT_FONTSETTING);
        }];
        [self.view layoutIfNeeded];
    }];
    _isShowFont = NO;
}
#pragma mark - 设置显示章节第几页

-(void)showBookWithPage:(NSUInteger)page{
    _curPage = page;
    TextViewController *textVC = [self readerControllerWithPage:page chapter:_chapter];
    [BookDefault updateBookDefaultWithBookId:_readBook.bookId Chapter:_chapter curPage:page];
    
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
    [self hidenSettingBar];
    [self hidenFontBar];
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
        [BookDefault updateBookDefaultWithBookId:_readBook.bookId Chapter:chapter curPage:currentPage-1];
       
        return readerVC;
    }else {
        if ([_readBook havePreChapter]) {
            
            BookChapter *preChapter = [self getBookPreChapter];
            [self confogureReaderController:readerVC page:preChapter.totalPage-1 chapter:preChapter];
            [BookDefault updateBookDefaultWithBookId:_readBook.bookId Chapter:preChapter curPage:preChapter.totalPage-1];
            
            return readerVC;
        }else {
            
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
        
        [BookDefault updateBookDefaultWithBookId:_readBook.bookId Chapter:chapter curPage:currentPage+1];
        return readerVC;
    }else {
        if ([_readBook haveNextChapter]) {
           
            BookChapter *nextChapter = [self getBookNextChapter];
            [self confogureReaderController:readerVC page:0 chapter:nextChapter];
            
            [BookDefault updateBookDefaultWithBookId:_readBook.bookId Chapter:nextChapter curPage:0];
            return  readerVC;
        }else {
           
            return nil;
        }
    }
    return readerVC;
}
#pragma mark -- btn selected event
// 关闭书籍
-(void)closeViewEvent{
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 点击书签按钮
-(void)bookMarkSelectedEvent:(UIButton *)btn{
    
    if (btn.isSelected) {
        [self removeCurrentChapterPagerMark];
    }else {
        [self saveCurrentChapterPagerMark];
    }
    btn.selected = !btn.selected;
}
#pragma mark -- slider event
-(void)changeBookProcessEvent:(UISlider *)slider{
    
    [self turnToBookChapter:slider.value chapterOffset:0];
}
-(void)showChangeProcessEvent:(UISlider *)slider{
    
    _showPageView.hidden = NO;
    [self showSliderProcessWithChapterIndex:floorf(slider.value)];
}
-(void)showSliderProcessWithChapterIndex:(float)chapterIndex{
    
    BookChapter *bookChapter =  [self getBookChapter:chapterIndex];
    _showProcessTitleLabel.text = bookChapter.chapterTitle;
    
    _showProcessPageLabel.text = [NSString stringWithFormat:@"%.0f / %ld",chapterIndex,(long)_readBook.totalChapter];
}
#pragma mark -- 打开下一章/上一章
-(void)openPreChapterEvent{
   _chapter = [self getBookPreChapter];
    NSInteger pageIndex = [_chapter pageIndexWithChapterOffset:0];
    _showProcessTitleLabel.text = _chapter.chapterTitle;
    
    _showProcessPageLabel.text = [NSString stringWithFormat:@"%.0f / %ld",(float)_chapter.chapterIndex,(long)_readBook.totalChapter];
    [self showBookWithPage:pageIndex];
}
-(void)openNextChapterEvent{
    _chapter = [self getBookNextChapter];
    NSInteger pageIndex = [_chapter pageIndexWithChapterOffset:0];
    
    _showProcessTitleLabel.text = _chapter.chapterTitle;
    
    _showProcessPageLabel.text = [NSString stringWithFormat:@"%.0f / %ld",(float)_chapter.chapterIndex,(long)_readBook.totalChapter];
    [self showBookWithPage:pageIndex];
}

#pragma mark -- 底部设置
-(void)belowToolSelectedEvent:(WordsImageButton *)settingBtn{
    
    [self hidenSettingBar];
    if ([settingBtn.title isEqualToString:@"文字"]) {
    
        [self showFontBar];
    }
    else if ([settingBtn.title isEqualToString:@"目录"]){
        
        [[BookManager shareBook].bookMMD openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
            
            [self.leftDelegate updateLeftViewControllerTableViewWithChapter:_chapter];
            
        }];
    }
    else if ([settingBtn.title isEqualToString:@"书签"]){
        
    }
    else{
        return;
    }
}
#pragma mark -- 书签
// 移除书签
- (void)removeCurrentChapterPagerMark
{
    [BookManager removeBookMarkWithBookId:_readBook.bookId Chapter:_chapter curPage:_curPage];
}

// 保存书签
-(void)saveCurrentChapterPagerMark
{
    [BookManager saveBookMarkWithBookId:_readBook.bookId Chapter:_chapter curPage:_curPage];
}
#pragma mark  -- 获取章节

// 获取章节
- (BookChapter *)getBookChapter:(NSInteger)chapterIndex
{
    BookChapter *chapter = [_readBook openBookWithChapter:chapterIndex];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}
// 获取下一章
- (BookChapter *)getBookNextChapter
{
    BookChapter *chapter = [_readBook openBookNextChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}
// 获取上一章
- (BookChapter *)getBookPreChapter
{
    BookChapter *chapter = [_readBook openBookPreChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}
// 跳转章节
- (void)turnToBookChapter:(NSInteger)chapterIndex chapterOffset:(NSInteger)chapterOffset
{
    _chapter = [self getBookChapter:chapterIndex];
    NSInteger pageIndex = [_chapter pageIndexWithChapterOffset:chapterOffset];
    [self showBookWithPage:pageIndex];
}

#pragma mark -- LeftDelegate

-(void)updateBookChapterWithChapterIndex:(NSInteger)chapterIndex{
    
    [self turnToBookChapter:chapterIndex chapterOffset:0];
}

#pragma mark - view

-(UIView *)showPageView{
    if (!_showPageView) {
        _showPageView = ({
            UIView *view = [UIView new];
            view.hidden = YES;
            view.backgroundColor = [UIColor clearColor];
            
            UIView *backGroundView = [UIView new];
            backGroundView.backgroundColor = [UIColor whiteColor];
            backGroundView.alpha = 0.7;
            backGroundView.layer.cornerRadius = SET_WIDTH_(5);
            backGroundView.clipsToBounds = YES;
            [view addSubview:backGroundView];
            [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view);
            }];
            
            _showProcessTitleLabel = [UILabel new];
            _showProcessTitleLabel.textColor = [UIColor blackColor];
            _showProcessTitleLabel.font = [UIFont systemFontOfSize:12];
            _showProcessTitleLabel.textAlignment = 1;
            [view addSubview:_showProcessTitleLabel];
            [_showProcessTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.and.top.equalTo(view);
                make.height.mas_equalTo(SET_HEIGHT_(40));
            }];
            
            _showProcessPageLabel = [UILabel new];
            _showProcessPageLabel.textAlignment = 1;
            _showProcessPageLabel.font = [UIFont systemFontOfSize:12];
            _showProcessPageLabel.textColor = [UIColor blackColor];
            [view addSubview:_showProcessPageLabel];
            [_showProcessPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.and.bottom.equalTo(view);
                make.top.equalTo(_showProcessTitleLabel.mas_bottom);
            }];
            
            view;
        });
    }
    return _showPageView;
}
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
            
            _bookSlider = [[UISlider alloc] init];
            [_bookSlider addTarget:self action:@selector(changeBookProcessEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel];
            [_bookSlider addTarget:self action:@selector(showChangeProcessEvent:) forControlEvents:UIControlEventValueChanged];
            [view addSubview:_bookSlider];
            [_bookSlider mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(view.mas_top).offset(SET_HEIGHT_(10));
                make.left.equalTo(view.mas_left).offset(SET_WIDTH_(40));
                make.right.equalTo(view.mas_right).offset(-SET_WIDTH_(40));
                make.height.mas_equalTo(SET_HEIGHT_(20));
            }];
            
            _bookSlider.minimumValue = 0;
            _bookSlider.maximumValue = _readBook.totalChapter - 1;
            
            UIButton *preChapterBtn = [UIButton buttonWithType:0];
            preChapterBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [preChapterBtn setTitle:@"上一章" forState:UIControlStateNormal];
            [preChapterBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [preChapterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [preChapterBtn addTarget:self action:@selector(openPreChapterEvent) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:preChapterBtn];
            [preChapterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left);
                make.right.equalTo(_bookSlider.mas_left);
                make.centerY.equalTo(_bookSlider.mas_centerY);
                make.height.mas_equalTo(SET_HEIGHT_(80));
            }];
            
            UIButton *nextChapterBtn = [UIButton buttonWithType:0];
            nextChapterBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [nextChapterBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [nextChapterBtn setTitle:@"下一章" forState:UIControlStateNormal];
            [nextChapterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [nextChapterBtn addTarget:self action:@selector(openNextChapterEvent) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:nextChapterBtn];
            [nextChapterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_bookSlider.mas_right);
                make.right.equalTo(view.mas_right);
                make.centerY.equalTo(_bookSlider.mas_centerY);
                make.height.mas_equalTo(SET_HEIGHT_(80));
            }];
            
            WordsImageButton *muLubtn = [WordsImageButton buttonWithType:0];
            [muLubtn setImage:[UIImage imageNamed:@"Read_mulu"] withTitle:@"目录" titleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [muLubtn addTarget:self action:@selector(belowToolSelectedEvent:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:muLubtn];
            [muLubtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(SET_WIDTH_(20));
                make.top.equalTo(_bookSlider.mas_bottom).offset(SET_HEIGHT_(5));
                make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(60), SET_HEIGHT_(60)));
            }];
            
            WordsImageButton *shuqianBtn = [WordsImageButton buttonWithType:0];
            [shuqianBtn setImage:[UIImage imageNamed:@"Read_shuqian"] withTitle:@"书签" titleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shuqianBtn addTarget:self action:@selector(belowToolSelectedEvent:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:shuqianBtn];
            [shuqianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(view.mas_centerX);
                make.centerY.equalTo(muLubtn.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(60), SET_HEIGHT_(60)));
            }];
            
            WordsImageButton *fontBtn = [WordsImageButton buttonWithType:0];
            [fontBtn setImage:[UIImage imageNamed:@"Read_size"] withTitle:@"文字" titleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [fontBtn addTarget:self action:@selector(belowToolSelectedEvent:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:fontBtn];
            [fontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view.mas_right).offset(-SET_WIDTH_(20));
                make.centerY.equalTo(muLubtn.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(60), SET_HEIGHT_(60)));
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
            
            _bookmarkBtn = [UIButton buttonWithType:0];
            [_bookmarkBtn setImage:[UIImage imageNamed:@"ico_bookmark"] forState:UIControlStateNormal];
            [_bookmarkBtn setImage:[UIImage imageNamed:@"ico_bookmark_sel"] forState:UIControlStateSelected];
            [_bookmarkBtn addTarget:self action:@selector(bookMarkSelectedEvent:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_bookmarkBtn];
            [_bookmarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view.mas_right).offset(-SET_WIDTH_(10));
                make.centerY.equalTo(goBackBtn.mas_centerY);
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
-(UIView *)belowFontView{
    if (!_belowFontView) {
        _belowFontView = ({
            UIView *view = [UIView new];
            
            view.backgroundColor = [UIColor whiteColor];
            
            view;
        });
    }
    return _belowFontView;
}

@end
