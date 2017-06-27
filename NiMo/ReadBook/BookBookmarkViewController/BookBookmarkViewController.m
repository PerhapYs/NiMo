//
//  BookBookmarkViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/6/26.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookBookmarkViewController.h"
#import "BookmarkTableViewCell.h"

static NSString * const bookmarkCellIdentifier = @"cellForBookmarkTableViewCell";

@interface BookBookmarkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *bookmarkTableView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation BookBookmarkViewController

+ (instancetype)shareBookmark{
    static dispatch_once_t onceToken;
    static id shareId = nil;
    @synchronized(self) {
        dispatch_once(&onceToken, ^{
            shareId = [[[self class] alloc] init];
        });
        return shareId;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"书签";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeData];
    [self initializeInterface];
}

-(void)initializeData{
    
    NSLog(@"🌹%ld",_bookId);
    
    _dataSource = [[NSMutableArray alloc] init];
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
            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            [view registerClass:[BookmarkTableViewCell class] forCellReuseIdentifier:bookmarkCellIdentifier];
            
            view;
        });
    }
    return _bookmarkTableView;
}
@end
