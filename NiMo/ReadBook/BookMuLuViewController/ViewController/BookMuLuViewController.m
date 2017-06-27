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
}

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
    
    [self.view addSubview:self.muluTableView];
    [self.muluTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
        _lastSelectedCell.chapterTitleLabel.font = [UIFont systemFontOfSize:14];
        _lastSelectedCell.chapterTitleLabel.textColor = [UIColor blackColor];
    }
    MuluTableViewCell *chapterCell = (MuluTableViewCell *)[self.muluTableView cellForRowAtIndexPath:indexPath];
    chapterCell.chapterTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    chapterCell.chapterTitleLabel.textColor = [UIColor redColor];
    _lastSelectedCell = chapterCell;
}

#pragma mark -- view

-(UITableView *)muluTableView{
    
    if (!_muluTableView) {
        _muluTableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
            view.dataSource = self;
            view.delegate = self;
            
            [view registerClass:[MuluTableViewCell class] forCellReuseIdentifier:muluCellIdentifier];
            
            view;
        });
    }
    return _muluTableView;
}
@end
