//
//  CenterViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/4/21.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"中间";
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithTitle:@"打开左边" style:UIBarButtonItemStylePlain target:self action:@selector(openLeft)];
    
    self.navigationItem.leftBarButtonItem = leftbutton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"打开右边" style:UIBarButtonItemStylePlain target:self action:@selector(openRight)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
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
