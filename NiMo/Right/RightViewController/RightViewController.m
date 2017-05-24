//
//  RightViewController.m
//  PerhapysProductOne
//
//  Created by PerhapYs on 17/4/21.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self intializeInterface];
}


-(void)intializeInterface{
    
    UISwitch *changeBackGroundColor  = [[UISwitch alloc] init];
    changeBackGroundColor.frame = CGRectMake(20, 50, 100, 100);
    [changeBackGroundColor addTarget:self action:@selector(changeBGColorEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBackGroundColor];
    
    UIButton *readStyleBtn = [UIButton buttonWithType:0];
    [readStyleBtn setTitle:@"修改翻页格式" forState:UIControlStateNormal];
    [readStyleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [readStyleBtn addTarget:self action:@selector(changeReadStyle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readStyleBtn];
    [readStyleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeBackGroundColor.mas_bottom).offset(SET_HEIGHT_(40));
        make.centerX.equalTo(changeBackGroundColor.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SET_WIDTH_(100), SET_HEIGHT_(50)));
    }];
}
-(void)changeReadStyle{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改格式" message:@"" delegate:self cancelButtonTitle:@"翻页" otherButtonTitles:@"滚动", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:@(buttonIndex) forKey:@"bookTransitionStyle"];
}
-(void)changeBGColorEvent:(UISwitch *)btn{
    
}

    
    
@end
