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
    
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"defaultI_icon.jpg"] reSizeImagetoSize:CGSizeMake(40, 40)] style:UIBarButtonItemStyleDone target:self action:@selector(openLeft)];
    self.navigationItem.leftBarButtonItem = leftbutton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"打开右边" style:UIBarButtonItemStylePlain target:self action:@selector(openRight)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

#pragma mark -- barButton Event

-(void)openLeft{
    
    
    [[TopRoute shareRoute].MMDrawerC toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        NSLog(@"🌹");
    }];
}

-(void)openRight{
    
    [[TopRoute shareRoute].MMDrawerC toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        NSLog(@"🌹");
    }];
}
@end
