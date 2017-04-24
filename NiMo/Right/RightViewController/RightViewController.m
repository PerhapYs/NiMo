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
    
//    self.view.backgroundColor = [UIColor redColor];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    
    [self intializeInterface];
}


-(void)intializeInterface{
    
    UISwitch *changeBackGroundColor  = [[UISwitch alloc] init];
    changeBackGroundColor.frame = CGRectMake(20, 50, 100, 100);
    [changeBackGroundColor addTarget:self action:@selector(changeBGColorEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBackGroundColor];
}

-(void)changeBGColorEvent:(UISwitch *)btn{
    
    if (btn.on) {
        [[DKNightVersionManager sharedManager] setThemeVersion:DKThemeVersionNight];
    }
    else{
        [[DKNightVersionManager sharedManager] setThemeVersion:DKThemeVersionNormal];
    }
}

    
    
@end
