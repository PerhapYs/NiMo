//
//  BookMuLuViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/5/9.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookMuLuViewController.h"
#import "BookChapter.h"
@interface BookMuLuViewController ()<UITableViewDataSource>

@end

@implementation BookMuLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    view.dataSource = self;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark ---  tableView DataSouce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _DataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    BookChapter *chapter = (BookChapter *)_DataSource[indexPath.row];
    cell.textLabel.text = chapter.chapterTitle;
    
    return cell;
}

@end
