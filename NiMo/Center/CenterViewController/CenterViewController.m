//
//  CenterViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/4/21.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "CenterViewController.h"
#import "UIImage+PerhapYs.h"


@interface CenterViewController ()

@property (nonatomic , strong) UICollectionView *booksCV;

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"霓墨";
    
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
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
}


#pragma mark -- getter

-(UICollectionView *)booksCV{
    if (!_booksCV) {
        _booksCV = ({
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(50, 100);
            
            UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
            
            view;
        });
    }
    return _booksCV;
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
