//
//  BookMuLuViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/5/9.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookMuLuViewController.h"
#import "BookChapter.h"
#import "BookManager.h"
#import "MuluTableViewCell.h"

static NSString * const muluCellIdentifier = @"cellForMuluTableViewCell";
@interface BookMuLuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    MuluTableViewCell *_lastSelectedCell;  // 记录上一次的目录cell
    NSInteger _lastIndexPathRow;
}

@property (nonatomic , strong) UIView *titleView;

@property (nonatomic , strong) UITableView *muluTableView;

@end

@implementation BookMuLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initializeInterface];
}

-(void)initializeInterface{
    
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.mas_equalTo(SET_HEIGHT_(50));
    }];
    
    [self.view addSubview:self.muluTableView];
    [self.muluTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).offset(SET_HEIGHT_(5));
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-SET_HEIGHT_(10));
    }];
}
#pragma mark ---  tableView DataSouce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _DataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MuluTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muluCellIdentifier];
    
    BookChapter *chapter = (BookChapter *)_DataSource[indexPath.row];

    [cell placeSuviewWithDataSource:chapter];
    if (indexPath.row == _lastIndexPathRow) {
        cell.chapterTitleLabel.textColor = [UIColor redColor];
    }
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[BookManager shareBook].bookMMD closeDrawerAnimated:YES completion:^(BOOL finished) {
        
        [self.centerDelegate updateBookChapterWithChapterIndex:indexPath.row];
    }];
}

#pragma mark -- CenterDelegate
-(void)updateLeftViewControllerTableViewWithChapter:(BookChapter *)chapter{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chapter.chapterIndex inSection:0];
    
    [self.muluTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    if (_lastSelectedCell) {
        _lastSelectedCell.chapterTitleLabel.textColor = [UIColor blackColor];
    }
    MuluTableViewCell *chapterCell = (MuluTableViewCell *)[self.muluTableView cellForRowAtIndexPath:indexPath];
    chapterCell.chapterTitleLabel.textColor = [UIColor redColor];
    _lastSelectedCell = chapterCell;
    _lastIndexPathRow = chapter.chapterIndex;
}

#pragma mark -- view
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = ({
            UIView *view = [UIView new];
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = @"目录";
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont systemFontOfSize:14];
            [view addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view.mas_left).offset(SET_WIDTH_(20));
                make.bottom.equalTo(view.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(100), SET_HEIGHT_(30)));
            }];
            
            UIView *belowLineView = [UIView new];
            belowLineView.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:belowLineView];
            [belowLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.and.bottom.equalTo(view);
                make.height.mas_equalTo(SET_HEIGHT_(1));
            }];
            
            view;
        });
    }
    return _titleView;
}
-(UITableView *)muluTableView{
    
    if (!_muluTableView) {
        _muluTableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
            view.dataSource = self;
            view.delegate = self;
            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [view registerClass:[MuluTableViewCell class] forCellReuseIdentifier:muluCellIdentifier];
            
            view;
        });
    }
    return _muluTableView;
}
@end
