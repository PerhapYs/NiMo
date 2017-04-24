//
//  CenterViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/4/21.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "CenterViewController.h"
#import "UIImage+PerhapYs.h"

#import "BooksCollectionViewCell.h"
@interface CenterViewController ()<UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *booksCV;

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"霓墨";
     self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    
    [self initializeInterface];
}
#pragma mark -- interface

-(void)initializeInterface{
    
    UIButton *leftImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftImage setImage:[UIImage imageNamed:@"defaultI_icon.jpg"] forState:UIControlStateNormal];
    [leftImage setImage:[UIImage imageNamed:@"defaultI_icon.jpg"] forState:UIControlStateHighlighted];
    [leftImage addTarget:self action:@selector(openLeft) forControlEvents:UIControlEventTouchUpInside];
    leftImage.frame = CGRectMake(0, 0, SET_WIDTH_(40), SET_HEIGHT_(40));
    
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithCustomView:leftImage];

    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftbutton];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigation_listImage.jpg"] reSizeImagetoSize:CGSizeMake(40, 40)] style:UIBarButtonItemStyleDone target:self action:@selector(openRight)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self.view addSubview:self.booksCV];
    [self.booksCV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(SET_HEIGHT_(20));
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(SET_WIDTH_(20));
        make.right.equalTo(self.view.mas_right).offset(-SET_WIDTH_(20));
    }];
}


#pragma mark -- getter

-(UICollectionView *)booksCV{
    if (!_booksCV) {
        _booksCV = ({
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(SET_WIDTH_(100), SET_HEIGHT_(150));
            
            UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
            view.backgroundColor = [UIColor clearColor];
            view.dataSource = self;
            view.showsVerticalScrollIndicator = NO;
            view.decelerationRate = 0;
            [view registerClass:[BooksCollectionViewCell class] forCellWithReuseIdentifier:@"booksCell"];
            
            view;
        });
    }
    return _booksCV;
}

#pragma mark -- CollectionView dataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BooksCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"booksCell" forIndexPath:indexPath];
    [cell placeCellDataWithDic:nil];
    return cell;
}
#pragma mark -- barButton Event

-(void)openLeft{
   
    [[TopRoute shareRoute].MMDrawerC toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
       
    }];
}

-(void)openRight{
    
    [[TopRoute shareRoute].MMDrawerC toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
    }];
}
@end
