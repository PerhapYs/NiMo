//
//  BookBookmarkViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/6/26.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookBookmarkViewController.h"
#import "BookmarkTableViewCell.h"
#import "BookMark.h"

static NSString * const bookmarkCellIdentifier = @"cellForBookmarkTableViewCell";

@interface BookBookmarkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *bookmarkTableView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation BookBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"书签";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initializeData];
    [self initializeInterface];
}

-(void)initializeData{
    
    _dataSource = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_queue_create("com.tany.searchMarkDb", DISPATCH_QUEUE_SERIAL), ^{
        // 异步操作
        NSMutableArray *selectedArray = [BookMark dbObjectsWithBookId:_bookId];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            // 主线程更新
            _dataSource = selectedArray;
            [self.bookmarkTableView reloadData];
        });
    });
    
}
-(void)initializeInterface{
    
    [self.view addSubview:self.bookmarkTableView];
    [self.bookmarkTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark ---  tableView DataSouce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookmarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bookmarkCellIdentifier];
    [cell placeSubViewWithData:_dataSource[indexPath.row]];
    
    return cell;
}
#pragma mark - getter

-(UITableView *)bookmarkTableView{
    if (!_bookmarkTableView) {
        _bookmarkTableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
            
            view.delegate = self;
            view.dataSource = self;
            view.rowHeight = SET_HEIGHT_(50);
//            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            [view registerClass:[BookmarkTableViewCell class] forCellReuseIdentifier:bookmarkCellIdentifier];
            
            view;
        });
    }
    return _bookmarkTableView;
}
@end
